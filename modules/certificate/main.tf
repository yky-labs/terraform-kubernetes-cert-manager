# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

locals {

  secret_name = coalesce(var.secret_name, var.name)
  common_name = coalesce(var.common_name, var.name)

}

resource "kubectl_manifest" "cert" {
  yaml_body = <<-EOF
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
      name: ${var.name}
      namespace: ${var.namespace}
    spec:
      isCA: ${var.is_ca}
      commonName: ${local.common_name}
      issuerRef:
        name: ${var.issuer_name}
        kind: ${var.issuer_kind}
      secretName: ${local.secret_name}
      privateKey:
        algorithm: ${var.key_algorithm}
        size: ${var.key_size}
      dnsNames:
        %{for hostname in var.hostnames~}
        - ${hostname}
        %{endfor~}
  EOF
}
