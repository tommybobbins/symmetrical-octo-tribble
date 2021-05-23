data "template_file" "init" {
  template = file("userdata.sh")
  vars = {
    project_name       = var.project_name
#    aws_region         = lookup(var.stage_regions, var.Stage)
  }
}
