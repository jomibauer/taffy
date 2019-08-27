# ColdBox Base

This is the base template for ColdBox. 

After checking out the project, go to `/Application.cfc` to set your name and datasource accordingly.

Then navigate to the `/config/Coldbox.cfc` to edit the bulk of the project coniguration.

If you have any routes, set those up in `/config/Router.cfc`

## Quick Installation

This project contains a `sever.json` so it can leverage [CommandBox](http://www.ortussolutions.com/products/commandbox) to run locally.  
Just go into the project directory and type:

```
box server start
```

to run the application. You will still need to configure datasources and mail servers locally in the ColdFusion administrator. 
