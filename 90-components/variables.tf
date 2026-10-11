variable "components"{
    type = map
    default = {
        # backend components are attaching to backend ALB
        user = {
            rule_priority = 20
        }

        cart = {
            rule_priority = 30
        }

        shipping = {
            rule_priority = 40
        }

        payment = {
            rule_priority = 50
        }


        #Frontend rule
        frontend = {
            rule_priority = 60
        }
    }
}