# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

module "cert_manager" {
  source = "../"

  chart_version    = var.certmanager_chart_version
  namespace        = var.namespace
  create_namespace = var.create_namespace
}

module "trust_manager" {
  source = "../trust-manager"

  chart_version = var.trustmanager_chart_version
  namespace     = var.namespace

  depends_on = [
    module.cert_manager
  ]
}

module "self_signed" {
  source = "../self-signed"

  namespace = var.namespace

  depends_on = [
    module.trust_manager
  ]
}

module "ca" {
  source = "../ca"

  namespace = var.namespace

  depends_on = [
    module.self_signed
  ]
}
