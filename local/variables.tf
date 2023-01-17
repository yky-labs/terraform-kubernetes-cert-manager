# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

variable "name" {
  type        = string
  description = "The deploy name. Used to contextualize the name of the generated resources."
  default     = "cert-manager"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace."
}

variable "create_namespace" {
  type        = bool
  description = "Create the Kunernetes namespace."
  default     = false
}

variable "certmanager_chart_version" {
  type        = string
  description = "Cert-manager Helm Chart version."
  default     = null
}

variable "trustmanager_chart_version" {
  type        = string
  description = "Trust-manager Helm Chart version."
  default     = null
}
