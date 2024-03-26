module "jumphost" {
  source                   = "registry.infrahouse.com/infrahouse/jumphost/aws"
  version                  = "~> 2.3"
  environment              = local.environment
  keypair_name             = aws_key_pair.test.key_name
  route53_zone_id          = data.aws_route53_zone.cicd.zone_id
  subnet_ids               = var.subnet_public_ids
  nlb_subnet_ids           = var.subnet_public_ids
  asg_min_size             = 1
  asg_max_size             = 1
  puppet_hiera_config_path = "/opt/infrahouse-puppet-data/environments/${local.environment}/hiera.yaml"
  packages = [
    "infrahouse-puppet-data"
  ]
  ssh_host_keys = [
    {
      type : "rsa"
      private : file("${path.module}/ssh_keys/ssh_host_rsa_key")
      public : file("${path.module}/ssh_keys/ssh_host_rsa_key.pub")
    },
    {
      type : "ecdsa"
      private : file("${path.module}/ssh_keys/ssh_host_ecdsa_key")
      public : file("${path.module}/ssh_keys/ssh_host_ecdsa_key.pub")
    },
    {
      type : "ed25519"
      private : file("${path.module}/ssh_keys/ssh_host_ed25519_key")
      public : file("${path.module}/ssh_keys/ssh_host_ed25519_key.pub")
    }
  ]
}
