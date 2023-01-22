# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

variable "name" {
  type        = string
  description = "The name of the issuer."
  default     = "ca"
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

variable "secret_name" {
  type        = string
  description = "The name of the secret which contains the CA certificate."
  default     = null
}

variable "create_certificate" {
  type        = bool
  description = "Set to 'true' to create the CA certificate."
  default     = true
}

variable "common_name" {
  type        = string
  description = "The common name of the created CA certificate. Defaults to 'name' variable."
  default     = null
}

variable "certificate_issuer_name" {
  type        = string
  description = "The name of the issuer used to create the CA certificate."
  default     = "self-signed"
}

variable "certificate_issuer_kind" {
  type        = string
  description = "The kind of the issuer used to create de CA certificate."
  default     = "ClusterIssuer"
}

variable "create_trust_bundle" {
  type        = bool
  description = "Create a trust-manager bundle with the CA certificate."
  default     = true
}
