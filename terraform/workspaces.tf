data "aws_workspaces_bundle" "value_windows_10" {
  bundle_id = "wsb-gqbt42cw7"
}

data "aws_kms_key" "workspaces" {
  key_id = "alias/aws/workspaces"
}

resource "aws_subnet" "workspaces_snet_1" {
  vpc_id       = aws_vpc.services_vpc.id
  region       = var.AWS_REGION
  cidr_block   = var.WORKSPACES_SNET_1
  availability_zone = var.WORKSPACES_SNET_1_AZ

  tags = {
    Name = "snet-workspaces-1"
  }
}

resource "aws_subnet" "workspaces_snet_2" {
  vpc_id       = aws_vpc.services_vpc.id
  region       = var.AWS_REGION
  cidr_block   = var.WORKSPACES_SNET_2
  availability_zone = var.WORKSPACES_SNET_2_AZ

  tags = {
    Name = "snet-workspaces-2"
  }
}

resource "aws_workspaces_directory" "workspaces_directory" {
  directory_id = aws_directory_service_directory.ad_ds.id
  subnet_ids = [ 
    aws_subnet.workspaces_snet_1.id,
    aws_subnet.workspaces_snet_2.id
   ]
  
  tags = {
    Name = "WorkSpaces Directory"
  }
}

resource "aws_workspaces_workspace" "workspace" {
  region = var.AWS_REGION
  directory_id = aws_workspaces_directory.workspaces_directory.id
  bundle_id    = data.aws_workspaces_bundle.value_windows_10.id
  user_name    = "john.doe"

  root_volume_encryption_enabled = true
  user_volume_encryption_enabled = true
  volume_encryption_key          = data.aws_kms_key.workspaces.arn

  workspace_properties {
    compute_type_name                         = "VALUE"
    user_volume_size_gib                      = 10
    root_volume_size_gib                      = 80
    running_mode                              = "AUTO_STOP"
    running_mode_auto_stop_timeout_in_minutes = 60
  }
}