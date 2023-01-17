# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

output "local_ca_cert_secret_name" {
  value = module.ca.cert_secret_name
}

output "local_ca_cert_crt" {
  value = module.ca.cert_crt
}

output "local_ca_trust_bundle" {
  value = module.ca.trust_bundle
}
