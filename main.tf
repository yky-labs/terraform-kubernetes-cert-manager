# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

resource "kubernetes_namespace_v1" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
  }
}

# https://github.com/cert-manager/cert-manager/tree/master/deploy/charts/cert-manager

resource "helm_release" "cert_manager" {
  chart     = "jetstack/cert-manager"
  name      = var.name
  namespace = local.namespace
  version   = var.chart_version
  values    = concat(
    [ "installCRDs: true" ],
    var.chart_values
  )

  depends_on = [
    kubernetes_namespace_v1.this
  ]  
}
