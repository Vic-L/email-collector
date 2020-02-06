provider "aws" {
  version = "~> 2.24"
  region = "eu-west-1"
}

terraform {
  required_version = "~> 0.12.0"
  backend "s3" {
    bucket = "todo-project-tfstate"
    key = "terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "null" {
  version = "~> 2.1"
}