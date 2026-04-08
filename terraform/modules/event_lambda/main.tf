# IAM Role
resource "aws_iam_role" "lambda_role" {
  name = "event-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach logging policy
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda function
resource "aws_lambda_function" "ec2_event" {
  function_name = "ec2-event-listener"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.9"

  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)
}

# EventBridge rule (ONLY EC2 API calls)
resource "aws_cloudwatch_event_rule" "ec2_rule" {
  name = "ec2-event-rule"

  event_pattern = jsonencode({
    "source": ["aws.ec2"]
  })
}

# Connect rule → lambda
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.ec2_rule.name
  arn  = aws_lambda_function.ec2_event.arn
}

# Allow EventBridge to invoke Lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_event.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_rule.arn
}
