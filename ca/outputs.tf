# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

output "cert_secret_name" {
  value = data.kubernetes_secret_v1.cert.metadata[0].name
}

output "cert_crt" {
  value = data.kubernetes_secret_v1.cert.data.crt
}

output "trust_bundle" {
  value = local.trust_bundle_name
}
