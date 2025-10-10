terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.terrak8s-prefix}-rg"
  location = "East US 2"
}

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "${var.terrak8s-prefix}-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# Application Insights
resource "azurerm_application_insights" "appinsights" {
  name                = "${var.terrak8s-prefix}-logs"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

# Web App
resource "azurerm_linux_web_app" "app" {
  name                = "${var.terrak8s-prefix}-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      node_version = "20-lts"
    }
    always_on = "false"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.appinsights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.appinsights.connection_string
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"   = "false"
  }

  identity {
    type = "SystemAssigned"
  }
}