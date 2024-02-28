# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


output "ca_cert_secret_name" {
  value       = try(module.issuer_ca[0].cert_secret_name, null)
  description = "The name of the secret that contains the generated CA certificate."
}

output "ca_cert_crt" {
  value       = try(module.issuer_ca[0].cert_crt, null)
  description = "The public certificate of the CA."
}

output "ca_trust_bundle" {
  value       = try(module.issuer_ca[0].trust_bundle, null)
  description = "Create a trust bundle for the CA cert."
}
