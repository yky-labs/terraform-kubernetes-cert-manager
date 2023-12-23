# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

locals {
  name = (var.staging) ? "${var.name}-staging" : var.name
  server_url = coalesce(var.server_url, (
    (var.staging) ?
    "https://acme-staging-v02.api.letsencrypt.org/directory" :
    "https://acme-v02.api.letsencrypt.org/directory"
  ))
}

resource "kubernetes_manifest" "this" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = var.kind
    metadata = {
      Issuer = {
        name      = local.name
        namespace = var.namespace
      }
      ClusterIssuer = {
        name = local.name
      }
    }[var.kind]
    spec = {
      acme = {
        email  = var.email
        server = local.server_url
        privateKeySecretRef = {
          name = "${local.name}-account-key"
        }
        solvers = [
          {
            dns01 = {
              cloudflare = {
                apiTokenSecretRef = {
                  name = var.api_token_secret
                  key  = var.api_token_key
                }
              }
            }
          }
        ]
      }
    }
  }
}
