data "template_file" "init" {
  template = file("userdata.sh")
  vars = {
    project_name       = var.project_name
#    aws_region         = lookup(var.stage_regions, var.Stage)
    server_priv_key     = data.local_file.server_privkey.content
    server_pub_key      = data.local_file.server_pubkey.content
    client_pub_key      = data.local_file.client_pubkey.content

  }
}
