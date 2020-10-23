terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

module "ecs-fargate-task-definition" {
  source  = "cn-terraform/ecs-fargate-task-definition/aws"
  version = "1.0.16"
  container_image = "084953098776.dkr.ecr.us-west-2.amazonaws.com/hello-world"
  container_name = "hello_world"
  name_prefix = "hello"
  container_memory = 2048
  container_memory_reservation = 512
  container_cpu = 1024
  log_configuration = { 
    logDriver = "awslogs",
    options = {
      awslogs-region = "us-west-2",
      awslogs-group = "/aws/lambda/${module.ecs-fargate-task-definition.container_name}",
      awslogs-stream-prefix = "hello"
    },
    secretOptions = []
  }
  
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_ecs_cluster" "ecs" {
  name = "ecs-test"
}

resource "aws_cloudwatch_log_group" "loggroup" {
  name              = "/aws/lambda/${module.ecs-fargate-task-definition.container_name}"
  retention_in_days = 14
}

