resource "local_file" "appspec" {
  count = var.deployment_controller == "CODE_DEPLOY" ? 1 : 0

  filename = "${path.module}/${aws_codedeploy_app.main[count.index].name}.yaml"

  content = templatefile("${path.module}/files/codedeploy/appspec.yaml.tpl", {
    APPLICATION_NAME    = aws_codedeploy_app.main[count.index].name
    TASK_DEFINITION_ARN = aws_ecs_task_definition.main.arn
    CONTAINER_NAME      = var.service_name
    CONTAINER_PORT      = var.service_port
    CAPACITY_PROVIDERS  = var.service_launch_type
  })
}
