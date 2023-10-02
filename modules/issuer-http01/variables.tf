# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

variable "namespace" {
  type        = string
  description = "Kubernetes namespace."
  default     = null
}

variable "name" {
  type        = string
  description = "The name of the issuer."
  default     = "http01"
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

# https://cert-manager.io/docs/configuration/acme/http01/#class
variable "ingress_class" {
  type        = string
  description = "If the class field is specified, cert-manager will create new Ingress resources."
  default     = null
}

# https://cert-manager.io/docs/configuration/acme/http01/#name
variable "ingress_name" {
  type        = string
  description = "If the name field is specified, cert-manager will edit the named ingress resource in order to solve HTTP01 challenges."
  default     = null
}

variable "ingress_service_type" {
  type        = string
  description = "Define which Kubernetes service type to use during challenge response."
  default     = null
}

# https://cert-manager.io/docs/configuration/acme/http01/#podtemplate
variable "ingress_pod_template" {
  type        = string
  description = "Allow customize metadata and spec fields of solver pods."
  default     = null
}

# https://cert-manager.io/docs/configuration/acme/http01/#ingresstemplate
variable "ingress_template" {
  type        = string
  description = "Allow to add labels and annotations to the solver ingress resources."
  default     = null
}
