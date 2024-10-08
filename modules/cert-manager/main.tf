# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


locals {
  namespace = (var.create_namespace) ? kubernetes_namespace_v1.this[0].metadata[0].name : var.namespace
}

resource "kubernetes_namespace_v1" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
  }
}

# https://github.com/cert-manager/cert-manager/tree/master/deploy/charts/cert-manager
resource "helm_release" "cert_manager" {

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  namespace = local.namespace
  name      = var.deploy_name
  version   = var.deploy_version

  values = concat([
    <<-EOF
    installCRDs: true
    config:
      apiVersion: controller.config.cert-manager.io/v1alpha1
      kind: ControllerConfiguration
      featureGates:
        ExperimentalGatewayAPISupport: true
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
    var.deploy_values
  )

}
