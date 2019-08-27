<cfoutput>
	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col-12">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#event.buildLink(rc.xeh.viewGroupList)#">Group List</a></li>
				<li class="breadcrumb-item"><a href="#event.buildLink(rc.xeh.viewGroupCreate)#">Create Group</a></li>
			</ol>
		</div>
	</div>

	<form class="form-horizontal" action="#event.buildLink(action=rc.xeh.processGroupCreate)#" method="POST">
		<div class="row">
			<div class="col-8">

				<h2>Create Group</h2>
				<hr />

				<div id="groupName-form-group" class="row form-group <cfif session.messenger.fieldHasAlert("vcGroupName")>has-error</cfif>">
					<label class="control-label label-required col-3" for="groupName">Group Name:</label>
					<div class="col-4">
						<input type="text" id="groupName" name="vcGroupName" class="form-control" value="#rc.group.getVcGroupName()#" />
					</div>
					<div>
						<cfif session.messenger.fieldHasAlert("vcGroupName")><span class="help-block" id="groupName_serverSideErrorMessage"><span class="oi oi-warning"></span>#session.messenger.getAlertForField("vcGroupName").message#</span></cfif>
						<span class="help-block" id="groupName_loading" style="display:none;"><img src="includes/img/ajax-loader.gif" /></span>
						<span class="help-block" id="groupName_ok" style="display:none;"><span class="oi oi-check"></span></span>
						<span class="help-block" id="groupName_warning" style="display:none;"><span class="oi oi-warning"></span> That Group Name already exists.</span>
						<span class="help-block" id="groupName_required" style="display:none;"><span class="oi oi-warning"></span> Group Name is required.</span>
					</div>
				</div>

				<div id="groupAbbr-form-group" class="row form-group <cfif session.messenger.fieldHasAlert("vcGroupAbbr")>has-error</cfif>">
					<label class="control-label label-required col-3" for="groupAbbr">Group Abbr:</label>
					<div class="col-4">
						<input type="text" id="groupAbbr" name="vcGroupAbbr" class="form-control" value="#rc.group.getVcGroupAbbr()#" />
					</div>
					<div>
						<cfif session.messenger.fieldHasAlert("vcGroupAbbr")><span class="help-block" id="groupAbbr_serverSideErrorMessage"><span class="oi oi-warning"></span>#session.messenger.getAlertForField("vcGroupAbbr").message#</span></cfif>
						<span class="help-block" id="groupAbbr_loading" style="display:none;"><img src="includes/img/ajax-loader.gif" /></span>
						<span class="help-block" id="groupAbbr_ok" style="display:none;"><span class="oi oi-check"></span></span>
						<span class="help-block" id="groupAbbr_warning" style="display:none;"><span class="oi oi-warning"></span> That Abbreviation already exists.</span>
						<span class="help-block" id="groupAbbr_required" style="display:none;"><span class="oi oi-warning"></span> Group Abbreviation is required.</span>
					</div>
				</div>

				<div id="groupDesc-form-group" class="row form-group <cfif session.messenger.fieldHasAlert("vcGroupDesc")>has-error</cfif>">
					<label class="control-label label-required col-3" for="groupDesc">Description:</label>
					<div class="col-4">
						<textarea id="groupDesc" name="vcGroupDesc" class="form-control">#rc.group.getVcGroupDesc()#</textarea>
					</div>
					<div>
						<cfif session.messenger.fieldHasAlert("vcGroupDesc")><span class="help-block"><span class="oi oi-warning"></span>#session.messenger.getAlertForField("vcGroupDesc").message#</span></cfif>
						<span class="help-block" id="groupDesc_required" style="display:none;"><span class="oi oi-warning"></span> Group Description is required.</span>
					</div>
				</div>

				<div class="row form-group <cfif session.messenger.fieldHasAlert("vcGroupEmail")>has-error</cfif>">
					<label class="control-label col-3" for="groupEmail">Group Email:</label>
					<div class="col-4">
						<input type="text" id="groupEmail" name="vcGroupEmail" class="form-control" value="#rc.group.getVcGroupEmail()#" />
					</div>
					<div>
						<cfif session.messenger.fieldHasAlert("vcGroupEmail")><span class="help-block"><span class="oi oi-warning"></span>#session.messenger.getAlertForField("vcGroupEmail").message#</span></cfif>
					</div>
				</div>

				<div class="form-actions offset-3 col-4">
					<input type="hidden" name="groupID" value="#rc.group.getIntGroupID()#" />
					<input type="submit" value="Create Group" class="float-right btn btn-primary" />
				</div>
			</div>

			<div class="col-4">
				<div class="card bg-light">
					<p class="card-body mb-0">Fields that are <strong>bold</strong> are required.</p>
				</div>
			</div>
		</div>
	</form>

	<script>
		var PAGE = {
			xeh: {
				ajaxIsGroupNameAvailable: '#event.buildLink(rc.xeh.ajaxIsGroupNameAvailable)#',
				ajaxIsGroupAbbrAvailable: '#event.buildLink(rc.xeh.ajaxIsGroupAbbrAvailable)#'
			}
		};
	</script>

	<script src="includes/js/userManagement/groupCreate.js"></script>
</cfoutput>
