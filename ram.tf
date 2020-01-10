resource "random_integer" "this" {
  max = 99999999
  min = 10000000
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
  description = "Create by modules/terraform-alicloud-serverless-webapp"
  force       = true
}

resource "alicloud_ram_policy" "policy" {
  name = "terraform-serverless-webapp-policy-${random_integer.this.result}"

  document = <<EOF
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


  description = "Create by modules/terraform-alicloud-serverless-webapp"
  force       = true
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = alicloud_ram_policy.policy.name
  role_name   = alicloud_ram_role.this.name
  policy_type = alicloud_ram_policy.policy.type
}