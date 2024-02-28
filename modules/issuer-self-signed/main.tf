# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


# Self-signed certificate's issuer.
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
      selfSigned = {}
    }
  }
}
