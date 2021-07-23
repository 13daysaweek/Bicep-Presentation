# Loops
This example shows two different approaches to handling loops inside of a Bicep template.

The first example shows how you can create X number of identical resources.  The template takes an input parameter indicating the number of Storage Accounts to create.  Observe that in the resource definition for the storage account we have a `for` statement that will iterate based on the value passed in for `numberOfStorageAccounts`:

```
resource storageAccountResources 'Microsoft.Storage/storageAccounts@2021-04-01 = [for i in range(0, numberOfStorageAccounts): {
...
```
Notice that in the ARM template, the Storage Account resource has a `copy` directive, using the `numberOfStorageAccounts` parameter.


The second example shows how we can define an array in our template, in this example, an array of subnets to attach to a Virtual Network.  Observe that on the `subnets` property of the Virtual Network, we iterate over the `subnets` array that was defined in the template:

```
subnets: [for subnet in subnets: {
...
```

Notice that in the ARM template, this has been converted to a `copy` directive. 
