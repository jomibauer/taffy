<cfcomponent name="sampleGateway" extends="baseGateway" singleton="true">

	<cffunction name="create" access="public" returntype="numeric" output="false">
		<cfargument name="sample" type="any" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblSample
			(
				  btIsActive
				, btIsRemoved		/*  - bit*/
				, vcSampleName		/*  - varchar(128)*/
				, vcSampleEmail	/*  - varchar(128)*/
				, vcSamplePhone	/*  - varchar(128)*/
				, intCreatedBy	/*  - int*/
				, dtCreatedOn		/*  - datetime*/
				, intLastModifiedBy	/*  - int*/
				, dtLastModifiedOn		/*  - datetime*/
				, vcSampleUUID
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.sample.getBtIsActive()#"/>	/* btIsActive - bit */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.sample.getBtIsRemoved()#"/>	/* btIsRemoved - bit */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSampleName()#"/>	/* vcSampleName - varchar (128) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSampleEmail()#"/>	/* vcSampleEmail - varchar (128) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSamplePhone()#"/>	/* vcSamplePhone - varchar (128) */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sample.getIntCreatedBy()#"/>	/* intCreatedBy - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.sample.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sample.getIntLastModifiedBy()#"/>	/* intLastModifiedBy - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.sample.getDtLastModifiedOn()#"/>	/* dtLastModifiedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#createUUID()#"/>
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="sample" type="any" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblSample
			SET
				  btIsActive = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.sample.getBtIsActive()#"/>	/* btIsActive - bit */
				, btIsRemoved = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.sample.getBtIsRemoved()#"/>	/* btIsRemoved - bit */
				, vcSampleName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSampleName()#"/>	/* vcSampleName - varchar (128) */
				, vcSampleEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSampleEmail()#"/>	/* vcSampleEmail - varchar (128) */
				, vcSamplePhone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSamplePhone()#"/>	/* vcSamplePhone - varchar (128) */
				, intCreatedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sample.getIntCreatedBy()#"/>	/* intCreatedBy - int */
				, dtCreatedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.sample.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, intLastModifiedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sample.getIntLastModifiedBy()#"/>	/* intLastModifiedBy - int */
				, dtLastModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.sample.getDtLastModifiedOn()#"/>	/* dtLastModifiedOn - datetime */
			WHERE
				intSampleId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.sample.getIntSampleId()#"/>
		</cfquery>

	</cffunction>

	<cffunction name="load" access="public" returntype="query" output="false">
		<cfargument name="intSampleId" type="numeric" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblSample.intSampleId		/*  - bigint*/
				, tblSample.btIsActive		/*  - bit*/
				, tblSample.btIsRemoved		/*  - bit*/
				, tblSample.vcSampleName		/*  - varchar(128)*/
				, tblSample.vcSampleEmail	/*  - varchar(128)*/
				, tblSample.vcSamplePhone	/*  - varchar(128)*/
				, tblSample.intCreatedBy	/*  - int*/
				, tblSample.dtCreatedOn		/*  - datetime*/
				, tblSample.intLastModifiedBy	/*  - int*/
				, tblSample.dtLastModifiedOn		/*  - datetime*/
				, tblSample.vcSampleUUID
			FROM dbo.tblSample
			WHERE
				tblSample.intSampleId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.intSampleId#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="loadByUUID" access="public" returntype="query" output="false">
		<cfargument name="sampleUUID" type="string" required="true">

		<cfquery name="local.qLoad">
			SELECT
				  tbSample.inSampleId
				, tbSample.btIsActive
				, tbSample.btIsRemoved
				, tbSample.vcSampleName
				, tbSample.vcSampleEmail
				, tbSample.vcSamplePhone
				, tbSample.intCreatedBy
				, tbSample.dtCreatedOn
				, tbSample.intLastModifiedBy
				, tbSample.dtLastModifiedOn
				, tbSample.vSampleUUID
			FROM dbo.tblSample
			WHERE
				tblSample.vcSampleUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sampleUUID#">
		</cfquery>

		<cfreturn local.qLoad>
	</cffunction>

	<cffunction name="loadAll" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblSample.intSampleId		/*  - bigint*/
				, tblSample.btIsActive		/*  - bit*/
				, tblSample.btIsRemoved		/*  - bit*/
				, tblSample.vcSampleName		/*  - varchar(128)*/
				, tblSample.vcSampleEmail	/*  - varchar(128)*/
				, tblSample.vcSamplePhone	/*  - varchar(128)*/
				, tblSample.intCreatedBy	/*  - int*/
				, tblSample.dtCreatedOn		/*  - datetime*/
				, tblSample.intLastModifiedBy	/*  - int*/
				, tblSample.dtLastModifiedOn		/*  - datetime*/
				, tblSample.vcSampleUUID
			FROM dbo.tblSample
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="loadAllNonRemovedSamples" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblSample.intSampleId
				, tblSample.btIsActive
				, tblSample.btIsRemoved
				, tblSample.vcSampleName
				, tblSample.vcSampleEmail
				, tblSample.vcSamplePhone
				, tblSample.intCreatedBy
				, tblSample.dtCreatedOn
				, tblSample.intLastModifiedBy
				, tblSample.dtLastModifiedOn
				, tblSample.vcSampleUUID
			FROM dbo.tblSample
			WHERE tblSample.btIsRemoved = 0
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="updateAllParsedInputWithIsRemoved" access="public" returntype="void" output="false">
		<cfargument name="sampleId" type="numeric" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblSample
			SET
				btIsRemoved = <cfqueryparam cfsqltype="cf_sql_bit" value="1"/>
				, intLastModifiedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.getIntUserID()#"/>
				, dtLastModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>
			WHERE
				intSampleId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.sampleId#"/>
		</cfquery>

	</cffunction>

</cfcomponent>