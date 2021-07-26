# DevOps
This example shows how to deploy a Bicep template, either via an [Azure DevOps pipeline](Azure Pipelines/) or a [GitHub Actions workflow](GitHub Actions/).  Note that both approaches rely on the same method to deploy the Bicep template, running the following command:

```
az deployment group create -n DEPLOYMENT_NAME -g RESOURCE_GROUP_NAME --template-file BICEP_FILE_PATH --parameters PARAMETER_KEYS_VALUES
```