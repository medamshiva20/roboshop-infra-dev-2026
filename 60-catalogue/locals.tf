locals{
    ami_id = data.aws_ami.sivadevops.id
    common_tags = {
        project = var.project
        Terraform = true
        environment = var.environment
    }
    private_subnet_id = split(",",data.aws_ssm_parameter.private_subnet_ids.value)[0]
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
    backend_alb_listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}