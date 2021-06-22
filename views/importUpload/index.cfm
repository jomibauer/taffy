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

		<cfif !rc.isProduction>
			<div style="width: auto;text-align: center;margin: auto;">
				<h2>Sample List</h2>
				<table class="table table-sm table-hover table-bordered table-striped">
					<tr>
						<th>Sample ID</th>
						<th>Sample Name</th>
						<th>Sample Email</th>
						<th>Sample Phone</th>
						<th>Sample UUID</th>
						<th>Date Modified</th>
						<th>Date Created</th>
					</tr>
					<cfloop array="#rc.samples#" item="sample">
					<tr>
						<td>#sample.getIntSampleID()#</td>
						<td>#sample.getVcSampleName()#</td>
						<td>#sample.getVcSampleEmail()#</td>
						<td>#sample.getVcSamplePhone()#</td>
						<td>#sample.getVcSampleUUID()#</td>
						<td><cfif dateFormat(sample.getDtModifiedOn(), "yyyy-mm-dd") neq "1970-01-01">#dateFormat(sample.getDtModifiedOn(), "yyyy-mm-dd")#</cfif></td>
						<td><cfif dateFormat(sample.getDtCreatedOn(), "yyyy-mm-dd") neq "1970-01-01">#dateFormat(sample.getDtCreatedOn(), "yyyy-mm-dd")#</cfif></td>
					</tr>
				</cfloop>
				</table>
			</div>
		</cfif>
	</div>


	<script src="includes/js/importUpload/index.js"></script>
</cfoutput>