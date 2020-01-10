# Complete Serverless Webapp example

Configuration in this directory creates set of API gateway and FC resources in various combinations.

Data sources are used to discover the appcode.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Outputs

| Name | Description |
|------|-------------|
| this\_api\_gateway\_group\_id | The id of the api gateway group |
| this\_api\_gateway\_group\_name | The name of the api gateway group |
| this\_api\_gateway\_api\_id | The id of the api gateway api |
| this\_api\_gateway\_api\_name | The name of the api gateway api |
| this\_fc\_service\_id | The id of the fc service |
| this\_fc\_service\_name | The name of the fc service |
| this\_fc\_function\_id | The id of the fc function  |
| this\_fc\_function\_name | The name of the fc function  |
| this\_request\_parameters | The request parameters of the api gateway api |
| this\_fc\_service\_config | The fc service config of the api gateway api |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
