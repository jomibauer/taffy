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

	<script src="includes/js/importUpload/index.js"></script>
</cfoutput>