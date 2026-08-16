resource "aws_instance" "mongodb"{
    ami = local.ami_id
    instance_type = var.instance_type
    subnet_id = local.database_subnet_id
    vpc_security_group_ids = [local.mongodb_sg_id]

    tags = merge(
        local.common_tags,
        {
            name = "${var.project}-${var.environment}-mongodb"
        }
    )
}

resource "terraform_data" "bootstrap"{
    triggers_replace = [
        aws_instance.mongodb.id
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = aws_instance.mongodb.private_ip
    }

    provisioner "file"{
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec"{
        inline = [
            "sudo chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh mongodb"
        ]
    }
}

resource "aws_instance" "redis"{
    ami = local.ami_id
    instance_type = var.instance_type
    subnet_id = local.database_subnet_id
    vpc_security_group_ids = [local.redis_sg_id]

    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-redis"
        }
    )
}
    resource "terraform_data" "redis_bootstrap"{
        triggers_replace = [
            aws_instance.redis.id
        ]
    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = aws_instance.redis.private_ip
    }
    provisioner "file"{
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
    }
    provisioner "remote-exec"{
        inline = [
        "sudo chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh redis"
        ]
    }
 }

 resource "aws_instance" "mysql"{
    ami = local.ami_id
    instance_type = var.instance_type
    subnet_id = local.database_subnet_id
    vpc_security_group_ids = [local.mysql_sg_id]
    iam_instance_profile = aws_iam_instance_profile.mysql.name

    tags = merge (
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-mysql"
        }
    )
 }

 resource "terraform_data" "mysql_bootstrap"{
    triggers_replace = [
        aws_instance.mysql.id
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = aws_instance.mysql.private_ip
    }

    provisioner "file"{
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec"{
        inline = [
            "sudo chmod +x /tmp/bootstrap.sh",
            "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
        ]
    }
 }

 resource "aws_instance" "rabbitmq"{
    ami = local.ami_id
    instance_type = var.instance_type
    subnet_id = local.database_subnet_id
    vpc_security_group_ids = [local.rabbitmq_sg_id]

    tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-rabbitmq"
        }
    )
 }

 resource "terraform_data" "bootstrap_rabbitmq"{
    triggers_replace = [
        aws_instance.rabbitmq.id
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = aws_instance.rabbitmq.private_ip
    }

    provisioner "file"{
        source = "bootstrap.sh"
        destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec"{
        "sudo chmod +x /tmp/bootstrap.sh"
        "sudo sh /tmp/bootstrap.sh rabbitmq dev"
    }
 }