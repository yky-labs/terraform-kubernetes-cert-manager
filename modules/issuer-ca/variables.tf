# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

variable "namespace" {
  type        = string
  default     = null
  description = "Namespace to deploy the issuer to"
}

variable "name" {
  type        = string
  description = "Name of the issuer"
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

variable "create_certificate" {
  type        = bool
  default     = true
  description = "Whether to create a certificate"
}

variable "certificate_name" {
  type        = string
  default     = null
  description = "Name of the certificate"
}

variable "certificate_issuer_name" {
  type        = string
  description = "Name of the cert issuer to use"
}

variable "certificate_issuer_kind" {
  type        = string
  default     = "ClusterIssuer"
  description = "Kind of the cert issuer to use"
  validation {
    condition     = contains(["ClusterIssuer", "Issuer"], var.certificate_issuer_kind)
    error_message = "The variable 'certificate_issuer_kind' must be 'ClusterIssuer' or 'Issuer'."
  }
}

variable "certificate_secret_name" {
  type        = string
  description = "Name of the secret to store the certificate in"
  default     = null
}

variable "certificate_common_name" {
  type        = string
  description = "Common name of the certificate"
  default     = null
}

variable "certificate_key_algorithm" {
  type        = string
  default     = "ECDSA"
  description = "Algorithm to use for the private key"
}

variable "certificate_key_size" {
  type        = number
  default     = 256
  description = "Size of the private key"
}

variable "create_trust_bundle" {
  type        = bool
  description = "Create a trust-manager bundle with the CA certificate."
  default     = true
}

variable "trust_bundle_name" {
  type        = string
  description = "The name of the trust-manager bundle."
  default     = null
}
