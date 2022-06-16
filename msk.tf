
module "kafka" {
  source = "cloudposse/msk-apache-kafka-cluster/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  namespace              = join("-", [var.vApp])
  stage                  = "test"
  name                   = join("-", [var.vApp,"kafka-cluster"])
  vpc_id                 = data.aws_ssm_parameter.rlv-VpcId.value
  # zone_id                = "Z14EN2YD427LRQ"
  subnet_ids             = [data.aws_ssm_parameter.rlv-PubSubA_ID.value,data.aws_ssm_parameter.rlv-PubSubB_ID.value,data.aws_ssm_parameter.rlv-PubSubC_ID.value]
  kafka_version          = "2.6.3"
  number_of_broker_nodes = 3 # this has to be a multiple of the # of subnet_ids
  broker_instance_type   = "kafka.t3.small"
  broker_volume_size     = 10
  cloudwatch_logs_enabled = true
  cloudwatch_logs_log_group = aws_cloudwatch_log_group.kafkalogs.name
  client_broker          = "TLS_PLAINTEXT"

  # security groups to put on the cluster itself
  associated_security_group_ids = [aws_security_group.kafka_cluster.id]
  # security groups to give access to the cluster
  allowed_security_group_ids = [aws_security_group.kafka_client.id]
}

resource "aws_ssm_parameter" "bootstrap_brokers" {
  name  = join("-", [var.vApp, "bootstrap_brokers"])
  type  = "String"
  value = module.kafka.bootstrap_brokers
}

resource "aws_ssm_parameter" "cluster_arn" {
  name  = join("-", [var.vApp, "cluster_arn"])
  type  = "String"
  value = module.kafka.cluster_arn
}

resource "aws_ssm_parameter" "cluster_name" {
  name  = join("-", [var.vApp, "cluster_name"])
  type  = "String"
  value = module.kafka.cluster_name
}

resource "aws_ssm_parameter" "zookeeper_connect_string" {
  name  = join("-", [var.vApp, "zookeeper_connect_string"])
  type  = "String"
  value = module.kafka.zookeeper_connect_string
}