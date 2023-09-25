# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

# Self-signed certificate's issuer.
resource "kubectl_manifest" "this" {

  yaml_body = <<-EOF
    apiVersion: cert-manager.io/v1
    kind: ${var.kind}
    metadata:
      name: ${var.name}
    spec:
      selfSigned: {}  
  EOF

}
