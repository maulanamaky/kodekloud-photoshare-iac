db_username = "admin"
db_password = "admin123"

pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8Z1rcAwiMqfPrZU1RWKhDN5lRAmQ0ARoHvhkGHKwwD008/GIALMi8yO6AhgkVQm60tCclcpvx4csKWVk3pOLes8HMlYFctVMRX3l13HPsHcxgIlCtndbfoitjIJQ03tYepCnS1vUgNdn2g1fVgWDHVTIjiqxSbdCaupcl2ZCqruFWE2s5tU9HqmxGqu6/TUVl37xdxcIzncvA5F8TV/SBsN4tLiXaymqYFDTAu1a0fjBmWieiSdStOIWm+Nd+oSct+UZPtvNHHDpn44owoFeohvwfe/GYRkDKU0NA6ON7OX/f71U1YKMptqtSi1osd3zJNstlKVWbNMEJUk78LCS5FDgl+v+jWU4e0WEkE6gpY6GuFOM51xasv4W0/B5K3TGrwBFY3H/8MqWStCGxD4WKWhz92F+iHhDTwfX9xfI0zbpdqHo6KYeSuCfrjW5FbraWGog4KaE8bXbSiPDU/QYhJHw0EV1tNQBc1eWSeoeYOveGzvpIPMGmIjCYnlof55U= photoshare-aws-maulana"

subnet_list = {
    "Public Subnet 1" = {
      cidr   = "10.0.1.0/24",
      region = "us-east-1a",
      public = true
    },
    "Private Subnet 1" = {
      cidr   = "10.0.2.0/24",
      region = "us-east-1a",
      public = false
    },
    "Public Subnet 2" = {
      cidr   = "10.0.3.0/24",
      region = "us-east-1b",
      public = true
    },
    "Private Subnet 2" = {
      cidr   = "10.0.4.0/24",
      region = "us-east-1b",
      public = false
    }
  }
