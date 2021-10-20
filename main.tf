provider "aws" {
  region  = var.region
}

module "dns_and_ssl" {

  source = "./modules/dns_and_ssl/"
  
  
  domain_name                                           = var.domain_name
  cname                                                 = module.eb.cname
  zone                                                  = module.eb.zone
}

module "eb" {

  source = "./modules/beanstalk/"
  
  
  app_tags                          = var.app_tags
  application_name                  = var.application_name
  vpc_id                            = var.vpc_id
  ec2_subnets                       = var.ec2_subnets
  elb_subnets                       = var.elb_subnets
  instance_type                     = var.instance_type
  disk_size                         = var.disk_size
  keypair                           = var.keypair
  sshrestrict                       = var.sshrestrict
  certificate                       = module.dns_and_ssl.certificate
}



module "cloudwatch" {

  source = "./modules/cloudwatch/"
  
  
  app_tags                                              = var.app_tags
  alarm_sns_topic                                       = var.alarm_sns_topic
  asgName                                               = module.eb.asgName
  envName                                               = module.eb.envName
  lbarn                                                 = module.eb.lbarn
}
