locals {
  tags = {
    Environment         = "prod"
    CostCenter          = "platform"
    Team                = "platform"
    AssetUser           = "platform"
    AssetCustodian      = "platform"
    Organization        = "global"
    Automation          = "terraform"
    AssetClassification = "medium"
    Project             = "test"
    ApplicationName     = "nginx"
  }

  aws_session_name = "aws-playground"
  name_suffix     = "${lower(var.region_code)}-${lower(var.organization)}-${lower(var.env)}-${lower(var.project)}"
}
