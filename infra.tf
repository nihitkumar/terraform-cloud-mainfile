module "dev_vpc_1" {
  source             = "app.terraform.io/modules-in-cloud/network/cloud"
  version            = "1.0.0"
  vpc_cidr           = "10.90.0.0/16"
  vpc_name           = "dev_vpc_1"
  environment        = "Development"
  public_cidr_block  = ["10.90.1.0/24", "10.90.2.0/24", "10.90.3.0/24"]
  private_cidr_block = ["10.90.10.0/24", "10.90.20.0/24", "10.90.30.0/24"]
  azs                = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  natgw_id           = module.dev_natgw_1.natgw_id
}

module "dev_natgw_1" {
  source           = "app.terraform.io/modules-in-cloud/nat/cloud"
  version          = "1.0.0"
  public_subnet_id = module.dev_vpc_1.public_subnets_id_1
  vpc_name         = module.dev_vpc_1.vpc_name
}
