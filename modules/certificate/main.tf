# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


locals {
  secret_name = coalesce(var.secret_name, var.name)
  common_name = coalesce(var.common_name, var.name)
}

resource "kubernetes_manifest" "cert" {

  # The "isCA" and "dnsNames" properties are not returned in the manifest if they have a false or null value.
  # This causes Terraform to interpret that the resource has changed and forces an update.
  # To avoid this, the manifest needs to be dynamically defined, including only the properties that have a value.

  manifest = yamldecode(<<-EOF
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
      name: ${var.name}
      namespace: ${var.namespace}
    spec:
      %{if coalesce(var.is_ca, false)}
      isCA: true
      %{endif}
      commonName: ${local.common_name}
      issuerRef:
        name: ${var.issuer_name}
        kind: ${var.issuer_kind}
      secretName: ${local.secret_name}
      privateKey:
        algorithm: ${var.key_algorithm}
        size: ${var.key_size}
      %{if var.dns_names != null}
      dnsNames: ${jsonencode(var.dns_names)}
      %{endif}
  EOF
  )
  
}
