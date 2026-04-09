module "dev_compute_1" {
  source      = "app.terraform.io/modules-in-cloud/compute/cloud"
  version     = "1.0.0"
  environment = module.dev_vpc_1.environment
  amis = {
    ap-south-1 = "ami-05d2d839d4f73aafb"

  }
  aws_region           = var.aws_region
  instance_type        = "t3.nano"
  key_name             = "mumkey"
  iam_instance_profile = module.dev_iam_1.instprofile
  public_subnets       = module.dev_vpc_1.public_subnets_id
  private_subnets      = module.dev_vpc_1.private_subnets_id
  sg_id                = module.dev_sg_1.sg_id
  vpc_name             = module.dev_vpc_1.vpc_name
  elb_listener         = module.dev_elb_1.elb_listner
  elb_listener_public  = module.dev_elb_1_public.elb_listner
}

module "dev_elb_1" {
  source          = "app.terraform.io/modules-in-cloud/dev/cloud"
  version         = "1.0.0"
  environment     = module.dev_vpc_1.environment
  nlbname         = "dev-nlb"
  subnets         = module.dev_vpc_1.public_subnets_id
  tgname          = "dev-nlb-tg"
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_compute_1.private_servers
}

module "dev_elb_1_public" {
  source          = "app.terraform.io/modules-in-cloud/elb/cloud"
  version         = "1.0.0"
  environment     = module.dev_vpc_1.environment
  nlbname         = "dev-nlb-public"
  subnets         = module.dev_vpc_1.public_subnets_id
  tgname          = "dev-nlb-tg-public"
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_compute_1.public_servers
}

module "dev_iam_1" {
  source              = "app.terraform.io/modules-in-cloud/iam/cloud"
  version             = "1.0.0"
  environment         = module.dev_vpc_1.environment
  rolename            = "NihitTMRole"
  instanceprofilename = "NihitTMinstprofile"
}