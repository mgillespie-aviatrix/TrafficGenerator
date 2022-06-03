variable "keypath" {
    default = "/Users/matthewgillespie/.ssh/AWSVMKey.pem"
}

variable "default_ssh_key" {
    type = string  
    description = "The default SSH key to use."
    default = "AWSVMKey"
}

variable "instance_count" {
    type = string
    description = "Count of ec2 instances to create"
}

variable "instance_type" {
    type = string
    description = "Type of instance to created"
    default = "t2.micro"
  
}

#This should simply be derived from the subnet 
variable "vpc_id" {
    type = string
    description = "VPC to create instances in"
}

variable "subnet_id" {
    type = string
    description = "Subnet to create instances in"
}

variable "ami_id" {
    type = string
    description = "AMI ID to use"
}