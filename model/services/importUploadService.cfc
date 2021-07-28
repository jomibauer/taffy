component name="importUploadService" accessors="true" extends="baseService" singleton="true" {
	property name="sampleService" inject="sampleService";

	public any function getImportValidatorList () {
        /*
        format:
            "<column header>" : "<validator type>"
		available validator:
            required, length, email, phone
        */
		var importValidatorList = {
			"Sample Name": "required, length",
			"Sample Email": "required, email",
			"Sample Phone": "required, phone",
			"Sample UUID": "length",
		}

		return importValidatorList;
	}

    public any function getParsedInputObject (required any sample, required any parsedInputRow, required any sampleId) {
        // update old record
        if (len(sampleId)) {
            // loads the remaining data that's not in the excel
            var qSample = sampleService.load(sampleId);

            sample.setIntSampleId(toNumeric(parsedInputRow['Sample ID']));
            sample.setVcSampleUUID(parsedInputRow['Sample UUID']);
            sample.setDtModifiedOn(now());
            sample.setIntModifiedById(session.user.getIntUserID());
            sample.setDtCreatedOn(qSample.getDtCreatedOn());
            sample.setIntCreatedById(qSample.getIntCreatedById());
        // create new record
        } else {
            sample.setVcSampleUUID(createUUID());
            sample.setBtIsActive(1);
            sample.setBtIsRemoved(0);
            sample.setDtCreatedOn(now());
            sample.setIntCreatedById(session.user.getIntUserID());
        }

        sample.setVcSampleName(parsedInputRow['Sample Name']);
        sample.setVcSampleEmail(parsedInputRow['Sample Email']);
        sample.setVcSamplePhone(parsedInputRow['Sample Phone']);

        return sample;
    }

    public any function validateRequired (required string name, required string data) {
        return len(data) ? '' : 'Required ' & name & '; ';
    }

    public any function validateLength (required string name, required string data, required numeric length) {
        return len(data) < length ? '' : 'Invalid ' & name & '; ';
    }

    public any function validateEmail (required string name, required string data) {
        return isValid('email', data) ? '' : 'Invalid ' & name & '; ';
    }

    public any function validatePhone (required string name, required string data) {
        return isValid('telephone', data) ? '' : 'Invalid ' & name & '; ';
    }

}