resource "aws_instance" "catalogue"{
    ami = local.ami_id
    instance_type = var.instance_type
    subnet_id = local.private_subnet_id
    vpc_security_group_ids = [local.catalogue_sg_id]

    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-catalogue"
        }
    )
}

resource "terraform_data" "catalogue"{
    triggers_replace = [
        aws_instance.catalogue.id
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = aws_instance.catalogue.private_ip
    }

    provisioner "file"{
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec"{
        inline = [
            "sudo chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh catalogue dev"
        ]
    }
}

resource "aws_ec2_instance_state" "catalogue"{
    instance_id = aws_instance.catalogue.id
    state = "stopped"
    depends_on = [aws_instance.catalogue]
}

resource "aws_ami_from_instance" "catalogue"{
    name = "${var.project}-${var.environment}-catalogue"
    source_instance_id = aws_instance.catalogue.id
    depends_on = [aws_ec2_instance_state.catalogue]

    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-catalogue"
        }
    )
}

resource "aws_lb_target_group" "catalogue"{
    name = "${var.project}-${var.environment}-catalogue"
    protocol = "HTTP"
    port = 8080
    vpc_id = local.vpc_id
    deregistration_delay = 60
    
    health_check{
        protocol = "HTTP"
        path = "/health"
        port = 8080
        healthy_threshold = 2
        unhealthy_threshold =2
        timeout = 5
        interval = 10
        matcher = "200-299"
    }
}

resource "aws_launch_template" "catalogue"{
    name = "${var.project}-${var.environment}-catalogue"
    image_id = aws_ami_from_instance.catalogue.id

    # once autoscaling sees less traffic, it will terminate the instance
    instance_initiated_shutdown_behaviour = "terminate"
    instance_type = var.instance_type
    vpc_security_group_ids = [local.catalogue_sg_id]

    # each time we apply terraform this version will be updated as default
    update_default_version = true   

    tag_specifications {
        resource_type = "instance"

        tags = merge(
            {
                Name = "${var.project}-${var.environment}-catalogue"
            },
            local.common_tags
        )
    }

    tag_specifications {
        resource_type = "volume"

        tags = merge(
            local.common_tags,
            {
                Name = "${var.project}-${var.environment}-catalogue"
            }
        )
    }

    # tags for launch template
    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-catalogue"
        }
    )

}