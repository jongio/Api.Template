param location string
param tags object
param servicePrefix string
param abbreviation string
param appServicePlanId string
param applicationInsightsConnectionString string

resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: '${abbreviation}${servicePrefix}-${location}-001'
  location: location
  tags: tags
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      ftpsState: 'Disabled'
      http20Enabled: true
      netFrameworkVersion: 'v6.0'
    }
    httpsOnly: true
  } 

  identity: {
    type: 'SystemAssigned'
  }

  resource appSettings 'config' = {
    name: 'appsettings'
    properties: {
      SCM_DO_BUILD_DURING_DEPLOYMENT: 'false'
      APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsightsConnectionString
      ASPNETCORE_ENVIRONMENT: 'Development'
    }
  }
}

output appServiceId string = appService.id
output defaultHostName string = appService.properties.defaultHostName
