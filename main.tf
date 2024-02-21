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
  values = concat([
    <<-EOF
    installCRDs: true
    resources:
      limits:
        cpu: 10m
        memory: 64Mi
      requests:
        cpu: 2m
        memory: 32Mi
    webhook:
      resources:
        limits:
          cpu: 10m
          memory: 56Mi
        requests:
          cpu: 2m
          memory: 28Mi
    cainjector:
      resources:
        limits:
          cpu: 10m
          memory: 56Mi
        requests:
          cpu: 2m
          memory: 28Mi
    EOF
    ],
    var.chart_values
  )

  depends_on = [
    kubernetes_namespace_v1.this
  ]
}
