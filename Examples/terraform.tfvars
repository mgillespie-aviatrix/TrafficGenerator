#List of VPCs to create our security groups in. This should later be moved to data source lookups.
vpc_ids=[""]
default_ssh_key = ""
#Subnets to spawn EC2 traffic instances in.
subnet_ids = ["subnet-XXXX","subnet-XXXX", "subnet-XXXX", "subnet-XXX"]
ami_id = "XXXX"
client_service_default = "disable"
client_service_action = "start"
