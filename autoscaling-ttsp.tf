resource "aws_autoscaling_policy" "avg_cpu_policy_greater_than_xx" {
    name = "avg_cpu_policy_greater_than_xx"
    policy_type = "TargetTrackingScaling"
    autoscaling_group_name = module.autoscaling.autoscaling_group_id
    estimated_instance_warmup = 180

    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
      target_value = 50.0
    }
  
}
resource "aws_autoscaling_policy" "avg_target_requests_greater_than_yy" {
    name = "avg_target_requests_greater_than_yy"
    policy_type = "TargetTrackingScaling"
    autoscaling_group_name = module.autoscaling.autoscaling_group_id
    estimated_instance_warmup = 180

    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ALBRequestCountPerTarget"
        resource_label = "${module.alb.lb_arn_suffic}/${module.alb.target_group_arn_suffixes[0]}"
      }
      target_value = 50.0
    }
  
}