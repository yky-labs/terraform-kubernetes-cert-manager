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

variable "deploy_name" {
  type        = string
  default     = "cert-manager"
  description = "The deploy name. Used to contextualize the name of the generated resources."
}

variable "deploy_version" {
  type        = string
  description = "Helm deploy version."
}

variable "deploy_values" {
  type        = list(string)
  default     = []
  description = "Additionals Helm deploy release values."
}
