# Dependencies
This example shows how Bicep can automatically determine dependencies between resources.  The template creates a Windows virtual machine and associated resources, including a storage account, a network interface, a virtual network, a subnet, a public IP and an NSG.  A number of these resources are referenced by other resources in the template, so for the template to successfully deploy, they must be created in the correct order.  For example, the VM references the network interface, so the network interface has to be created before the VM.  In ARM, we need to manually define these dependencies via the dependsOn array on each resource.  Using Bicep, dependencies are determined automatically

Observe that in the Bicep template, we set the ID of the network interface:

```
networkInterfaces: [
  {
    id: nic.id
  }
]
```

`nic.id` is a symbolic reference, using the `nic` resource we defined earlier in the template.  Since we used a symbolic reference, when Bicep transpiles to ARM JSON, it's able to determine that the VM depends on the network interface.  In the resulting ARM template, we can see that the VM has two dependencies defined, one for the network interface and one for the storage account.

```
"dependsOn": [
  "[resourceId('Microsoft.Network/networkInterfaces', variables('nicName'))]",
  "[resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))]"
]
```