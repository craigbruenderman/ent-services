resource "aws_directory_service_directory" "ad_ds" {
  name     = "corp.notexample.com"
  password = "SuperSecretPassw0rd"
  edition  = "Standard"
  type     = "MicrosoftAD"

  vpc_settings {
    vpc_id     = aws_vpc.services_vpc.id
    subnet_ids = [
      aws_subnet.ad_snet_1.id,
      aws_subnet.ad_snet_2.id
    ]
  }

  tags = {
    Name = "Managed AD Directory"
  }
}

resource "aws_subnet" "ad_snet_1" {
  vpc_id       = aws_vpc.services_vpc.id
  region       = var.AWS_REGION
  cidr_block   = var.AD_SNET_1
  availability_zone = var.AD_SNET_1_AZ

  tags = {
    Name = "snet-ad-1"
  }
}

resource "aws_subnet" "ad_snet_2" {
  vpc_id       = aws_vpc.services_vpc.id
  region       = var.AWS_REGION
  cidr_block   = var.AD_SNET_2
  availability_zone = var.AD_SNET_2_AZ

  tags = {
    Name = "snet-ad-2"
  }
}