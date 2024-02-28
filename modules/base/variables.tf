# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


variable "namespace" {
  type        = string
  default     = "cert-manager"
  description = "Kubernetes namespace."
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Create the Kunernetes namespace."
}

variable "certmanager_deploy_version" {
  type        = string
  description = "Cert-manager Helm Chart version."
}

variable "certmanager_deploy_values" {
  type        = list(string)
  default     = []
  description = "Cert-manager Helm Chart values."
}

variable "trustmanager_deploy_version" {
  type        = string
  description = "Trust-manager Helm Chart version."
}

variable "trustmanager_deploy_values" {
  type        = list(string)
  default     = []
  description = "Trust-manager Helm Chart values."
}

variable "create_issuers" {
  type        = bool
  description = "Create the issuers."
}
