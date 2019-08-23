<cfoutput>

	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col-md-12">
			<ol class="breadcrumb">
				<li><a href="#buildURL(rc.xeh.viewGroupList)#">Group List</a></li>
				<li><a href="#buildURL(rc.xeh.viewGroupDetail & "/" & rc.group.getIntGroupID())#">Group: #rc.group.getVcGroupName()#</a></li>
				<li><a href="#buildURL(rc.xeh.viewGroupUpdate & "/" & rc.group.getIntGroupID())#">Update Group: #rc.group.getVcGroupName()#</a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-md-8">

			<h2>Update Group: #rc.group.getVcGroupName()#</h2>
			<form class="form-horizontal" action="#buildURL(action=rc.xeh.processGroupUpdate)#" method="POST">
				<div id="groupName-form-group" class="form-group <cfif session.messenger.fieldHasAlert("vcGroupName")>has-error</cfif>">
					<label class="control-label label-required col-md-3" for="groupName">Group Name:</label>
					<div class="col-md-4">
						#rc.group.getVcGroupName()#
					</div>
				</div>

				<div id="groupAbbr-form-group" class="form-group <cfif session.messenger.fieldHasAlert("vcGroupAbbr")>has-error</cfif>">
					<label class="control-label label-required col-md-3" for="groupAbbr">Group Abbr:</label>
					<div class="col-md-4">
						#rc.group.getVcGroupAbbr()#
					</div>
				</div>

				<div id="groupDesc-form-group" class="form-group <cfif session.messenger.fieldHasAlert("vcGroupDesc")>has-error</cfif>">
					<label class="control-label label-required col-md-3" for="groupDesc">Description:</label>
					<div class="col-md-4">
						<textarea id="groupDesc" name="vcGroupDesc" class="form-control">#rc.group.getVcGroupDesc()#</textarea>
					</div>
					<div>
						<cfif session.messenger.fieldHasAlert("vcGroupDesc")><span class="help-block"><span class="glyphicon glyphicon-warning-sign"></span>#session.messenger.getAlertForField("vcGroupDesc").message#</span></cfif>
						<span class="help-block" id="groupDesc_required" style="display:none;"><span class="glyphicon glyphicon-warning-sign"></span> Group Description is required.</span>
					</div>
				</div>
				<script>



				</script>

				<div class="form-group <cfif session.messenger.fieldHasAlert("vcGroupEmail")>has-error</cfif>">
					<label class="control-label col-md-3" for="groupEmail">Group Email:</label>
					<div class="col-md-4">
						<input type="text" id="groupEmail" name="vcGroupEmail" class="form-control" value="#rc.group.getVcGroupEmail()#" />
					</div>
					<div>
						<cfif session.messenger.fieldHasAlert("vcGroupEmail")><span class="help-block"><span class="glyphicon glyphicon-warning-sign"></span>#session.messenger.getAlertForField("vcGroupEmail").message#</span></cfif>
					</div>
				</div>

				<div class="form-actions col-md-offset-3 col-md-4">
					<input type="hidden" name="lastModifiedBy" value="#session.user.getVcUsername()#" />
					<input type="hidden" name="groupID" value="#rc.group.getIntGroupID()#" />
					<input type="submit" value="Update Group" class="btn btn-primary" />
				</div>
			</form>
		</div>

		<div class="col-md-4">
			<div class="well">
				<p>Fields that are <strong>bold</strong> are required.</p>
			</div>
		</div>
	</div>

	<script>
		var PAGE = {};
	</script>

	<script src="/assets/js/userManagement/groupUpdate.js"></script>

</cfoutput>