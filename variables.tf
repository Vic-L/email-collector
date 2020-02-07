variable "project_name" {
  type = string
  default = "todo-project"
}

variable "region" {
  type = string
  default = "eu-west-1"
}

variable "stage" {
  type = string
  default = "todo-stage"
}

variable "zipfile_name" {
  type = string
  default = "todo-project.zip"
}

variable "dynamodb-read_capacity" {
  type = number
  default = 1
}

variable "dynamodb-write_capacity" {
  type = number
  default = 1
}

data "aws_caller_identity" "current" {}
