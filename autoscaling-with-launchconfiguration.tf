module "autoscaling_example_complete" {
  source  = "terraform-aws-modules/autoscaling/aws//examples/complete"
  version = "4.1.0"
  #autoscaling group
  name = "${local.name}-myag1"
  use_name_prefix = false
  min_size = 2
  max_size = 8
  desired_capacity = 4
  wait_for_capacity_timeout = 0
  health_check_type = "EC2"
  #vpc_zone_identifier = module.vpc.private_subnets
  service_linked_role_arn = aws_iam_service_linked_role.autoscaling.arn 
  target_group_arns = module.alb.target_group_arns
  #ASG life cycle hooks
  intial_lifecycle_hooks = [
  {
    name = "Startup Life Cycle Hook"
    default_result = continue
    heartbeat_timeout = 60
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
    notification_metadata = jsonencode({"hello"="world"})
  },
  {
    name = "Termination Life Cycle Hook"
    default_result = continue
    heartbeat_timeout = 180
    lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATION"
    notification_metadata = jsonencode({"goodbye"="world"})
  }
  ]
  #ASG Instance refresh
  instance_refresh = {
   strategy = "Rolling"
   preferences = {
       min_healthy_percentage = 50
   }
   trigger = ["tag","desired_capacity"]
  }
  #ASG launch configuration
  lc_name = "${local.name}-mylc1"
  use_lc = true
  create_lc = true

  image_id = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  user_data = file("${path.module/app1-install.sh}")
  ebs_optimized = true
  enable_monitoring = true 
  security_groups = [module.private_sg.security_groups_id]
  associate_public_ip_address = false
  #we will create spot instance
  spot_price = "0.016"

  ebs_block_device = [
      {
          device_name = "/dev/xvdz"
          delete_on_termination = true
          encrypted = true
          volume_type = "gp2"
          volume_size = "20"
      },
  ]
  root_block_device = [
    {
          delete_on_termination = true
          encrypted = true
          volume_type = "gp2"
          volume_size = "15"
      },
    
]

tags = local.asg_tags
}
