# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


variable "namespace" {
  type        = string
  default     = "cert-manager"
  description = "Kubernetes namespace."
}

variable "deploy_name" {
  type        = string
  default     = "trust-manager"
  description = "The deploy name. Used to contextualize the name of the generated resources."
}

variable "deploy_version" {
  type        = string
  description = "Helm Chart version."
}

variable "deploy_values" {
  type        = list(string)
  default     = []
  description = "Additionals Helm Chart release values."
}
