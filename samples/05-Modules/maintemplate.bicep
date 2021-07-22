param webAppName string
param webAppSku string = 'S1'
param webAppSkuCapacity int = 1
param appInsightsName string
param logAnalyticsWorkspaceName string
param location string

module logAnalytics 'modules/logAnalyticsWorkspace.bicep' = {
  name: '${logAnalyticsWorkspaceName}-deployment'
  params: {
    location: location
    workspaceName: logAnalyticsWorkspaceName
  }
}

module appInsights 'modules/appInsights.bicep' = {
  name: '${appInsightsName}-deployment'
  params: {
    location: location
    logAnalyticsWorkspaceId: logAnalytics.outputs.workspaceId
    appInsightsName: appInsightsName
  }
}

module webApp 'modules/appService.bicep' = {
  name: '${webAppName}-deployment'
  params: {
    location: location
    appName: webAppName
    skuName: webAppSku
    skuCapacity: webAppSkuCapacity
    appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
  }
}
