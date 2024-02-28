# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


# https://github.com/cert-manager/trust-manager/blob/main/deploy/charts/trust-manager
resource "helm_release" "this" {
  namespace = var.namespace
  chart     = "jetstack/trust-manager"

  name      = var.deploy_name
  version   = var.deploy_version

  values = concat([
    <<-EOF
    resources:
      limits:
        cpu: 10m
        memory: 56Mi
      requests:
        cpu: 2m
        memory: 28Mi
    EOF
    ],
    var.deploy_values
  )

}
