#Configure cloud watch group
resource "aws_cloudwatch_log_group" "msk_logs_group" {
  name = "${var.prefix}-streamlit"
}

#setup kms key
resource "aws_kms_key" "msk_kms" {
  description             = "msk_kms"
  deletion_window_in_days = 7
}

resource "aws_msk_cluster" "default" {
  cluster_name           = "${var.prefix}streamlit-msk"
  kafka_version          = "2.8.1"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type = "kafka.t3.small"
    client_subnets = var.vpc_private_subnets_id
    security_groups = [var.sg_msk]
    ebs_volume_size = 100
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = null

    encryption_in_transit {
      client_broker = "PLAINTEXT"
      in_cluster = false
    }
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk_logs_group.name
      }
      s3 {
        enabled = true
        bucket  = var.s3_msk_bucket
        prefix  = "logs/msk-"
      }
    }
  }

}


