resource "random_integer" "this" {
  min = 10000000
  max = 99999999
}

resource "alicloud_ram_role" "this" {
  name        = "terraform-serverless-webapp-role-${random_integer.this.result}"
  document    = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "apigateway.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
  description = var.ram_role_description
  force       = var.ram_role_force
}

resource "alicloud_ram_policy" "policy" {
  policy_name     = "terraform-serverless-webapp-policy-${random_integer.this.result}"
  policy_document = <<EOF
  {
    "Version": "1",
    "Statement": [
        {
            "Action": [
                "fc:InvokeFunction"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
  }
  EOF
  description     = var.ram_policy_description
  force           = var.ram_policy_force
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = alicloud_ram_policy.policy.name
  role_name   = alicloud_ram_role.this.name
  policy_type = alicloud_ram_policy.policy.type
}