component extends="coldbox.system.EventHandler" {

	property name="acceptedMimeTypes" inject="coldbox:setting:acceptedMimeTypes";
	property name="importUploadService" inject="importUploadService";
	property name="spreadSheetService" inject="spreadSheetService";

/************************************ APPLICATION-WIDE IMPLICIT ACTIONS *******************************************/

	function onAppStart(event,rc,prc){

	}

	function onAppEnd(event,rc,prc){

	}

	function onRequestStart(event,rc,prc){
		// exit handlers used in navbar
	}

	function onRequestEnd(event,rc,prc){

	}

	function onSessionStart(event,rc,prc){

	}

	function onSessionEnd(event,rc,prc){
		var sessionScope = event.getValue("sessionReference");
		var applicationScope = event.getValue("applicationReference");
	}

	function onException(event,rc,prc){
		event.setHTTPHeader( statusCode = 500 );
		request.layout = false;

		//Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		var environment = getSetting('environment');

		if (environment == "PRODUCTION") {
			var eventName = structKeyExists(event.getContext(), "event") ? event.getContext().event : "unknown";
			mailService.sendError(eventName, exception, environment);
		} else {
			//Place exception handler below:
			writeDump(exception.getExceptionStruct());
			abort;
		}

		event.setView("main/error");
	}

	/************************************ END APPLICATION-WIDE IMPLICIT ACTIONS *******************************************/

	/************************************ IMPLICIT ACTIONS *******************************************/

	function preHandler(event,rc,prc){

	}

	function postHandler(event,rc,prc){

	}

	/************************************ END IMPLICIT ACTIONS *******************************************/

	function index (event,rc,prc) {
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

		var uploadFilePath = 'attachments/#dateFormat(now(), "yyyymmdd")#';
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
		var queryOfAttachmentFiles = directoryList(expandPath('/attachment/'), false, "query", "", "DateLastModified DESC" );
		var tempFilePath = expandPath('/temp/importUpload/');
		var tempAttachmentFilePath = expandPath('/attachment/');

		for (file in queryOfFiles) {
			var outdatedFilePath = '';

			if (dateAdd("d", 7, dateTimeFormat(file.dateLastModified)) < now()) {
				outdatedFilePath = tempFilePath & file.name;
				fileDelete(outdatedFilePath);
			}
		}
		for (file in queryOfAttachmentFiles) {
			var outdatedFilePath = '';

			if (dateAdd("d", 7, dateTimeFormat(file.dateLastModified)) < now()) {
				outdatedFilePath = tempAttachmentFilePath & file.name;
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
					var isRemoved = structKeyExists(rc, "removeExistingRecordCheckbox") ? true : false;
					if (isRemoved) { companyService.updateAllParsedInputWithIsRemoved(); }

					// create & update records
					companyService.saveParsedInput(parsedInput);

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