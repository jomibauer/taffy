component name="Company" accessors="true" extends="BaseDomain" {

	property type="Numeric" name="intCompanyId" getter=true;
	property type="boolean" name="btIsActive" getter=true;
	property type="boolean" name="btIsRemoved" getter=true;
	property type="String" name="vcName" getter=true;
	property type="String" name="vcContactName" getter=true;
	property type="String" name="vcContactEmail" getter=true;
	property type="String" name="vcContactPhone" getter=true;
	property type="String" name="vcDefaultPaymentTerms" getter=true;
	property type="Numeric" name="flDefaultHourlyRate" getter=true;
	property type="Numeric" name="intCreatedById" getter=true;
	property type="date" name="dtCreatedOn" getter=true;
	property type="Numeric" name="intModifiedById" getter=true;
	property type="date" name="dtModifiedOn" getter=true;
	property type="String" name="vcCompanyUUID" getter=true;

	public any function init () {
		setIntCompanyId(0);
		setBtIsActive(true);
		setBtIsRemoved(false);
		setVcName("");
		setVcContactName("");
		setVcContactEmail("");
		setVcContactPhone("");
		setVcDefaultPaymentTerms("");
		setFlDefaultHourlyRate(0);
		setIntCreatedById(0);
		setDtCreatedOn(variables.instance.never);
		setIntModifiedById(0);
		setDtModifiedOn(variables.instance.never);
		setVcCompanyUUID("");

		return this;
	}

	public string function toJSON() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intCompanyId":' & getIntCompanyId());
		sb.append(', "btIsActive":' & (getBtIsActive() ? 'true' : 'false'));
		sb.append(', "btIsRemoved":' & (getBtIsRemoved() ? 'true' : 'false'));
		sb.append(', "vcName":' & serializeJSON(getVcName()));
		sb.append(', "vcContactName":' & serializeJSON(getVcContactName()));
		sb.append(', "vcContactEmail":' & serializeJSON(getVcContactEmail()));
		sb.append(', "vcContactPhone":' & serializeJSON(getVcContactPhone()));
		sb.append(', "vcDefaultPaymentTerms":' & serializeJSON(getVcDefaultPaymentTerms()));
		sb.append(', "flDefaultHourlyRate":' & getFlDefaultHourlyRate());
		sb.append(', "intCreatedById":' & getIntCreatedById());
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intModifiedById":' & getIntModifiedById());
		sb.append(', "dtModifiedOn":"' & formatterService.formatDateTime(getDtModifiedOn()) & '"');
		sb.append(', "vcCompanyUUID":' & serializeJSON(getVcCompanyUUID()));
		sb.append("}");
		return sb.toString();
	}

	public string function toJSONSimple() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intCompanyId":' & getIntCompanyId());
		sb.append(', "btIsActive":' & (getBtIsActive() ? 'true' : 'false'));
		sb.append(', "btIsRemoved":' & (getBtIsRemoved() ? 'true' : 'false'));
		sb.append(', "vcName":' & serializeJSON(getVcName()));
		sb.append(', "vcContactName":' & serializeJSON(getVcContactName()));
		sb.append(', "vcContactEmail":' & serializeJSON(getVcContactEmail()));
		sb.append(', "vcContactPhone":' & serializeJSON(getVcContactPhone()));
		sb.append(', "vcDefaultPaymentTerms":' & serializeJSON(getVcDefaultPaymentTerms()));
		sb.append(', "flDefaultHourlyRate":' & getFlDefaultHourlyRate());
		sb.append(', "intCreatedById":' & getIntCreatedById());
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intModifiedById":' & getIntModifiedById());
		sb.append(', "dtModifiedOn":"' & formatterService.formatDateTime(getDtModifiedOn()) & '"');
		sb.append(', "vcCompanyUUID":' & serializeJSON(getVcCompanyUUID()));
		sb.append("}");
		return sb.toString();
	}


	public boolean function btIsActive() {
		return variables.btIsActive;
	}

	public boolean function btIsRemoved() {
		return variables.btIsRemoved;
	}
}

