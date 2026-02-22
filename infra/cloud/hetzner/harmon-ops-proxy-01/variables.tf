variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "server_name" {
  description = "Name of the server"
  type        = string
  default     = "harmon-ops-proxy-01"
}

variable "server_type" {
  description = "Hetzner server type (e.g. cx11, cx22, cx32)"
  type        = string
  default     = "cx11"
}

variable "server_location" {
  description = "Hetzner datacenter location"
  type        = string
  default     = "ash"
}

variable "server_image" {
  description = "OS image for the server"
  type        = string
  default     = "ubuntu-24.04"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/evan_harmonops.com.pub"
}