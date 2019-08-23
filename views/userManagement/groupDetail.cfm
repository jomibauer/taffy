<cfoutput>

	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col-md-12">
			<ol class="breadcrumb">
				<li><a href="#buildURL(rc.xeh.viewGroupList)#">Group List</a></li>
				<li><a href="#buildURL(rc.xeh.viewGroupDetail & "/" & rc.group.getIntGroupID())#">Group: #rc.group.getVcGroupName()#</a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-md-8">

			<h2>Group: #rc.group.getVcGroupName()#</h2>

			<table class="table table-detail table-condensed">
				<tr>
					<th>Abbr:</th>
					<td>#rc.group.getVcGroupAbbr()#</td>
				</tr>
				<tr>
					<th style="width: 200px;">Desc:</th>
					<td>#rc.group.getVcGroupDesc()#</td>
				</tr>
				<tr>
					<th>Email:</th>
					<td>#rc.group.getVcGroupEmail()#</td>
				</tr>
				<tr>
					<th>Created:</th>
					<td>#rc.createdBy.getVcUsername()# / #rc.formatterService.formatDate(rc.group.getDtCreatedOn())#</td>
				</tr>
				<cfif len(rc.group.getIntLastModifiedBy())>
					<tr>
						<th>Last Modified:</th>
						<td>#rc.lastModifiedBy.getVcUsername()# / #rc.formatterService.formatDate(rc.group.getDtLastModifiedOn())#</td>
					</tr>
				</cfif>
			</table>
		</div>

		<div class="col-md-4">
			<div class="well">
				<p>To update this group, click the button below.</p>
				<a href="#buildURL(rc.xeh.viewGroupUpdate & "/" & rc.group.getIntGroupID())#" class="btn btn-default">Update Group</a>
			</div>
		</div>
	</div>



</cfoutput>