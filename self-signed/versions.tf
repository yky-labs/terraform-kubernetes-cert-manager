# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

terraform {
  required_version = ">= 0.13"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}
