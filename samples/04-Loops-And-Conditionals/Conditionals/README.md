# Condtionals
This sample shows two approaches for handling conditional logic in a Bicep template.  The template creates a Web App and optionally vnet integrates it, depending on the value of the `vnetIntegration` parameter.  

Observe that on the resource defintion for the Virtual Network, we use the `if(vnetIntegration)` statement.  In the corresponding ARM template, notice that the JSON definition for the Virtual Network there is a `condition` element, set to the value of the `vnetIntegration` parameter.

Observe that on the resource defintion for the Web App, the assignment for the `virtualNetworkSubnetId` uses a ternary expression to set the value to the id of the subnet from the Virtual Network when `vnetIntegration` is set the `true` and `''` when false.  Notice that in the ARM template, the `virtualNetworkSubnetId` uses the ARM `if()` function to conditionally set the value of this property based on the value of `vnetIntegration`. 