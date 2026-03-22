
## KodeKloud AWS PhotoShare Labs (IaC version)


<img width="1083" height="700" alt="Screenshot From 2026-02-28 15-53-08" src="https://github.com/user-attachments/assets/39025938-3b05-48e9-a176-e3e828fd9996" />

link (Youtube): https://youtu.be/7eP8U2CnKdA?si=GaDDToWQF452dK7T


This is my personality project to convert from AWS console clickops to Infrastructure as Code using Terraform.

### How To Run

You must make configuration file "secrets.tfvars" and fill the credentials

```
database_username = "<VALUE>"
database_password = "<VALUE>"

pub_key = "<VALUE>"
```

After that, you can run `terraform apply -var-file=secret.tfvars -auto-approve`



