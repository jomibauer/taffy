component name="sampleService" accessors="true" extends="baseService" singleton="true" {

	property name="sampleGateway" inject="sampleGateway";
	property name="importUploadService" inject="importUploadService";

	private any function create (required any sample) {

		var intSampleId = sampleGateway.create(sample);

		return load(intSampleId);
	}

	private any function update (required any sample) {

		sampleGateway.update(arguments.sample);

		return load(sample.getIntSampleId());
	}

	public any function save (required any sample) {

		if (sample.getIntSampleId()) {
			return update(arguments.sample);
		} else {
			return create(arguments.sample);
		}
	}

	public any function getEmptyDomain () {
		return new model.domains.Sample();
	}

	public any function populate (required any sample, required struct data ) {

		sample.setIntSampleId(data.intSampleId);
		sample.setBtIsActive(data.btIsActive);
		sample.setBtIsRemoved(data.btIsRemoved);
		sample.setVcSampleName(data.vcSampleName);
		sample.setVcSampleEmail(data.vcSampleEmail);
		sample.setVcSamplePhone(data.vcSamplePhone);
		sample.setIntCreatedById(data.intCreatedById);
		sample.setDtCreatedOn(data.dtCreatedOn);
		sample.setIntModifiedById(data.intModifiedById);
		sample.setDtModifiedOn(data.dtModifiedOn);
		sample.setVcSampleUUID(data.vcSampleUUID);

		return sample;
	}

	public any function load (required numeric intSampleId ) {

		var sample = getEmptyDomain();

		if (intSampleId == 0) {
			return sample;
		}

		var qLoad = sampleGateway.load(intSampleId);

		if (qLoad.recordCount) {
			return populate(sample, queryRowData(qLoad, 1));
		}

		return local.sample;
	}

	public any function loadByUUID (required string sampleUUID ) {

		var sample = getEmptyDomain();

		if (sampleUUID == "") {
			return sample;
		}

		var qLoad = sampleGateway.loadByUUID(sampleUUID);

		if (qLoad.recordCount) {
			return populate(sample, queryRowData(qLoad, 1));
		}

		return local.sample;
	}

	public array function loadAll () {

		var output = [];

		var qLoadAll = sampleGateway.loadAll();

		for (var row in qLoadAll) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public array function getAllNonRemovedSamples () {

		var output = [];

		var qLoadAll = sampleGateway.loadAllNonRemovedSamples();

		for (var row in qLoadAll) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public any function updateAllParsedInputWithIsRemoved () {

		var output = [];

		var qLoadAll = sampleGateway.loadAll();
		for (var row in qLoadAll) {
			var sampleId = row.intSampleId;
			sampleGateway.updateAllParsedInputWithIsRemoved(sampleId)
		}

		return output;
	}

	public any function saveParsedInput (required any parsedInput) {
		parsedInput.map(function(parsedInputRow){
			var sample = getEmptyDomain();
			var sampleId = parsedInputRow['Sample ID'];
			var parsedSample = importUploadService.getParsedInputObject(sample, parsedInputRow, sampleId);
			//NOTE : check if ID exists, if true -> udpate, if false -> create
			parsedSample = save(parsedSample);
		});
	}

	public boolean function validateCreate (required struct rc, required Messenger messenger) {
		assertExists(rc, "vcSampleName");
		assertExists(rc, "vcSampleEmail");
		assertExists(rc, "vcSamplePhone");

		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcSampleName"
				, friendlyName="Sample Name"
				, isRequired=true
				, maxLength=128);

		validateEmail(rc = rc
					, messenger = messenger
					, fieldName = "vcSampleEmail"
					, friendlyName = "Sample Email"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcSamplePhone"
					, friendlyName = "Sample Phone"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		return messenger.hasAlerts();
	}

	public boolean function validateUpdate (required struct rc, required Messenger messenger) {
		assertExists(rc, "vcSampleName");
		assertExists(rc, "vcSampleEmail");
		assertExists(rc, "vcSamplePhone");

		validateLength(rc=rc
				, messenger=messenger
				, fieldName="vcSampleName"
				, friendlyName="Sample Name"
				, isRequired=true
				, maxLength=128);

		validateEmail(rc = rc
					, messenger = messenger
					, fieldName = "vcSampleEmail"
					, friendlyName = "Sample Email"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		validateLength(rc = rc
					, messenger = messenger
					, fieldName = "vcSamplePhone"
					, friendlyName = "Sample Phone"
					, isRequired = true
					, minLength = 1
					, maxLength = 128);

		return messenger.hasAlerts();
	}
}