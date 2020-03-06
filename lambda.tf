resource "aws_lambda_function" "main" {
  filename = var.zipfile_name
  function_name = "${var.project_name}"
  role = aws_iam_role.main.arn
  handler = "index.handler"

  source_code_hash = "${filebase64sha256("${var.zipfile_name}")}"

  runtime = "nodejs12.x"
}

resource "aws_iam_role" "main" {
  name = "${var.project_name}-iam_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "main" {
  name = "main"
  path = "/"
  description = "IAM policy for lambda to write to dynamodb table and logging"

  policy = templatefile("${path.module}/lambda_policy.tmpl", { dynamodb_arn = aws_dynamodb_table.main.arn })
}

resource "aws_iam_role_policy_attachment" "main" {
  role = "${aws_iam_role.main.name}"
  policy_arn = "${aws_iam_policy.main.arn}"
}

resource "aws_lambda_permission" "main" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.main.execution_arn}/*/*/*"
}
