<cfoutput>
	<div class="row" id="sizeAlertContainer" style="display:none;">
		<div class="col">
			<div class="alert alert-danger">
				<strong>Error!</strong> Attachment size must be under 20 MB.
			</div>
		</div>
	</div>

	<div class="card bg-light">
		<div class="card-body mb-0">
			<p> Click here to download the import template. Fill out each row with the record you wish to import. Files with over 3500 records will not be accepted. The system currently only supports Excel file. </p>
			<a id="downloadImportUploadTemplate" class="btn btn-primary text-white float-right" target="_blank">Download Template</a>
		</div>
	</div>
	<br><br>
	<div class="card bg-light">
		<div class="card-body mb-0">
			<form name="importUploadForm" method="POST" action="#event.buildLink(prc.xeh.import)#" enctype="multipart/form-data">
				<p> Click here to upload your updated Excel Template</p>
				<p><input class="form-control required" id="fileUpload" name="fileUpload" type="file" /></p>

				<div class="row">
					<div class="col">
						<p><input id="removeExistingRecordCheckbox" name="removeExistingRecordCheckbox" type="checkbox"> Remove Existing Records</p>
					</div>
					</div class="col">
						<span class="float-right" id="importLoading"><img src="includes/img/ajax-loader.gif" /></span>
						<button id="importBtn" type="submit" class="btn btn-primary float-right">Import</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!--- TODO: Remove for production START --->
		<div style="width: auto;text-align: center;margin: auto;padding: 50px;">
			<h2>Company List</h2>
			<table class="table table-sm table-hover table-bordered table-striped">
				<tr>
					<th>Company ID</th>
					<th>Company Name</th>
					<th>Contact Name</th>
					<th>Contact Email</th>
					<th>Contact Phone</th>
					<th>Company UUID</th>
					<th>Default Payment Terms</th>
					<th>Default Hourly Rate</th>
					<th>Date Modified</th>
					<th>Date Created</th>
				</tr>
				<cfloop array="#rc.companies#" item="company">
				<tr>
					<td>#company.getIntCompanyID()#</td>
					<td>#company.getVcName()#</td>
					<td>#company.getVcContactName()#</td>
					<td>#company.getVcContactEmail()#</td>
					<td>#company.getVcContactPhone()#</td>
					<td>#company.getVcCompanyUUID()#</td>
					<td>#company.getVcDefaultPaymentTerms()#</td>
					<td>#company.getFlDefaultHourlyRate()#</td>
					<td>#dateFormat(company.getDtModifiedOn(), "yyyy-mm-dd")#</td>
					<td>#dateFormat(company.getDtCreatedOn(), "yyyy-mm-dd")#</td>
				</tr>
			</cfloop>
			</table>
		</div>
	<!--- TODO: Remove for production END --->

	<script src="includes/js/importUpload/index.js"></script>
</cfoutput>