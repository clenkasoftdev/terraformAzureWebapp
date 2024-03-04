resource "azurerm_resource_group" "clemic-demorg" {
  name     = "clemic-demorg"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.clemic-demorg.location
  resource_group_name = azurerm_resource_group.clemic-demorg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "clemic-demo-splan" {
  name                = "clemic-demo-splan"
  location            = azurerm_resource_group.clemic-demorg.location
  resource_group_name = azurerm_resource_group.clemic-demorg.name
  app_service_plan_id = azurerm_app_service_plan.clemic-demo-splan.id

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