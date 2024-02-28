# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


variable "namespace" {
  type        = string
  description = "Kubernetes namespace."
  default     = null
}

variable "name" {
  type        = string
  description = "The name of the issuer."
  default     = "dns01-cloudflare"
}

variable "server_url" {
  type        = string
  description = "ACME server url."
  default     = null
}

variable "email" {
  type        = string
  description = "Email is the email address to be associated with the ACME account. This field is optional, but it is strongly recommended to be set."
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

variable "staging" {
  type        = bool
  description = "Set to true to use staging ACME server."
  default     = false
}

variable "api_token_secret" {
  type        = string
  description = "Name of the secret containing the Cloudflare API Token."
  default     = null
}

variable "api_token_key" {
  type        = string
  description = "Key inside the secret with the Cloudflare API Token."
  default     = null
}
