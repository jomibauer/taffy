component name="Sample" accessors="true" extends="BaseDomain" {

	property type="Numeric" name="intSampleId" getter=true;
	property type="boolean" name="btIsActive" getter=true;
	property type="boolean" name="btIsRemoved" getter=true;
	property type="String" name="vcSampleName" getter=true;
	property type="String" name="vcSampleEmail" getter=true;
	property type="String" name="vcSamplePhone" getter=true;
	property type="Numeric" name="intCreatedById" getter=true;
	property type="date" name="dtCreatedOn" getter=true;
	property type="Numeric" name="intModifiedById" getter=true;
	property type="date" name="dtModifiedOn" getter=true;
	property type="String" name="vcSampleUUID" getter=true;

	public any function init () {
		setIDField("intSampleId");

		setIntSampleId(0);
		setBtIsActive(true);
		setBtIsRemoved(false);
		setVcSampleName("");
		setVcSampleEmail("");
		setVcSamplePhone("");
		setIntCreatedById(0);
		setDtCreatedOn(variables.instance.never);
		setIntModifiedById(0);
		setDtModifiedOn(variables.instance.never);
		setVcSampleUUID("");

		return this;
	}

	public string function toJSON() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intSampleId":' & getIntSampleId());
		sb.append(', "btIsActive":' & (getBtIsActive() ? 'true' : 'false'));
		sb.append(', "btIsRemoved":' & (getBtIsRemoved() ? 'true' : 'false'));
		sb.append(', "vcSampleName":' & serializeJSON(getVcSampleName()));
		sb.append(', "vcSampleEmail":' & serializeJSON(getVcSampleEmail()));
		sb.append(', "vcSamplePhone":' & serializeJSON(getVcSamplePhone()));
		sb.append(', "intCreatedById":' & getIntCreatedById());
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intModifiedById":' & getIntModifiedById());
		sb.append(', "dtModifiedOn":"' & formatterService.formatDateTime(getDtModifiedOn()) & '"');
		sb.append(', "vcSampleUUID":' & serializeJSON(getVcSampleUUID()));
		sb.append("}");
		return sb.toString();
	}

	public string function toJSONSimple() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intSampleId":' & getIntSampleId());
		sb.append(', "btIsActive":' & (getBtIsActive() ? 'true' : 'false'));
		sb.append(', "btIsRemoved":' & (getBtIsRemoved() ? 'true' : 'false'));
		sb.append(', "vcSampleName":' & serializeJSON(getVcSampleName()));
		sb.append(', "vcSampleEmail":' & serializeJSON(getVcSampleEmail()));
		sb.append(', "vcSamplePhone":' & serializeJSON(getVcSamplePhone()));
		sb.append(', "intCreatedById":' & getIntCreatedById());
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intModifiedById":' & getIntModifiedById());
		sb.append(', "dtModifiedOn":"' & formatterService.formatDateTime(getDtModifiedOn()) & '"');
		sb.append(', "vcSampleUUID":' & serializeJSON(getVcSampleUUID()));
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

