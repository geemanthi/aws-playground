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

}
