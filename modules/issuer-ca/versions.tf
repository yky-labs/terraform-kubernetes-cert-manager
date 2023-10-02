# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

terraform {
  
  required_version = ">= 1.5"

  required_providers {

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }

  }

}
