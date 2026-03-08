output "ec2_role"{
    value = aws_iam_role.ec2.arn
}

output "lambda_role"{
    value = aws_iam_role.lambda.arn
}