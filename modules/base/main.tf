# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

# Install cert-manager.
module "cert_manager" {
  source = "../.."

  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart_version    = var.certmanager_chart_version
}

# Install cert-manager's trust-manager.
module "trust_manager" {
  source = "../trust-manager"

  namespace     = var.namespace
  chart_version = var.trustmanager_chart_version

  depends_on = [
    module.cert_manager
  ]
}

# Install self-signed issuer.
module "issuer_self_signed" {
  source = "../issuer-self-signed"

  namespace = var.namespace
  name      = "self-signed"

  depends_on = [
    module.trust_manager
  ]
}

# Install self-signed CA issuer.
module "issuer_ca" {
  source = "../issuer-ca"

  namespace               = var.namespace
  name                    = "self-signed-ca"
  certificate_issuer_name = module.issuer_self_signed.name

  depends_on = [
    module.issuer_self_signed
  ]
}
