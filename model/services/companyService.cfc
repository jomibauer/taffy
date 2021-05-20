component name="companyService" accessors="true" extends="baseService" singleton="true" {

	property name="companyGateway" inject="companyGateway";
	property name="importUploadService" inject="importUploadService";

	private any function create (required any company) {

		var intCompanyId = companyGateway.create(company);

		return load(intCompanyId);
	}

	private any function update (required any company) {

		companyGateway.update(arguments.company);

		return load(company.getIntCompanyId());
	}

	public any function save (required any company) {

		if (company.getIntCompanyId()) {
			return update(arguments.company);
		} else {
			return create(arguments.company);
		}
	}

	public any function getEmptyDomain () {

		return new model.domains.Company();
	}

	public any function populate (required any company, required struct data ) {

		company.setIntCompanyId(data.intCompanyId);
		company.setBtIsActive(data.btIsActive);
		company.setBtIsRemoved(data.btIsRemoved);
		company.setVcName(data.vcName);
		company.setVcContactName(data.vcContactName);
		company.setVcContactEmail(data.vcContactEmail);
		company.setVcContactPhone(data.vcContactPhone);
		company.setVcDefaultPaymentTerms(data.vcDefaultPaymentTerms);
		company.setFlDefaultHourlyRate(data.flDefaultHourlyRate);
		company.setIntCreatedById(data.intCreatedById);
		company.setDtCreatedOn(data.dtCreatedOn);
		company.setIntModifiedById(data.intModifiedById);
		company.setDtModifiedOn(data.dtModifiedOn);
		company.setVcCompanyUUID(data.vcCompanyUUID);

		return company;
	}

	public any function load (required numeric intCompanyId ) {

		var company = getEmptyDomain();

		if (intCompanyId == 0) {
			return company;
		}

		var qLoad = companyGateway.load(intCompanyId);

		if (qLoad.recordCount) {
			return populate(company, queryRowData(qLoad, 1));
		}

		return local.company;
	}

	public any function loadByUUID (required string companyUUID ) {

		var company = getEmptyDomain();

		if (companyUUID == "") {
			return company;
		}

		var qLoad = companyGateway.loadByUUID(companyUUID);

		if (qLoad.recordCount) {
			return populate(company, queryRowData(qLoad, 1));
		}

		return local.company;
	}

	public array function loadAll () {

		var output = [];

		var qLoadAll = companyGateway.loadAll();

		for (var row in qLoadAll) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public array function getAllNonRemovedCompanies () {

		var output = [];

		var qLoadAll = companyGateway.loadAllNonRemovedCompanies();

		for (var row in qLoadAll) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public any function updateAllParsedInputWithIsRemoved () {

		var output = [];

		var qLoadAll = companyGateway.loadAll();
		for (var row in qLoadAll) {
			var companyId = row.intCompanyId;
			var company = companyGateway.updateAllParsedInputWithIsRemoved(companyId)
		}

		return output;
	}

	public any function saveParsedInput (required any parsedInput) {
		var output = [];
		parsedInput.map(function(parsedInputRow){
			var companyId = parsedInputRow['Company ID'];
			var company = importUploadService.getParsedInputObject(parsedInputRow, companyId);
			//NOTE : check if ID exists, if true -> udpate, if false -> create
			var company = save(company);
		});

		var qLoadAll = companyGateway.loadAll();

		for (var row in qLoadAll) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public boolean function validateCreate (required struct rc, required Messenger messenger) {
		assertExists(rc, "vcName");
		assertExists(rc, "vcContactName");
		assertExists(rc, "vcContactEmail");
		assertExists(rc, "vcContactPhone");
		assertExists(rc, "vcDefaultPaymentTerms");
		assertExists(rc, "flDefaultHourlyRate");

		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcName"
				, friendlyName="Name"
				, isRequired=true
				, maxLength=128);

		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcContactName"
				, friendlyName="Contact Name"
				, isRequired=true
				, maxLength=128);

		validateEmail(rc = rc
					, messenger = messenger
					, fieldName = "vcContactEmail"
					, friendlyName = "Contact Email"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcContactPhone"
					, friendlyName = "Contact Phone"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcDefaultPaymentTerms"
					, friendlyName = "Default Payment Terms"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		validateNumeric(rc=rc
				, messenger=messenger
				, fieldName="flDefaultHourlyRate"
				, friendlyName="Default Hourly Rate"
				, isRequired=false
				, minValue = 0
				, maxValue = 999999999
				, defaultInvalid = 0); //FLOAT

		return messenger.hasAlerts();
	}

	public boolean function validateUpdate (required struct rc, required Messenger messenger) {
		assertExists(rc, "vcName");
		assertExists(rc, "vcContactName");
		assertExists(rc, "vcContactEmail");
		assertExists(rc, "vcContactPhone");

		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcName"
				, friendlyName="Name"
				, isRequired=true
				, maxLength=128);

		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcContactName"
				, friendlyName="Contact Name"
				, isRequired=true
				, maxLength=128);

		validateEmail(rc = rc
					, messenger = messenger
					, fieldName = "vcContactEmail"
					, friendlyName = "Contact Email"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcContactPhone"
					, friendlyName = "Contact Phone"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcDefaultPaymentTerms"
					, friendlyName = "Default Payment Terms"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		validateNumeric(rc=rc
				, messenger=messenger
				, fieldName="flDefaultHourlyRate"
				, friendlyName="Default Hourly Rate"
				, isRequired=false
				, minValue = 0
				, maxValue = 999999999
				, defaultInvalid = 0); //FLOAT

		return messenger.hasAlerts();
	}
}