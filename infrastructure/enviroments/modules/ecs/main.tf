# Import modules
module "iam_ecs_role" {
  source = "../iam"
}

#ECS Cluster
resource "aws_ecs_cluster" "streamlit" {
  name = "streamlit-fe-prod"

  setting {
    name  = "containerInsights"
    value = "enabled"
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


#resource "aws_ecs_capacity_provider" "ecs_capacity" {
#  name = "cap"
#
#  auto_scaling_group_provider {
#    auto_scaling_group_arn         = aws_autoscaling_group.autoscaling_group.arn
#  }
#}
#
#resource "aws_autoscaling_group" "autoscaling_group" {
#
#  max_size = 4
#  min_size = 1
#  desired_capacity = 1
#  availability_zones = ["eu-central-1a", "eu-central-1b"]
#
#  launch_template {
#    id      = aws_launch_template.ecs_template.id
#    version = "$Latest"
#  }
#}
#
#resource "aws_launch_template" "ecs_template" {
#  name_prefix   = "ecs_launch_template"
#  instance_type = "t2.micro"
#  image_id      = "ami-076309742d466ad69"
#}

#ECS task definition
resource "aws_ecs_task_definition" "ecs_task_def_service" {

  family = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu       = 256
  memory    = 512
  task_role_arn = "arn:aws:iam::008587414280:role/ecs_task_execution_role" #todo remove hardcoding
  execution_role_arn = "arn:aws:iam::008587414280:role/ecs_task_execution_role" #todo remove hardcoding

  container_definitions = jsonencode([
    {
      name      = "streamlit-app-prod"
      image     = "008587414280.dkr.ecr.eu-central-1.amazonaws.com/streamlit-fe:latest"
      essential = true
      operating_system_family  = "linux"
      portMappings = [
        {
          containerPort = 8501
          hostPort      = 8501
        }
      ]
    }
  ])
    }

#
###ECS service
#resource "aws_ecs_service" "task" {
#  name            = "streamlit-fe-svc"
#  cluster         = aws_ecs_cluster.streamlit.id
#  task_definition = aws_ecs_task_definition.ecs_task_def_service.arn
#  desired_count   = 1
#  iam_role        = module.iam_ecs_role.aws_ecs_role_name
#
#  ordered_placement_strategy {
#    type  = "binpack"
#    field = "cpu"
#  }
#
#  load_balancer {
#    target_group_arn = aws_lb_target_group.foo.arn
#    container_name   = "mongo"
#    container_port   = 8080
#  }
#
#  placement_constraints {
#    type       = "memberOf"
#    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
#  }
#}