data "archive_file" "code_path" {
  type        = "zip"
  source_file = "${path.module}/src/index.py"
  output_path = "lambda_function_code.zip"
}

resource "aws_lambda_function" "s3_lambda" {
  function_name = var.KKE_FUNCTION_NAME
  architectures = ["x86_64"]
  role          = aws_iam_role.lambda.arn
  handler       = "index.handler"

  filename         = data.archive_file.code_path.output_path
  source_code_hash = data.archive_file.code_path.output_base64sha256

  runtime = "python3.13"

  environment {
    variables = {
      S3_BUCKET = var.KKE_BUCKET_NAME
      ALB_DNS   = aws_lb.photoshare_alb.dns_name
    }
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.photoshare_bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.photoshare_bucket.id

  lambda_function {
    events = ["s3:ObjectCreated:*"]
    lambda_function_arn = aws_lambda_function.s3_lambda.arn
  }

  depends_on = [aws_lambda_permission.allow_s3]
}