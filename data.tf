data "aws_ssm_parameter" "rlv-VpcId" {
  name = "rlv-VpcId"
}

data "aws_ssm_parameter" "rlv-PubSubA_ID" {
  name = "rlv-PubSubA_ID"
}

data "aws_ssm_parameter" "rlv-PubSubB_ID" {
  name = "rlv-PubSubB_ID"
}

data "aws_ssm_parameter" "rlv-PubSubC_ID" {
  name = "rlv-PubSubC_ID"
}

data "aws_ssm_parameter" "rlv-PubSubA" {
  name = "rlv-PubSubA"
}

data "aws_ssm_parameter" "rlv-PubSubB" {
  name = "rlv-PubSubB"
}

data "aws_ssm_parameter" "rlv-PubSubC" {
  name = "rlv-PubSubC"
}