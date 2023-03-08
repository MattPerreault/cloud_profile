output "rest_api_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}${aws_api_gateway_stage.prod_stage.stage_name}${aws_api_gateway_resource.rest_api_resource.path}"
}
