variable "default_ssh_key" {
  type        = string
  description = "The default SSH key to use."
  default     = "AWSVMKey"
}
variable "instance_type" {
  type        = string
  description = "Type of instance to created"
  default     = "t2.micro"

}

#This should simply be derived from the subnet 
variable "vpc_ids" {
  type        = list(any)
  description = "List of VPCs to create security groups in (for traffic-flower)"
}

variable "subnet_ids" {
  type        = list(any)
  description = "List of subnets to create instances in"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use"
}

variable "client_service_default" {
  type        = string
  description = "SystemD default for client traffic generator service (enabled/disabled) at boot"
  default     = "disable"
}
variable "client_service_action" {
  type        = string
  description = "SystemD default action for client traffic generator service (start/stop)"
  default     = "start"
}

variable "url_list" {
  type        = list(string)
  description = "List of URLs to issue CURL requests against"
  default     = ["www.google.com", "www.aviatrix.com", "www.bitcoin.org", "www.yahoo.com", "www.facebook.com"]
}

