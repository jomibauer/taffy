component extends="coldbox.system.EventHandler" {

	property name="acceptedMimeTypes" inject="coldbox:setting:acceptedMimeTypes";
	property name="importUploadService" inject="importUploadService";
	property name="spreadSheetService" inject="spreadSheetService";
	property name="sampleService" inject="sampleService";

	/************************************ IMPLICIT ACTIONS *******************************************/

	function preHandler(event,rc,prc){

	}

	function postHandler(event,rc,prc){

	}

	/************************************ END IMPLICIT ACTIONS *******************************************/

	function index (event,rc,prc) {
		//TODO: Remove for production - display list of sample for qa purpose
		rc.samples = sampleService.getAllNonRemovedSamples();

		prc.xeh.import = "importUpload.import";
    }

	function import (rc) {
        setting requestTimeout = 300;

		if (!structKeyExists(rc, 'fileUpload') || !len(trim(rc.fileUpload))) {
			session.messenger.addAlert(
				messageType="ERROR"
				, message="No import file uploaded."
				, messageDetail=""
				, field="");
			relocate(event="importUpload/index");
		}

		session.excelFileName = "";
		var fileUploadMimeType = fileGetMimeType(rc.fileUpload);

		if (!listContains(acceptedMimeTypes, fileUploadMimeType)) {
			session.messenger.addAlert(
				messageType="ERROR"
				, message="The file type #fileGetMimeType(rc.fileUpload)# is not accepted."
				, messageDetail=""
				, field="");
			relocate(event="importUpload/index");
		}

		var uploadFilePath = 'archives/#dateFormat(now(), "yyyymmdd")#';
		if (!directoryExists(expandPath(uploadFilePath))) { directoryCreate(expandPath(uploadFilePath)); }

		try {
			var uploadedFile = fileUpload(
				expandPath(uploadFilePath)
				,"fileUpload"
				,"#acceptedMimeTypes#"
				,"MakeUnique");
		} catch (any e) {
			session.messenger.addAlert(
				messageType="ERROR"
				, message="Please upload a valid import file."
				, messageDetail=""
				, field="");
			relocate(event="importUpload/index");
		}

		// remove old import and temp files after 7 days
		var queryOfFiles = directoryList(expandPath('/temp/importUpload/'), false, "query", "", "DateLastModified DESC" );
		var queryOfArchiveFiles = directoryList(expandPath('/archives/'), false, "query", "", "DateLastModified DESC" );
		var tempFilePath = expandPath('/temp/importUpload/');
		var tempArchiveFilePath = expandPath('/archives/');

		for (file in queryOfFiles) {
			var outdatedFilePath = '';

			if (dateAdd("d", 7, dateTimeFormat(file.dateLastModified)) < now()) {
				outdatedFilePath = tempFilePath & file.name;
				fileDelete(outdatedFilePath);
			}
		}
		for (file in queryOfArchiveFiles) {
			var outdatedFilePath = '';

			if ((dateAdd("d", 7, dateTimeFormat(file.dateLastModified)) < now()) && file.size > 0) {
				outdatedFilePath = tempArchiveFilePath & file.name;
				fileDelete(outdatedFilePath);
			}
		}

		// get a list of column names to be validated
		var importValidatorList = importUploadService.getImportValidatorList();

		// currently parse excel file only
		if (fileUploadMimeType == 'application/x-tika-ooxml') {
			var result = spreadSheetService.uploadImportExcelFile(rc.fileUpload, importValidatorList);
			var parsedInput = result.data;
			var hasError = result.hasError;

			if (!hasError) {
				if (arrayLen(parsedInput) == 0) {
					session.messenger.addAlert(
						messsageType="ERROR"
						, message="No import records were found."
						, messageDetail=""
						, field="");
					relocate(event="importUpload/index");
				}

				// limit the amount of file a user can import?
				if (arrayLen(parsedInput) > 3500) {
					session.messenger.addAlert(
						messsageType="ERROR"
						, message="You have reached your maximum limit of 3500 rows allowed for import file."
						, messageDetail=""
						, field="");
					relocate(event="importUpload/index");
				}

				try {
					// update all records with isRemoved=true
					if (structKeyExists(rc, "removeExistingRecordCheckbox")) {
						sampleService.updateAllParsedInputWithIsRemoved();
					}

					// create & update parsed records
					sampleService.saveParsedInput(parsedInput);

					session.messenger.addAlert(
						messageType="SUCCESS"
						, message="Successfully imported records!"
						, messageDetail=""
						, field="");
					relocate(event="importUpload/index");

				} catch (any e){
					session.messenger.addAlert(
						messageType="ERROR"
						, message="Something went wrong, please try again."
						, messageDetail=""
						, field="");
					relocate(event="importUpload/index");
				}
			} else {
				if (fileUploadMimeType == 'application/x-tika-ooxml') {
					var excelFileName = spreadSheetService.downloadImportUploadExcelFile(parsedInput);
					session.excelFileName = excelFileName;
				}
				relocate(event="importUpload/result");
			}
		} else {
			session.messenger.addAlert(
				messageType="ERROR"
				, message="Invalid file format, please upload an excel file. "
				, messageDetail=""
				, field="");
			relocate(event="importUpload/index");
		}
    }

	function result (rc) {
		rc.excelFileName = session.excelFileName;

		session.messenger.addAlert(
			messageType="ERROR"
			, message="Please upload a valid import file."
			, messageDetail=""
			, field="");
	}

}