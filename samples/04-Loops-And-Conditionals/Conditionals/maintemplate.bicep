param webAppName string
param location string
param createAppInsights bool


var servicePlanName = 'asp-${webAppName}'
var workspaceName = '${webAppName}-la'
var appInsightsName = '${webAppName}-ai'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: servicePlanName
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
}

resource webApp 'Microsoft.Web/sites@2021-01-15' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
    }
  }
}

resource appServiceAppSettings 'Microsoft.Web/sites/config@2021-01-15' = if(createAppInsights) {
  parent: webApp
  name: 'appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsights.properties.InstrumentationKey
  }
}

resource appServiceExtension 'Microsoft.Web/sites/siteextensions@2021-01-15' = if(createAppInsights) {
  name: '${webApp.name}/Microsoft.ApplicationInsights.AzureWebsites'
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = if(createAppInsights) {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 120
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = if(createAppInsights) {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspace.id
  }
}
