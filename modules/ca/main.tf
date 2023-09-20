# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

locals {
  # The common name of the certificate.
  common_name       = coalesce(var.common_name, var.name)

  # The name of the secret that contains the certificate.
  secret_name       = coalesce(var.secret_name, "${var.name}-cert")

  # The name of the trust-manager bundle.
  trust_bundle_name = var.name
}

# Create the CA certificate.
resource "kubectl_manifest" "cert" {
  count = var.create_certificate ? 1 : 0

  yaml_body = <<-EOF
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
      name: ${var.name}
      namespace: ${var.namespace}
    spec:
      isCA: true
      commonName: ${local.common_name}
      secretName: ${local.secret_name}
      privateKey:
        algorithm: ECDSA
        size: 256
      issuerRef:
        name: ${var.certificate_issuer_name}
        kind: ${var.certificate_issuer_kind}
        group: cert-manager.io  
  EOF

}

# Get the CA certificate.
data "kubernetes_secret_v1" "cert" {
  metadata {
    name      = local.secret_name
    namespace = var.namespace
  }

  depends_on = [
    kubectl_manifest.cert
  ]
}

# Create the CA certificate's issuer.
resource "kubectl_manifest" "this" {

  yaml_body = <<-EOF
    apiVersion: cert-manager.io/v1
    kind: ${var.kind}
    metadata:
      name: ${var.name}
      namespace: ${var.namespace}
    spec:
      ca:
        secretName: ${local.secret_name}
  EOF

  depends_on = [
    kubectl_manifest.cert
  ]
}

# Create the trust-manager bundle.
resource "kubectl_manifest" "ca_trust_bundle" {
  count = (var.create_trust_bundle) ? 1 : 0

  yaml_body = <<-EOF
    apiVersion: trust.cert-manager.io/v1alpha1
    kind: Bundle
    metadata:
      name: ${local.trust_bundle_name}
      namespace: ${var.namespace}
    spec:
      sources:
      - secret:
          name: ${local.secret_name}
          key: ca.crt
      target:
        configMap:
          key: ca.crt
  EOF

  depends_on = [
    kubectl_manifest.this
  ]
}
