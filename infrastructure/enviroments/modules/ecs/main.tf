#setup kms key
resource "aws_kms_key" "ecs_logs" {
  description             = "ecs_logs"
  deletion_window_in_days = 7
}

#Configure cloud watch group
resource "aws_cloudwatch_log_group" "ecs_logs_group" {
  name = var.log_group_ecs_cluster
}

#Configure cloud watch group
resource "aws_cloudwatch_log_group" "ecs_logs_group_containers" {
  name = var.log_group_ecs_containers
}

#ECS Cluster
resource "aws_ecs_cluster" "streamlit" {
  name = "streamlit-fe-prod"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.ecs_logs.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs_logs_group.name
      }
    }
  }

}

resource "aws_ecs_cluster_capacity_providers" "ecs_providers" {
  cluster_name = aws_ecs_cluster.streamlit.name

  capacity_providers = ["FARGATE"]
  default_capacity_provider_strategy {
    base              = 1
    capacity_provider = "FARGATE"
  }
}

#ECS task definition
resource "aws_ecs_task_definition" "ecs_task_def_service" {

  family = "ecs_service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu       = 256
  memory    = 512
  task_role_arn = var.ecs_role
  execution_role_arn = var.ecs_role

  container_definitions = jsonencode([
    {
      name      = var.ecs_container_name
      image     = "${var.ecr_url}:latest"
      essential = true
      operating_system_family  = "linux"
      environmentFiles: [
        {
              "value": "${var.aws_bucket_variables}/streamlit.env",
              "type": "s3"
        }
      ]
      portMappings = [
        {
          containerPort = 8501
          hostPort      = 8501
        }
      ]
      logConfiguration = {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": var.log_group_ecs_containers,
          "awslogs-region": var.region,
          "awslogs-stream-prefix": "streaming"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "default" {
  name = "streamlit-fe-svc"
  cluster = aws_ecs_cluster.streamlit.id
  task_definition = aws_ecs_task_definition.ecs_task_def_service.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
    security_groups = [var.ecs_sg_id]
    subnets = var.vpc_private_subnets_id
  }

  load_balancer {
    container_name = var.ecs_container_name
    container_port = 8501
    target_group_arn = var.alb_tg_id
  }
}
