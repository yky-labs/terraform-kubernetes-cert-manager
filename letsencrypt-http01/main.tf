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
        %{~ if var.email != null ~}
        email: ${var.email}
        %{~ endif ~}
        server: ${local.server_url}
        privateKeySecretRef:
          name: ${local.name}-account-key
        solvers:
        - http01:
            ingress:
              class: ${coalesce(var.ingress_class, "null")}
              name: ${coalesce(var.ingress_name, "null")}
              serviceType: ${coalesce(var.ingress_service_type, "null")}
              podTemplate: ${coalesce(var.ingress_pod_template, "null")}
              ingressTemplate: ${coalesce(var.ingress_template, "null")}
  EOF

}
