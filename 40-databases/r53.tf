resource "aws_route53_record" "mongodb"{
    zone_id = var.zone_id
    name = "mongodb-dev.${var.domain_name}"
    type = "A"
    ttl = "1"
    records = [aws_instance.mongodb.private_ip]
}

resource "aws_route53_record" "redis"{
    zone_id = var.zone_id
    type = "A"
    ttl = "1"
    name = "redis.${var.domain_name}"
    records = [aws_instance.redis.private_ip]
}

resource "aws_route53_record" "mysql"{
    zone_id = var.zone_id
    name = "mysql.${var.domain_name}"
    ttl = "1"
    type = "A"
    records = [aws_instance.mysql.private_ip]
}

resource "aws_route53_record" "rabbitmq"{
    zone_id = var.zone_id
    name = "rabbitmq.${var.domain_name}"
    ttl = "1"
    type = "A"
    records = [aws_instance.rabbitmq.private_ip]
}