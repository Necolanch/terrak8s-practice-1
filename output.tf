output "web_app_url" {
  description = "URL of the Hello World App Service"
  value       = azurerm_linux_web_app.app.default_hostname
}

output "app_insights_key" {
  description = "Instrumentation Key for Application Insights"
  value       = azurerm_application_insights.appinsights.instrumentation_key
  sensitive = true
}
