module "components"{
    source = "git::https://github.com/medamshiva20/roboshop-terraform-component-2026.git?ref=main"
    for_each = var.components
    component = each.key
    rule_priority = each.value.rule_priority
}