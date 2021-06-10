<cfcomponent name="sampleGateway" extends="baseGateway" singleton="true">

	<cffunction name="create" access="public" returntype="numeric" output="false">
		<cfargument name="sample" type="any" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblSample
			(
				  btIsActive
				, btIsRemoved		/*  - bit*/
				, vcSampleName		/*  - varchar(128)*/
				, vcSampleEmail		/*  - varchar(128)*/
				, vcSamplePhone		/*  - varchar(25*/
				, intCreatedById	/*  - int*/
				, dtCreatedOn		/*  - datetime*/
				, intModifiedById	/*  - int*/
				, dtModifiedOn		/*  - datetime*/
				, vcSampleUUID		/*  - varchar(35*/
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.sample.getBtIsActive()#"/>			/* btIsActive - bit */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.sample.getBtIsRemoved()#"/>		/* btIsRemoved - bit */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSampleName()#"/>	/* vcSampleName - varchar(128) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSampleEmail()#"/>	/* vcSampleEmail - varchar(128) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSamplePhone()#"/>	/* vcSamplePhone - varchar(25) */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sample.getIntCreatedById()#"/>	/* intCreatedById - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.sample.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sample.getIntModifiedById()#"/>/* intModifiedById - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.sample.getDtModifiedOn()#"/>	/* dtModifiedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#createUUID()#"/>							/* vcSampleUUID - varchar(35) */
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="sample" type="any" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblSample
			SET
				  btIsActive = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.sample.getBtIsActive()#"/>				/* btIsActive - bit */
				, btIsRemoved = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.sample.getBtIsRemoved()#"/>				/* btIsRemoved - bit */
				, vcSampleName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSampleName()#"/>		/* vcSampleName - varchar (128) */
				, vcSampleEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSampleEmail()#"/>		/* vcSampleEmail - varchar (128) */
				, vcSamplePhone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sample.getVcSamplePhone()#"/>		/* vcSamplePhone - varchar (25) */
				, intCreatedById = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sample.getIntCreatedById()#"/>	/* intCreatedById - int */
				, dtCreatedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.sample.getDtCreatedOn()#"/>		/* dtCreatedOn - datetime */
				, intModifiedById = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sample.getIntModifiedById()#"/>	/* intModifiedById - int */
				, dtModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.sample.getDtModifiedOn()#"/>		/* dtModifiedOn - datetime */
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
				, tblSample.vcSampleName	/*  - varchar(128)*/
				, tblSample.vcSampleEmail	/*  - varchar(128)*/
				, tblSample.vcSamplePhone	/*  - varchar(25)*/
				, tblSample.intCreatedById	/*  - int*/
				, tblSample.dtCreatedOn		/*  - datetime*/
				, tblSample.intModifiedById	/*  - int*/
				, tblSample.dtModifiedOn	/*  - datetime*/
				, tblSample.vcSampleUUID	/*  - varchar(35)*/
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
				, tbSample.intCreatedById
				, tbSample.dtCreatedOn
				, tbSample.intModifiedById
				, tbSample.dtModifiedOn
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
				  tblSample.intSampleId			/*  - bigint*/
				, tblSample.btIsActive			/*  - bit*/
				, tblSample.btIsRemoved			/*  - bit*/
				, tblSample.vcSampleName		/*  - varchar(128)*/
				, tblSample.vcSampleEmail		/*  - varchar(128)*/
				, tblSample.vcSamplePhone		/*  - varchar(25)*/
				, tblSample.intCreatedById		/*  - int*/
				, tblSample.dtCreatedOn			/*  - datetime*/
				, tblSample.intModifiedById		/*  - int*/
				, tblSample.dtModifiedOn		/*  - datetime*/
				, tblSample.vcSampleUUID		/*  - varchar(35)*/
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
				, tblSample.intCreatedById
				, tblSample.dtCreatedOn
				, tblSample.intModifiedById
				, tblSample.dtModifiedOn
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
				, intModifiedById = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.getIntUserID()#"/>
				, dtModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>
			WHERE
				intSampleId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.sampleId#"/>
		</cfquery>

	</cffunction>

</cfcomponent>