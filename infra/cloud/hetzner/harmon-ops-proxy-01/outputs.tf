output "server_ipv4" {
  description = "Public IPv4 address of the server"
  value       = hcloud_server.proxy.ipv4_address
}

output "server_ipv6" {
  description = "Public IPv6 address of the server"
  value       = hcloud_server.proxy.ipv6_address
}

output "server_id" {
  description = "Hetzner server ID"
  value       = hcloud_server.proxy.id
}

output "server_status" {
  description = "Current server status"
  value       = hcloud_server.proxy.status
}

output "server_location" {
  description = "Location where the server is hosted"
  value       = hcloud_server.proxy.location
}
