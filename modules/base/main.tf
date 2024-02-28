# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


# Install cert-manager.
module "cert_manager" {
  source = "../cert-manager"

  namespace        = var.namespace
  create_namespace = var.create_namespace
  deploy_version   = var.certmanager_deploy_version
  deploy_values    = var.certmanager_deploy_values
}

# Install cert-manager's trust-manager.
module "trust_manager" {
  source = "../trust-manager"

  namespace      = var.namespace
  deploy_version = var.trustmanager_deploy_version
  deploy_values  = var.trustmanager_deploy_values

  depends_on = [
    module.cert_manager
  ]
}

# Install self-signed issuer.
module "issuer_self_signed" {
  source = "../issuer-self-signed"
  count  = var.create_issuers ? 1 : 0

  namespace = var.namespace
  name      = "self-signed"

  depends_on = [
    module.trust_manager
  ]
}

# Install self-signed CA issuer.
module "issuer_ca" {
  source = "../issuer-ca"
  count  = var.create_issuers ? 1 : 0

  namespace               = var.namespace
  name                    = "self-signed-ca"
  certificate_issuer_name = module.issuer_self_signed[0].name

  depends_on = [
    module.issuer_self_signed
  ]
}
