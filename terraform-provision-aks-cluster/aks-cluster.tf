# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "random_pet" "prefix" {}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  #  subscription_id   = "946717e6-ab3b-4301-807f-d2bc32ebd446"
  # tenant_id         = "81d3034d-5982-40fb-8c38-368f5a2f76ef"
  # client_id         = "0f4f88a7-d444-4ae0-b86b-53ff6a3677ef"
  # client_secret     = "AJH8Q~W~6LWPK.SOYDJyZNt4izHghIFjAaHfab.."
}

resource "azurerm_resource_group" "default" {
  name     = "my-rg"
  location = "West Europe"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "my-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "my-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "standard_DS2_v2"
    os_disk_size_gb = 30
  }
  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  

  tags = {
    environment = "Demo"
  }
}
