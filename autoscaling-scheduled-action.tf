resource "aws_autoscaling_schedule" "increase_capacity_9am" {
  scheduled_action_name = "increase-capacity-9am"
  min_size = 4
  max_size = 10
  desired_capacity = 8
  start_time = "2021-09-09T18:00:00Z"
  recurrence = "00 09 * * *"
  autoscaling_group_name = module.autoscaling.autoscaling_group_id
}
resource "aws_autoscaling_schedule" "decrease_capacity_9pm" {
  scheduled_action_name = "increase-capacity-9pm"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  start_time = "2021-09-09T18:00:00Z"
  recurrence = "00 21 * * *"
  autoscaling_group_name = module.autoscaling.autoscaling_group_id
}