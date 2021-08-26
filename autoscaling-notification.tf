#sns Topic
resource "aws_sns_topic" "myasg_sns_topic" {
  name  = "my-sns-topic-${random_pet.this.id}"
}
#sns subscription
resource "aws_sns_topic_subscription" "myasg_sns_topic_subscription" {
  topic_arn = aws_sns_topic.myasg_sns_topic.arn 
  protocol = "email"
  endpoint = "gopal1409@gmail.com"
}

#create autoscaling notification resources
resource "aws_autoscaling_notification" "myasg_notification" {
  group_names = [module.autoscaling.autoscaling_group_id]
  notifications = [
      "autoscaling:EC2_INSTANCE_LAUNCH",
      "autoscaling:EC2_INSTANCE_TERMINATE",
      "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
      "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
  topic_arn = aws_sns_topic.myasg_sns_topic.arn 
}