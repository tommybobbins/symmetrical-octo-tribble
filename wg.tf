resource "null_resource" "client_keys" {
  provisioner "local-exec" {
    command = "/usr/bin/wg genkey | tee client_private.key | wg pubkey > client_public.key"
  }
}

resource "null_resource" "server_keys" {
  provisioner "local-exec" {
    command = "/usr/bin/wg genkey | tee server_private.key | wg pubkey > server_public.key"
  }
}

data "local_file" "server_pubkey" {
  filename   = "server_public.key"
  depends_on = [null_resource.server_keys]
}

data "local_file" "server_privkey" {
  filename   = "server_private.key"
  depends_on = [null_resource.server_keys]
}

data "local_file" "client_pubkey" {
  filename   = "client_public.key"
  depends_on = [null_resource.client_keys]
}

data "local_file" "client_privkey" {
  filename   = "client_private.key"
  depends_on = [null_resource.client_keys]
}


output "server_priv" {
  value = data.local_file.server_privkey.content
}

output "server_pub" {
  value = data.local_file.server_pubkey.content
}

output "client_priv" {
  value = data.local_file.client_privkey.content
}

output "client_pub" {
  value = data.local_file.client_pubkey.content
}

resource "local_file" "server_endpoint" {
  content  = aws_instance.wg.public_ip
  filename = "server_endpoint.txt"
}

