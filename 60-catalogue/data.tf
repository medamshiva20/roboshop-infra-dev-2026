data "aws_ami" "sivadevops"{
    most_recent = true
    owners = ["166044977463"]

    filter{
        name = "name"
        values = ["Siva_AMI"]
    }

    filter{
        name = "root-block-device"
        values = ["ebs"]
    }

    filter{
        name = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_ssm_parameter" "private_subnet_ids"{
    name = "/${var.project}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "catalogue_sg_id"{
    name = "/${var.project}/${var.environment}/catalogue_sg_id"
}