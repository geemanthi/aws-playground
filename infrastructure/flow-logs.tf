# # VPC flow logs to CloudWatch
# resource "aws_flow_log" "vpc_flow_logs" {
#   count = var.enable_vpc_flow_logs ? 1 : 0

#   iam_role_arn    = aws_iam_role.vpc_flowlogs_write_iam_role[0].arn
#   log_destination = aws_cloudwatch_log_group.vpc_flowlogs_cloudwatch_log_group[0].arn
#   traffic_type    = "ALL"
#   vpc_id          = aws_vpc.vpc.id

#   tags = merge({
#     Name             = "flowlogs-${lower(local.name_suffix)}"
#   }, local.tags)
# }


# # CloudWatch log group for VPC flow logs
# resource "aws_cloudwatch_log_group" "vpc_flowlogs_cloudwatch_log_group" {
#   count = var.enable_vpc_flow_logs ? 1 : 0

#   name              = "cwlogs-${lower(local.name_suffix)}"
#   retention_in_days = var.vpc_flow_logs_retention_in_days
#   kms_key_id        = aws_kms_key.vpc_flowlog_kms_key.arn

#   tags = merge({
#     Name             = "cwlogs-${lower(local.name_suffix)}-vpcflowlogs"
#   }, local.tags)
# }

# # IAM role and policies to write flow logs to CloudWatch
# resource "aws_iam_role" "vpc_flowlogs_write_iam_role" {
#   count = var.enable_vpc_flow_logs ? 1 : 0

#   name               = "VPCFlowLogsRole"
#   assume_role_policy = file("${path.module}/iam-policies/VPCFlowLogsAssumeRole-policy.json")
# }

# resource "aws_iam_role_policy" "example" {
#   count = var.enable_vpc_flow_logs ? 1 : 0

#   name = "VPCFlowLogsRole-policy"
#   role = aws_iam_role.vpc_flowlogs_write_iam_role[0].id
#   policy = templatefile("${path.module}/iam-policies/CloudWatchLoggingRole-policy.tpl.json", {
#     kms_key_arn = aws_kms_key.vpc_flowlog_kms_key.arn
#   })
# }


# # VPC flow logs encryption with KMS
# resource "aws_kms_key" "vpc_flowlog_kms_key" {
#   description             = "KMS key to encrypt VPC flow logs"
#   enable_key_rotation     = true
#   deletion_window_in_days = 20
#   multi_region            = true

#   policy = templatefile("${path.module}/iam-policies/KMSAdminAndUsage-policy.tpl.json", {
#     aws_account_id = data.aws_caller_identity.current.account_id
#     gtnadmin_arn   = tolist(data.aws_iam_roles.sso_role_gtnadmin.arns)[0]
#     gtnuser_arn    = tolist(data.aws_iam_roles.sso_role_gtnuser.arns)[0]
#     region         = substr(keys(var.private_subnets)[0], 0, length(keys(var.private_subnets)[0]) - 1)
#   })

#   tags = merge({
#     Name         = "kms-${lower(local.name_suffix)}-vpcflowlogs"
#   }, local.tags)
# }

# resource "aws_kms_alias" "vpc_flowlog_kms_key_alias" {
#   name          = "alias/vpc-flowlogs"
#   target_key_id = aws_kms_key.vpc_flowlog_kms_key.id
# }