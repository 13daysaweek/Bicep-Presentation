param storageAccountBaseName string
param location string
param numberOfStorageAccounts int

resource storageAccountResources 'Microsoft.Storage/storageAccounts@2021-04-01' = [for i in range(0, numberOfStorageAccounts): {
  name: '${storageAccountBaseName}${i}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
      }
    }
  }
}]

var subnets = [
  {
    name: 'web'
    subnetPrefix: '10.0.0.0/24'
  }
  {
    name: 'api'
    subnetPrefix: '10.0.1.0/24'
  }
  {
    name: 'db'
    subnetPrefix: '10.0.2.0/24'
  }
]

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: 'vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/8'
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.subnetPrefix
      }
    }]
  }
}
