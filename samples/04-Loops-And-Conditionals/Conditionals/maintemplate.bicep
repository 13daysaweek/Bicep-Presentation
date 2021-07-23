param webAppName string
param location string
param vnetIntegration bool = false

var aspName = 'asp-${webAppName}'
var vnetName = '${webAppName}-vnet'

resource serverFarm 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: aspName
  location: location
  sku: {
    name: 'S1'
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = if(vnetIntegration) {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/8'
      ]
    }
    subnets: [
      {
        name: 'web'
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: [
            {
              name: 'webDelegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
    ]
  }
}

resource webApp 'Microsoft.Web/sites@2021-01-15' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: serverFarm.id
    virtualNetworkSubnetId: vnetIntegration ? vnet.properties.subnets[0].id : ''
    httpsOnly: true
    siteConfig: {
      vnetRouteAllEnabled: true
      http20Enabled: true
    }
  }
}
