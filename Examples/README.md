# TrafficGenerator examples

This contains examples of how to use Terraform to create instances devoted to simulating traffic flow.

This simply spins up an AWS Linux instance, performs a yum install of IPERF3, downloads and installs the signed RPM containing the SystemD scripts, adds the private IP addresses of each instance into the configuration, and begins the traffic flow client.

In this current example, the instances are provisioned in the same VPC and subnet. Future examples will expand this to be more robust and drop instances in various VPCs and subnets.