resource "aws_ecs_task_definition" "strapi" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "2048"
  memory                   = "4096"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "adarshdogra1122/strapi-app:v1"
      essential = true
      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          name  = "DATABASE_CLIENT"
          value = "postgres"
        },
        {
          name  = "DATABASE_HOST"
          value = "nozomi.proxy.rlwy.net"
        },
        {
          name  = "DATABASE_PORT"
          value = "20653"
        },
        {
          name  = "DATABASE_NAME"
          value = "railway"
        },
        {
          name  = "DATABASE_USERNAME"
          value = "postgres"
        },
        {
          name  = "DATABASE_PASSWORD"
          value = "rzekqiawoPDLUpiiwpMsIHzocehyRmmP"
        },
        {
          name  = "DATABASE_SSL"
          value = "false"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/strapi"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

