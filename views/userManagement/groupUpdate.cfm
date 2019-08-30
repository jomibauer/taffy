<cfoutput>
	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col-12">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#event.buildLink(prc.xeh.viewGroupList)#">Group List</a></li>
				<li class="breadcrumb-item"><a href="#event.buildLink(prc.xeh.viewGroupDetail & "/" & rc.group.getIntGroupID())#">Group: #rc.group.getVcGroupName()#</a></li>
				<li class="breadcrumb-item"><a href="#event.buildLink(prc.xeh.viewGroupUpdate & "/" & rc.group.getIntGroupID())#">Update Group: #rc.group.getVcGroupName()#</a></li>
			</ol>
		</div>
	</div>

	<form class="form-horizontal" action="#event.buildLink(prc.xeh.processGroupUpdate)#" method="POST">
		<div class="row">
			<div class="col">
				<h2>Update Group: #rc.group.getVcGroupName()#</h2>
				<hr />

				<div class="row">
					<label class="control-label label-required col-3" for="groupName">Group Name:</label>
					<div class="col-4">
						#rc.group.getVcGroupName()#
					</div>
				</div>

				<div class="row">
					<label class="control-label label-required col-3" for="groupAbbr">Group Abbr:</label>
					<div class="col-4">
						#rc.group.getVcGroupAbbr()#
					</div>
				</div>

				<div class="row">
					<label class="control-label label-required col-3" for="groupDesc">Description:</label>
					<div class="col-4">
						<textarea id="groupDesc" name="vcGroupDesc" class="form-control <cfif session.messenger.fieldHasAlert('vcGroupDesc')>is-invalid</cfif>">#rc.group.getVcGroupDesc()#</textarea>
					</div>
				</div>

				<br />

				<div class="row">
					<label class="control-label col-3" for="groupEmail">Group Email:</label>
					<div class="col-4">
						<input type="text" id="groupEmail" name="vcGroupEmail" class="form-control <cfif session.messenger.fieldHasAlert('vcGroupEmail')>is-invalid</cfif>" value="#rc.group.getVcGroupEmail()#" />
					</div>
				</div>

				<br />

				<div class="row">
					<div class="offset-3 col-4">
						<input type="hidden" name="lastModifiedBy" value="#session.user.getVcEmail()#" />
						<input type="hidden" name="groupID" value="#rc.group.getIntGroupID()#" />
						<input type="submit" value="Update Group" class="btn btn-primary float-right" />
					</div>
				</div>
			</div>

			<div class="col-4">
				<div class="card bg-light">
					<p class="card-body">Fields that are <strong>bold</strong> are required.</p>
				</div>
			</div>
		</div>
	</form>

	<script src="includes/js/userManagement/groupUpdate.js"></script>

</cfoutput>