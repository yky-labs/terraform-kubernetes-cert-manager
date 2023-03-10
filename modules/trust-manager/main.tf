# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

# https://github.com/cert-manager/trust-manager/blob/main/deploy/charts/trust-manager

resource "helm_release" "this" {
  namespace = var.namespace
  chart     = "jetstack/trust-manager"
  name      = var.name
  version   = var.chart_version
  values    = var.chart_values
}
