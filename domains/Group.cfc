component name="Group" accessors=true extends="BaseDomain" {

	property name="formatterService" inject="formatterService";

	property Numeric intGroupID;
	property String vcGroupName;
	property String vcGroupAbbr;
	property String vcGroupEmail;
	property String vcGroupDesc;
	property date dtCreatedOn;
	property Numeric intCreatedBy;
	property date dtLastModifiedOn;
	property Numeric intLastModifiedBy;

	public any function init () {

		setIDField("intGroupID");

		setIntGroupID(0);
		setVcGroupName("");
		setVcGroupAbbr("");
		setVcGroupEmail("");
		setVcGroupDesc("");
		setDtCreatedOn(variables.instance.never);
		setIntCreatedBy(0);
		setDtLastModifiedOn(variables.instance.never);
		setIntLastModifiedBy(0);

		return this;
	}

	public string function toJSON() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intGroupID":' & getIntGroupID());
		sb.append(', "vcGroupName":' & serializeJSON(getVcGroupName()));
		sb.append(', "vcGroupAbbr":' & serializeJSON(getVcGroupAbbr()));
		sb.append(', "vcGroupEmail":' & serializeJSON(getVcGroupEmail()));
		sb.append(', "vcGroupDesc":' & serializeJSON(getVcGroupDesc()));
		sb.append(', "dtCreatedOn":"' & serializeJSON(getDtCreatedOn()));
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append(', "dtLastModifiedOn":"' & serializeJSON(getDtLastModifiedOn()));
		sb.append(', "intLastModifiedBy":' & getIntLastModifiedBy());
		sb.append("}");
		return sb.toString();
	}

	public string function toJSONSimple() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intGroupID":' & getIntGroupID());
		sb.append(', "vcGroupName":' & serializeJSON(getVcGroupName()));
		sb.append(', "vcGroupAbbr":' & serializeJSON(getVcGroupAbbr()));
		sb.append(', "vcGroupEmail":' & serializeJSON(getVcGroupEmail()));
		sb.append(', "vcGroupDesc":' & serializeJSON(getVcGroupDesc()));
		sb.append(', "dtCreatedOn":"' & serializeJSON(getDtCreatedOn()));
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append(', "dtLastModifiedOn":"' & serializeJSON(getDtLastModifiedOn()));
		sb.append(', "intLastModifiedBy":' & getIntLastModifiedBy());
		sb.append("}");
		return sb.toString();
	}

}

