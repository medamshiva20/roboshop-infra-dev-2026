data "aws_ami" "sivadevops"{
    most_recent = true
    owners = ["166044977463"]

    filter {
        name = "name"
        values = ["Siva_AMI"]
    }

    filter {
        name = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_ssm_parameter" "database_subnet_ids"{
    name = "/${var.project}/${var.environment}/database_subnet_ids"
}

data "aws_ssm_parameter" "mongodb_sg_id"{
    name = "/${var.project}/${var.environment}/mongodb_sg_id"
}