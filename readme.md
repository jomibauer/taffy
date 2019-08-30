# ColdBox Base

This is the base template for ColdBox. So far it has been tested and run on CF18 (mainly) and Lucee 4.5. 


### Application Config
After checking out the project, go to `/Application.cfc` to set your name and datasource (in the getDSN function) accordingly.


### Coldbox Settings
Then navigate to the `/config/Coldbox.cfc` to edit the bulk of the project coniguration. 

In this file you will likely want to set up environments. It will already have default settings for production and an environment for local development but once the project is deployed to a QA space it will need an environment for that as well.


### Routes
If you have any routes, set those up in `/config/Router.cfc`. There are a few examples to work off of. (and obviously you can search for "coldbox routes" to find the wiki on how those are used) 

## Quick Installation

This project contains a `sever.json` so it can leverage [CommandBox](http://www.ortussolutions.com/products/commandbox) to run locally.  
Just go into the project directory and type:

```
box server start
```

to run the application. You will still need to configure datasources and mail servers locally in the ColdFusion administrator.

## Helpful Things
By default, adding `fwreinit=true` (for prod you will need the reinitPassword from the config) to the url will refresh handler changes. Model information (domain, services, gateways) sometimes like to hold on so incrementing the name in the Application.cfc should usually clear those out.
  
Try to maintain clear organization between the request collection (rc) and private request collection (prc) when processing data in your events.

The rc contains FORM/REMOTE/URL data merged into a single structure. You should access this information (and validate it) to perform operations.

The prc is a structure you can put processed data into and display on the page. (You can still display rc values just be aware if you have validated its format). 