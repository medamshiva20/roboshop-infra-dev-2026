terraform{
    rquired_providers{
        aws = {
            source = "hashicorp/aws"
            version = "6.33.0"
        }
    }
    bucket "s3"{
        bucket = "remote-state-aws-88s-dev"
        key = "roboshop-dev-vpc"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}

provider "aws"{
    region = "us-east-1"
}