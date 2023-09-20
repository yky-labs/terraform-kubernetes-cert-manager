# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

output "ca_cert_secret_name" {
  value       = module.ca.cert_secret_name
  description = "The name of the secret that contains the generated CA certificate."
}

output "ca_cert_crt" {
  value       = module.ca.cert_crt
  description = "The public certificate of the CA."
}

output "ca_trust_bundle" {
  value       = module.ca.trust_bundle
  description = "Create a trust bundle for the CA cert."
}
