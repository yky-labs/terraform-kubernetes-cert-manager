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
  default     = "cert-manager"
}

variable "create_namespace" {
  type        = bool
  description = "Create the Kunernetes namespace."
  default     = true
}

variable "chart_version" {
  type        = string
  description = "Helm Chart version."
}

variable "chart_values" {
  type        = list(string)
  description = "Additionals Helm Chart release values."
  default     = []
}
