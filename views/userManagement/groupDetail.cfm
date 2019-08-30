<cfoutput>
	<cfinclude template="includes/_menu.cfm" />

	<div class="row">
		<div class="col-12">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#event.buildLink(prc.xeh.viewGroupList)#">Group List</a></li>
				<li class="breadcrumb-item"><a href="#event.buildLink(prc.xeh.viewGroupDetail & "/" & rc.group.getIntGroupID())#">Group: #rc.group.getVcGroupName()#</a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-8">

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
					<td><cfif len(rc.createdBy.getVcEmail())>#rc.createdBy.getVcEmail()# /</cfif> #rc.formatterService.formatDate(rc.group.getDtCreatedOn())#</td>
				</tr>
				<cfif rc.group.getIntLastModifiedBy()>
					<tr>
						<th>Last Modified:</th>
						<td><cfif len(rc.lastModifiedBy.getVcEmail())>#rc.lastModifiedBy.getVcEmail()# /</cfif> #rc.formatterService.formatDate(rc.group.getDtLastModifiedOn())#</td>
					</tr>
				</cfif>
			</table>
		</div>

		<div class="col">
			<div class="card bg-light mb-3">
				<div class="card-body">
					<p>To update this group, click the button below.</p>
					<a href="#event.buildLink(prc.xeh.viewGroupUpdate & "/" & rc.group.getIntGroupID())#" class="btn btn-primary">Update Group</a>
				</div>
			</div>
		</div>
	</div>

</cfoutput>