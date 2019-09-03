component name="Group" accessors=true extends="BaseDomain" {

	property Numeric intGroupID;
	property String vcGroupName;
	property String vcGroupAbbr;
	property String vcGroupEmail;
	property String vcGroupDesc;
	property boolean btIsProtected;
	property boolean btIsRemoved;
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
		setBtIsProtected(false);
		setBtIsRemoved(false);
		//setDtCreatedOn(variables.instance.never);
		setIntCreatedBy(0);
		//setDtLastModifiedOn(variables.instance.never);
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
		sb.append(', "btIsProtected":' & serializeJSON(getBtIsProtected()));
		sb.append(', "btIsRemoved":' & serializeJSON(getBtIsRemoved()));
		sb.append(', "dtCreatedOn":' & serializeJSON(getDtCreatedOn()));
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
		sb.append(', "btIsProtected":' & serializeJSON(getBtIsProtected()));
		sb.append(', "btIsRemoved":' & serializeJSON(getBtIsRemoved()));
		sb.append(', "dtCreatedOn":' & serializeJSON(getDtCreatedOn()));
		sb.append(', "dtCreatedOn":' & serializeJSON(getDtCreatedOn()));
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append(', "dtLastModifiedOn":' & serializeJSON(getDtLastModifiedOn()));
		sb.append(', "intLastModifiedBy":' & getIntLastModifiedBy());
		sb.append("}");
		return sb.toString();
	}

}

