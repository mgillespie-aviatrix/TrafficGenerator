# TrafficGenerator examples

This contains examples of how to use Terraform to create instances devoted to simulating traffic flow.

This simply spins up an AWS Linux instance, performs a yum install of IPERF3, downloads and installs the signed RPM containing the SystemD scripts, adds the private IP addresses of each instance into the configuration, and begins the traffic flow client.

Note: I've just begun migrating the vpc and subnet variables to a list. At the current time, this only works in a single VPC... (due to how it needs to create a security group for each VPC and associate the correct SG to the ENI). I'll iron that out in the upcoming days.
