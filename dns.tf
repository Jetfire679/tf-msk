locals {
  transformed = [ for val in split(",", module.kafka.bootstrap_brokers): split(":", val)[0] ]
}

output "bootstrap_names_ports" {
    value = local.transformed
}

data "dns_a_record_set" "kafka1" {
    host = local.transformed[0]
}

data "dns_a_record_set" "kafka2" {
    host = local.transformed[1]
}

data "dns_a_record_set" "kafka3" {
    host = local.transformed[2]
}


output "kafka_addrs1" {
    value = data.dns_a_record_set.kafka1.addrs[0]
}

output "kafka_addrs2" {
    value = data.dns_a_record_set.kafka2.addrs[0]
}

output "kafka_addrs3" {
    value = data.dns_a_record_set.kafka3.addrs[0]
}

resource "aws_route53_record" "www" {
  zone_id = var.vHostedZone
  name    = "akafka.test.vignali.rocks"
  type    = "A"
  ttl     = "300"
  records = [data.dns_a_record_set.kafka1.addrs[0],data.dns_a_record_set.kafka2.addrs[0],data.dns_a_record_set.kafka3.addrs[0]]
}