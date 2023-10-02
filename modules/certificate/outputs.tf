# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

output "secret_name" {
  value = local.secret_name
  description = "Name of the secret to store the certificate in"
}
