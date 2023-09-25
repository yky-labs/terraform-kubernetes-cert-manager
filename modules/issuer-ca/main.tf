# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

locals {

  # The name of the secret that will contain the certificate.
  certificate_name = coalesce(var.certificate_name, "${var.name}-cert")

  # The name of the certificate secret.
  certificate_secret_name = var.create_certificate ? module.ca_certificate[0].secret_name : var.certificate_secret_name

  # The name of the trust-manager bundle.
  trust_bundle_name = coalesce(var.trust_bundle_name, var.name)

}

# Create the CA certificate.
module "ca_certificate" {
  count = (var.create_certificate) ? 1 : 0
  source = "../certificate"

  namespace     = var.namespace
  name          = local.certificate_name
  issuer_name   = var.certificate_issuer_name
  issuer_kind   = var.certificate_issuer_kind
  common_name   = var.certificate_common_name
  secret_name   = var.certificate_secret_name
  key_algorithm = var.certificate_key_algorithm
  key_size      = var.certificate_key_size
  is_ca         = true

}

# Get the CA certificate.
data "kubernetes_secret_v1" "cert" {
  metadata {
    name      = local.certificate_secret_name
    namespace = var.namespace
  }

  depends_on = [
    module.ca_certificate
  ]
}

# Create the CA Issuer.
resource "kubectl_manifest" "this" {

  depends_on = [ module.ca_certificate ]

  yaml_body = <<-EOF
    apiVersion: cert-manager.io/v1
    kind: ${var.kind}
    metadata:
      name: ${var.name}
      namespace: ${var.namespace}
    spec:
      ca:
        secretName: ${local.certificate_secret_name}
  EOF

}

# Create the trust-manager bundle.
resource "kubectl_manifest" "ca_trust_bundle" {
  count = (var.create_trust_bundle) ? 1 : 0

  depends_on = [ kubectl_manifest.this ]

  yaml_body = <<-EOF
    apiVersion: trust.cert-manager.io/v1alpha1
    kind: Bundle
    metadata:
      name: ${local.trust_bundle_name}
      namespace: ${var.namespace}
    spec:
      sources:
      - secret:
          name: ${local.certificate_secret_name}
          key: ca.crt
      target:
        configMap:
          key: ca.crt
  EOF

}
