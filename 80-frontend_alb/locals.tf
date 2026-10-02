locals{
    common_tags = {
        project = var.project
        Terraform = true
        environment = var.environment
    }

    frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
    public_subnet_id = split(",",data.aws_ssm_parameter.public_subnet_ids.value)[0]
    frontend_alb_certificate_arn = data.aws.ssm_parameter.frontend_alb_certificate_arn.value
}