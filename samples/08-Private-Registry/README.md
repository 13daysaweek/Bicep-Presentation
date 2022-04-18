# Private Registries
Bicep supports the concept of private registries to share modules across an organization.  Bicep registries use Azure Container Registry to enable storing and retrieving Bicep modules in the same way Docker uses ACR to store and retrieve Docker images.

To test the private registry capability with the files in this sample, create an Azure Container Registry, then run the following az cli commands:

```
az bicep publish --file .\logAnalyticsWorkspace.bicep --target br:{your ACR login server}/bicep/modules/loganalyticsworkspace:v1

az bicep publish --file .\appInsights.bicep --target br:{your ACR login server}/bicep/modules/appinsights:v1

az bicep publish --file .\appService.bicep --target br:{your ACR login server}/bicep/modules/appservice:v1
```
Note that when publishing a module to a registry, the module name must be lower case.  Like Docker images, modules published to a registry are tagged/versioned.  In the example above, the tag for each module is ```v1```.

After publishing the modules, update ```maintemplate.bicep``` so that the ACR login server address for each referenced module matches your ACR login server.