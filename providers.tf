terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  alias  = "bootstrap"
}

provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/IAMAutomation"
    session_name = local.aws_session_name
  }
}

terraform {
  backend "s3" {
    dynamodb_table = "terraform-state-lock"
  }
}

