# Copyright (c) 2023-2024 YKY Labs
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
  count  = (var.create_certificate) ? 1 : 0
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
resource "kubernetes_manifest" "this" {

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = var.kind
    metadata = {
      Issuer = {
        name      = var.name
        namespace = var.namespace
      }
      ClusterIssuer = {
        name = var.name
      }
    }[var.kind]
    spec = {
      ca = {
        secretName = local.certificate_secret_name
      }
    }
  }

  depends_on = [
    module.ca_certificate
  ]
}

# Create the trust-manager bundle.
resource "kubernetes_manifest" "ca_trust_bundle" {
  count = (var.create_trust_bundle) ? 1 : 0

  manifest = {
    apiVersion = "trust.cert-manager.io/v1alpha1"
    kind       = "Bundle"
    metadata = {
      name      = local.trust_bundle_name
    }
    spec = {
      sources = [
        {
          secret = {
            name = local.certificate_secret_name
            key  = "ca.crt"
          }
        }
      ]
      target = {
        configMap = {
          key = "ca.crt"
        }
      }
    }
  }

  depends_on = [
    kubernetes_manifest.this
  ]
}
