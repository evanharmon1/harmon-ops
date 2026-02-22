terraform {
  required_version = ">= 1.5"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.49"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "evan" {
  name       = "evan_harmonops.com"
  public_key = file(pathexpand(var.ssh_public_key_path))

  lifecycle {
    ignore_changes = [public_key]
  }
}

resource "hcloud_firewall" "proxy" {
  name = "firewall-1"

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips  = ["0.0.0.0/0", "::/0"]
    description = "SSH"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "80"
    source_ips  = ["0.0.0.0/0", "::/0"]
    description = "HTTP"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "443"
    source_ips  = ["0.0.0.0/0", "::/0"]
    description = "HTTPS"
  }
}

resource "hcloud_server" "proxy" {
  name        = var.server_name
  server_type = var.server_type
  location    = var.server_location
  image       = var.server_image
  user_data   = file("${path.module}/cloud-init.yml")

  ssh_keys = [hcloud_ssh_key.evan.id]

  firewall_ids = [hcloud_firewall.proxy.id]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  labels = {
    role    = "proxy"
    project = "harmon-ops"
  }

  lifecycle {
    ignore_changes = [image, user_data, ssh_keys]
  }
}
