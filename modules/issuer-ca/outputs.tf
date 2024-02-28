# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


output "cert_secret_name" {
  value       = data.kubernetes_secret_v1.cert.metadata[0].name
  description = "The name of the secret that contains the generated CA certificate."
}

output "cert_crt" {
  value       = data.kubernetes_secret_v1.cert.data["ca.crt"]
  description = "The public certificate of the CA."
}

output "trust_bundle" {
  value       = local.trust_bundle_name
  description = "Create a trust bundle for the CA cert."
}
