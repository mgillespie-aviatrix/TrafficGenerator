resource "aws_security_group" "mysg-default" {
    name = "mysg-default"
    vpc_id = var.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]   
    }
    ingress {
        from_port = 21
        to_port = 21
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]   
    }
    ingress {
        from_port = 23
        to_port = 23
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]   
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]   
    }
    ingress {
        from_port = 143
        to_port = 143
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]   
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]   
    }
    ingress {
        from_port = 1433
        to_port = 1433
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]   
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]   
    }
    ingress {
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]   
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]   
    }
}

resource "aws_network_interface" "test-flower" {
    count = var.instance_count
    subnet_id = var.subnet_id
    tags = { Name = "test-flower${count.index}-eni"}
    security_groups = [aws_security_group.mysg-default.id]
}

output "eni-private-ips" {
  value = aws_network_interface.test-flower.*.private_ip
  description = "Test Descriptio"
}

resource "aws_instance" "traffic-flower"{
    count = var.instance_count
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.default_ssh_key
    tags = { 
        Name = "traffic-flower-${count.index}"
        Automated-Shutdown-Enabled = true
    }

    network_interface {
            network_interface_id = aws_network_interface.test-flower[count.index].id
            device_index=0
    }

     depends_on = [
       aws_network_interface.test-flower
     ]
     
    user_data = <<EOT
      #!/bin/bash -xe
      cd /tmp/
      wget https://github.com/mgillespie-aviatrix/TrafficGenerator/raw/main/RPMs/trafficgenerator-0.0.1-1.amzn2.noarch.rpm
      sudo yum -y install iperf3
      sudo rpm -i trafficgenerator-0.0.1-1.amzn2.noarch.rpm
      %{ for ip in aws_network_interface.test-flower.*.private_ip ~}
      echo ${ip} | sudo tee -a /usr/local/etc/client_traffic_generator.servers
      %{ endfor }
      sudo systemctl start client_traffic_generator
      EOT

}
