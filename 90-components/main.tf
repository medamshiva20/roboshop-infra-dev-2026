module "components"{
    source = "git::https://github.com/medamshiva20/roboshop-terraform-component-2026.git?ref=main"
    count = length(var.components)
}