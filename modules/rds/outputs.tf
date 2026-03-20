output "rds_db_address"{
    value = aws_db_instance.rds_mysql.address
}

output "rds_db_initial"{
    value = aws_db_instance.rds_mysql.db_name
}
