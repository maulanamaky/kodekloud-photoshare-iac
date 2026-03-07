data "archive_file" "lambda_code_path" {
  type        = "zip"
  source_file = "${path.module}/../../src/index.py"
  output_path = "lambda_function_code.zip"
}

resource "aws_lambda_function" "s3" {
  function_name = var.function_name
  architectures = ["x86_64"]
  role          = var.lambda_role
  handler       = "index.handler"

  filename         = data.archive_file.lambda_code_path.output_path
  source_code_hash = data.archive_file.lambda_code_path.output_base64sha256

  runtime = "python3.13"

  environment {
    variables = {
      S3_BUCKET = var.s3_bucket_name
      ALB_DNS   = var.lb_dns_name
    }
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.s3_bucket_id

  lambda_function {
    events = ["s3:ObjectCreated:*"]
    lambda_function_arn = aws_lambda_function.s3.arn
  }

  depends_on = [aws_lambda_permission.allow_s3]
}