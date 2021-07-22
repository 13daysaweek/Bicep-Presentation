param skuName string
param skuCapacity int
param location string
param appName string
param appInsightsInstrumentationKey string

var servicePlanName = 'asp-${appName}'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: servicePlanName
  location: location
  sku: {
    name: skuName
    capacity: skuCapacity
  }
}

resource webApp 'Microsoft.Web/sites@2021-01-15' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
    }
  }
}

resource appServiceAppSettings 'Microsoft.Web/sites/config@2021-01-15' = {
  parent: webApp
  name: 'appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsightsInstrumentationKey
  }
}

resource appServiceExtension 'Microsoft.Web/sites/siteextensions@2021-01-15' = {
  name: '${webApp.name}/Microsoft.ApplicationInsights.AzureWebsites'
}
