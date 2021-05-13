component singleton=true {

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

    public any function updateFriendlyToFieldName (required any parsedInputRow) {
        var fieldNameStruct = {
            'companyId' : parsedInputRow['Company ID'],
            'companyUUID' : parsedInputRow['Company UUID'],
            'contactName' : parsedInputRow['Contact Name'],
            'contactEmail' : parsedInputRow['Contact Email'],
            'contactPhone' : parsedInputRow['Contact Phone'],
            'createdById' : parsedInputRow['Created By Id'],
            'createdOn' : parsedInputRow['Date Created On'],
            'modifiedOn' : parsedInputRow['Date Modified On'],
            'defaultHourlyRate' : parsedInputRow['Default Hourly Rate'],
            'defaultPaymentTerms' : parsedInputRow['Default Payment Terms'],
            'isActive' : parsedInputRow['Is Active'],
            'isRemoved' : parsedInputRow['Is Removed'],
            'modifiedById' : parsedInputRow['Modified By Id'],
            'companyName' : parsedInputRow['Company Name']
        }
        return fieldNameStruct;
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
}