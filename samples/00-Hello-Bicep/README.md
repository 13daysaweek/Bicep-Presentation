# Hello Bicep

This minimal example demonstrates basic Bicep syntax including parameters, variables, string interpolation and outputs.

If you don't already have Bicep installed, the easiest way to install is through az cli.  Bicep can be installed with the following commands:

```
az bicep install
```

Note that this requires az cli v2.20.0 or greater.

To transpile the tempalte to ARM JSON, run the following command:

```
az bicep build --file maintemplate.bicep
```
