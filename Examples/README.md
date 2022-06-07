# TrafficGenerator examples

This contains examples of how to use Terraform to create instances devoted to simulating traffic flow.

This simply spins up an AWS Linux instance, performs a yum install of IPERF3, downloads and installs the signed RPM containing the SystemD scripts, adds the private IP addresses of each instance into the configuration, and begins the traffic flow client.

Note: I've just added support for multiple VPCs. At a later time I'll derive VPC ID from the subnets the systems are deployed in. I need to improve the security group creation so that if for some reason multiple nodes are deployed in the same VPC it won't fail creating a duplicate security group.
