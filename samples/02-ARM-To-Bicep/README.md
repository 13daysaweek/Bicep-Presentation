# ARM to Bicep
This example shows how to convert an existing ARM template to Bicep.  This folder contains an example ARM template for an Azure API Management resource.  

To decompile to ARM template to Bicep syntax, run the following command:

`az bicep decompile --file .\maintemplate.json`

Inspect the resulting Bicep template, `maintemplate.bicep`.  Observe that all resources, parameters, variables and outputs have been converted to their Bicep equivalents.