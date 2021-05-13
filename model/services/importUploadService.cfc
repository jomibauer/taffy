component name="importUploadService" accessors="true" extends="baseService" singleton="true" {

	public any function getImportValidatorList () {
        /*
        format:
            "<column header>" : "<validator type>"
		available validator:
            required, length, email, phone
        */
		var importValidatorList = {
			"Contact Name": "required, length",
			"Contact Email": "required, email",
			"Contact Phone": "required, phone",
			"Company UUID": "length",
			"Default Payment Terms": "length",
			"Default Hourly Rate": "length"
		}

		return importValidatorList;
	}

    public any function getQueryHeader () {
        return "Company ID,
                Company UUID,
                Contact Email,
                Contact Name,
                Contact Phone,
                Created By Id,
                Date Created On,
                Modified By Id,
                Date Modified On,
                Is Active,
                Is Removed,
                Company Name,
                Default Payment Terms,
                Default Hourly Rate,
                System Note";
    }

    public any function getQueryHeaderType () {
        return "varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar,
                varchar";
    }

    public any function getParsedInputObject (required any parsedInputRow, required any companyId) {
        var company = getEmptyDomain();

        if (len(companyId)) {
            company.setIntCompanyId(toNumeric(parsedInputRow['Company ID']));
            company.setVcCompanyUUID(parsedInputRow['Company UUID']);
        }

        company.setVcContactEmail(parsedInputRow['Contact Email']);
        company.setVcContactName(parsedInputRow['Contact Name']);
        company.setVcContactEmail(parsedInputRow['Contact Email']);
        company.setVcContactPhone(parsedInputRow['Contact Phone']);
        company.setFlDefaultHourlyRate(parsedInputRow['Default Hourly Rate']);
        company.setVcDefaultPaymentTerms(parsedInputRow['Default Payment Terms']);
        company.setBtIsActive(parsedInputRow['Is Active']);
        company.setBtIsRemoved(parsedInputRow['Is Removed']);
        company.setVcName(parsedInputRow['Company Name']);

        return company;
    }

    public any function validateRequired (required string name, required string data) {
        return len(data) ? '' : 'Required ' & name & '; ';
    }

    public any function validateLength (required string name, required string data, required numeric length) {
        return len(data) < length ? '' : 'Invalid ' & name & '; ';
    }

    public any function validateEmail (required string name, required string data) {
        return isValid('email', data) AND !len(data) == 0 ? '' : 'Invalid ' & name & '; ';
    }

    public any function validatePhone (required string name, required string data) {
        return isValid('telephone', data) AND !len(data) == 0 ? '' : 'Invalid ' & name & '; ';
    }

    public any function getEmptyDomain () {

		return new model.domains.Company();
	}

}