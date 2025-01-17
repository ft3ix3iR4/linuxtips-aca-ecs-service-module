resource "aws_codedeploy_app" "main" {
  count            = var.deployment_controller == "CODE_DEPLOY" ? 1 : 0
  name             = format("%s-%s", var.cluster_name, var.service_name)
  compute_platform = "ECS"
}
