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
        name      = var.name
        namespace = var.namespace
      }
      ClusterIssuer = {
        name = var.name
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
            http01 = {
              ingress = {
                class           = coalesce(var.ingress_class, null)
                name            = coalesce(var.ingress_name, null)
                serviceType     = coalesce(var.ingress_service_type, null)
                podTemplate     = coalesce(var.ingress_pod_template, null)
                ingressTemplate = coalesce(var.ingress_template, null)
              }
            }
          }
        ]
      }
    }
  }
}
