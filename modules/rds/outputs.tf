output "database_address"{
    value = aws_db_instance.photoshare_database.address
}

output "database_initial"{
    value = aws_db_instance.photoshare_database.db_name
}
