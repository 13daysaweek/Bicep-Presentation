param webAppName string
param webAppSku string = 'S1'
param webAppSkuCapacity int = 1
param appInsightsName string
param logAnalyticsWorkspaceName string
param location string

module logAnalytics 'br:cmhiac.azurecr.io/bicep/modules/loganalyticsworkspace:v1' = {
  name: '${logAnalyticsWorkspaceName}-deployment'
  params: {
    location: location
    workspaceName: logAnalyticsWorkspaceName
  }
}

module appInsights 'br:cmhiac.azurecr.io/bicep/modules/appinsights:v1' = {
  name: '${appInsightsName}-deployment'
  params: {
    location: location
    logAnalyticsWorkspaceId: logAnalytics.outputs.workspaceId
    appInsightsName: appInsightsName
  }
}

module webApp 'br:cmhiac.azurecr.io/bicep/modules/appservice:v1' = {
  name: '${webAppName}-deployment'
  params: {
    location: location
    appName: webAppName
    skuName: webAppSku
    skuCapacity: webAppSkuCapacity
    appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
  }
}
