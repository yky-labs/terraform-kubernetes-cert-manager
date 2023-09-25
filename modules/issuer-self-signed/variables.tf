# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

variable "namespace" {
  type        = string
  description = "Kubernetes namespace."
  default     = "cert-manager"
}

variable "name" {
  type        = string
  description = "The name of the issuer."
}

variable "kind" {
  type        = string
  default     = "ClusterIssuer"
  description = "Kind of the cert issuer to use"
  validation {
    condition     = contains(["ClusterIssuer", "Issuer"], var.kind)
    error_message = "The variable 'kind' must be 'ClusterIssuer' or 'Issuer'."
  }
}