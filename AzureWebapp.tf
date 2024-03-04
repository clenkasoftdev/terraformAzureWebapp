resource "azurerm_resource_group" "clemic-demorg" {
  name     = "clemic-demorg"
  location = "West Europe"
}

resource "azurerm_service_plan" "clemic-demorg-applan" {
  name                = "clemic-demorg-applan"
  location            = azurerm_resource_group.clemic-demorg.location
  resource_group_name = azurerm_resource_group.clemic-demorg.name
  sku_name            = "P1v2"
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "clemic-demo-app" {
  name                = "clemic-demo-app"
  location            = azurerm_resource_group.clemic-demorg.location
  resource_group_name = azurerm_resource_group.clemic-demorg.name
  service_plan_id     = azurerm_service_plan.clemic-demorg-applan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "KEY1" = "testkey"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
