resource "aws_iam_service_linked_role" "autoscaling" {
  aws_service_name = "autoscaling.amazonaws.com"
  custom_suffix = local.name 
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

#output aws IAM service linked role
output "service_linked_role_arn" {
  value = aws_iam_service_linked_role.autoscaling.arn
}