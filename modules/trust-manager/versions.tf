# Copyright (c) 2023-2024 YKY Labs
# This code is licensed under MIT license (see LICENSE for details)


terraform {
  
  required_version = ">= 1.6"
  
  required_providers {
    
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }

  }
}
