resource "aws_dynamodb_table" "main" {
  name = "todo-dynamodb_table"
  billing_mode = "PROVISIONED"
  read_capacity = var.dynamodb-read_capacity
  write_capacity = var.dynamodb-write_capacity
  hash_key = "email"

  attribute {
    name = "email"
    type = "S"
  }
}
