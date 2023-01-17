# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

locals {
  name = (var.staging) ? "${var.name}-staging" : var.name
  server_url = coalesce(var.server_url, (
    (var.staging) ? 
      "https://acme-staging-v02.api.letsencrypt.org/directory" :
      "https://acme-v02.api.letsencrypt.org/directory"
  ))
}

resource "kubectl_manifest" "this" {

  yaml_body = <<-EOF
    apiVersion: cert-manager.io/v1
    kind: ${var.kind}
    metadata:
      name: ${local.name}
      %{~ if var.namespace != null ~}
      namespace: ${var.namespace}
      %{~ endif ~}
    spec:
      acme:
        email: ${var.email}
        server: ${local.server_url}
        privateKeySecretRef:
          name: ${local.name}-account-key
        solvers:
        - dns01:
            cloudflare:
              apiTokenSecretRef:
                name: ${var.api_token_secret}
                key: ${var.api_token_key}
  EOF

}
