# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

variable "namespace" {
  type        = string
  default     = "cert-manager"
  description = "Namespace to deploy Coder to"
}

variable "name" {
  type        = string
  description = "Name of the certificate"
}

variable "issuer_kind" {
  type        = string
  default     = "ClusterIssuer"
  description = "Kind of the cert issuer to use"
  validation {
    condition     = contains(["ClusterIssuer", "Issuer"], var.issuer_kind)
    error_message = "The variable 'issuer_kind' must be 'ClusterIssuer' or 'Issuer'."
  }
}

variable "issuer_name" {
  type        = string
  default     = "self-signed-ca"
  description = "Name of the cert issuer to use"
}

variable "hostnames" {
  type        = list(string)
  default     = null
  description = "Hostnames to use for Coder"
}

variable "secret_name" {
  type        = string
  description = "Name of the secret to store the certificate in"
  default     = null
}

variable "common_name" {
  type        = string
  default     = null
  description = "Common name of the certificate"
}

variable "key_algorithm" {
  type        = string
  default     = "ECDSA"
  description = "Algorithm to use for the private key"
}

variable "key_size" {
  type        = number
  default     = 256
  description = "Size of the private key"
}

variable "is_ca" {
  type        = bool
  default     = false
  description = "Whether the certificate is a CA"
}
