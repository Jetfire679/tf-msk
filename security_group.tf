resource "aws_security_group" "kafka_cluster" {
  name        = join("-", [var.vApp, "kafka-cluster"])
  description = "Allow TCP/80 & TCP/22"
  vpc_id      = data.aws_ssm_parameter.rlv-VpcId.value
  dynamic "ingress" {
    for_each = var.kafka-cluster-ingress-rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.egress-rules
    content {
      from_port   = egress.value["port"]
      to_port     = egress.value["port"]
      protocol    = egress.value["proto"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
}

#Create Dynamic SG using variables 
resource "aws_security_group" "kafka_client" {
  name        = join("-", [var.vApp, "kafka-client"])
  description = "Allow TCP/80 & TCP/22"
  vpc_id      = data.aws_ssm_parameter.rlv-VpcId.value
  dynamic "ingress" {
    for_each = var.kafka-client-ingress-rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.egress-rules
    content {
      from_port   = egress.value["port"]
      to_port     = egress.value["port"]
      protocol    = egress.value["proto"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
}