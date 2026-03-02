resource "aws_cloudwatch_dashboard" "ec_lambda" {
  dashboard_name = var.KKE_DASHBOARD_NAME

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          view = "TimeSeries"
          stacked = false
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              aws_instance.photoshare_web.id
            ]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "EC2 Instance CPU"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          view = "SingleValue"
          metrics = [
            [
              "AWS/Lambda",
              "Invocations",
              "FunctionName",
              aws_lambda_function.s3_lambda.function_name
            ]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "Lambda Function"
        }
      }
    ]
  })
}

resource "aws_cloudwatch_metric_alarm" "lambda" {
  alarm_name                = var.KKE_ALARM_LAMBDA_NAME
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = 60
  statistic                 = "Sum"
  threshold                 = 0
  alarm_description         = "This metric monitors lambda function"
  
  dimensions = {
    FunctionName = aws_lambda_function.s3_lambda.function_name
  }
}