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

You cannot inject sevices into domains in Coldbox. For example, previously we could use `property formatterService;` at the top of User.cfc and use it to format things in helper functions like `getFormattedName()`. Now you'll need to process that data with the formatter service in the handler or view to display it.

## FW/1 Things in Coldbox
#### Redirecting
`fw.redirect` is `relocate` and you pass an "event" instead of an "action"

#### Populating a Model
`fw.populate` is `populateModel`

#### Setting a View/Layout
`fw.setView` is `event.setView`

`fw.setLayout` is `event.setLayout`

#### Rendering Data
`fw.renderData("json", false)` (like for ajax events) is instead done by setting `renderdata="json"` on the event function and just returning the data.

#### Component Properties
```
property userService
```
 is
 ```
 property name="userService" inject="userService"
 ```
 The inject is necessary because wirebox will use that to find the model by name.

```
property never
```
is
```
property name="never" inject="coldbox:setting:never"
```
You can inject any coldbox setting from the config/Coldbox.cfc this way. (Note: in most places, you can also do a `getSetting("never")` call to retrieve it. This is useful if you only need a setting in one place.)

#### Creating an Empty Model
```
beanFactory.getBean("User")
```
is
```
new model.domains.User()
```
Coldbox does not use bean factory but wirebox lets you create an object using the `new` command with the path to the domain

#### Preserving Data Across Requests
Preserving data across requests in FW/1 was done like this:
```
fw.redirect(action='userManagement.viewUserCreate', preserve='user');
```
ColdBox has a built-in Flash RAM that we use in this way:
```
flash.put(name="user", value=rc.user);
relocate(event='userManagement/viewUserCreate');
```
There is no "preserve" argument available for the redirect. Keeping data across a redirect will always take two calls unless it is an id you are passing in the url. But this method gives us the ability for more fine-tuned controlling of preserving data. We can specify the name of the data as well as where it comes from and which request collection it should be placed into. It will automatically be removed from the flash ram after being loaded unless `autoPurge=false` is passed to the put call.

`flash.put` will default to the settings specified in the flash struct in the config/Coldbox.cfc. Those settings tell it to default to placing items back into the rc by default. If you want to preserve something in the prc you need to specify that by doing the put call this way:
```
flash.put(name="name", value=prc.name, inflateToRC=false, inflateToPRC=true);
```
The only difference is specifying `inflateToPRC=false` and `inflateToPRC=true`. If you fail to specify inflateToRC=false, the item you preserve will be inflated to both RC and PRC and may cause you some confusion later.

## Import Upload
Currently, application only imports and exports excel (.xlsx) file. Additionally, cfspreadsheet extension is required for application to read and write excel file.

### Steps to download cfspreadsheet extension:
```
Login to Lucee server > Extension > Applications > Select `cfspreadsheet Application` > Select latest version from dropdown > Install
```

### A few things to note about file directory:
*archive* - store all imported files

*temp/importUpload* - store imported files with System Note text

*templates* - store template files; Empty `System Note` column required for template to work