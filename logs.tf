# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days

resource "aws_cloudwatch_log_group" "kafkalogs" {
  name = join("-", [var.vApp,"logs"])
  retention_in_days = 30
}

