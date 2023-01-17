# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

variable "name" {
  type        = string
  description = "The name of the issuer."
  default     = "self-signed"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace."
  default     = null
}

variable "kind" {
  type        = string
  description = "The kind of the issuer."
  default     = "ClusterIssuer"
  validation {
    condition     = contains(["ClusterIssuer", "Issuer"], var.kind)
    error_message = "The variable 'kind' must be 'ClusterIssuer' or 'Issuer'."
  }
}
