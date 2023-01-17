# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

locals {
  namespace = (var.create_namespace) ? kubernetes_namespace_v1.this[0].metadata[0].name : var.namespace
}
