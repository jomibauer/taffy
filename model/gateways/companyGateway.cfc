<cfcomponent name="companyGateway" extends="baseGateway" singleton="true">

	<cffunction name="create" access="public" returntype="numeric" output="false">
		<cfargument name="company" type="any" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblCompany
			(
				  btIsActive
				, btIsRemoved		/*  - bit*/
				, vcName		/*  - varchar(128)*/
				, vcContactName		/*  - varchar(128)*/
				, vcContactEmail	/*  - varchar(128)*/
				, vcContactPhone	/*  - varchar(128)*/
				, vcDefaultPaymentTerms	/*  - varchar(128)*/
				, flDefaultHourlyRate	/*  - fl(53)*/
				, intCreatedById	/*  - int*/
				, dtCreatedOn		/*  - datetime*/
				, intModifiedById	/*  - int*/
				, dtModifiedOn		/*  - datetime*/
				, vcCompanyUUID
			)
			VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.company.getBtIsActive()#"/>	/* btIsActive - bit */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.company.getBtIsRemoved()#"/>	/* btIsRemoved - bit */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcName()#"/>	/* vcName - varchar (128) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcContactName()#"/>	/* vcContactName - varchar (128) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcContactEmail()#"/>	/* vcContactEmail - varchar (128) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcContactPhone()#"/>	/* vcContactPhone - varchar (128) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcDefaultPaymentTerms()#"/>	/* vcContactPhone - varchar (128) */
				, <cfqueryparam cfsqltype="float" value="#arguments.company.getFlDefaultHourlyRate()#"/>	/* intCreatedById - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company.getIntCreatedById()#"/>	/* intCreatedById - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.company.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company.getIntModifiedById()#"/>	/* intModifiedById - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.company.getDtModifiedOn()#"/>	/* dtModifiedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#createUUID()#"/>
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="company" type="any" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblCompany
			SET
				  btIsActive = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.company.getBtIsActive()#"/>	/* btIsActive - bit */
				, btIsRemoved = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.company.getBtIsRemoved()#"/>	/* btIsRemoved - bit */
				, vcName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcName()#"/>	/* vcName - varchar (128) */
				, vcContactName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcContactName()#"/>	/* vcContactName - varchar (128) */
				, vcContactEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcContactEmail()#"/>	/* vcContactEmail - varchar (128) */
				, vcContactPhone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcContactPhone()#"/>	/* vcContactPhone - varchar (128) */
				, vcDefaultPaymentTerms = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company.getVcDefaultPaymentTerms()#"/>	/* vcDefaultPaymentTerms - varchar (128) */
				, flDefaultHourlyRate = <cfqueryparam cfsqltype="cf_sql_float" value="#arguments.company.getFlDefaultHourlyRate()#"/>	/* flDefaultHourlyRate - float (53) */
				, intCreatedById = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company.getIntCreatedById()#"/>	/* intCreatedById - int */
				, dtCreatedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.company.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, intModifiedById = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company.getIntModifiedById()#"/>	/* intModifiedById - int */
				, dtModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.company.getDtModifiedOn()#"/>	/* dtModifiedOn - datetime */
			WHERE
				intCompanyId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.company.getIntCompanyId()#"/>
		</cfquery>

	</cffunction>

	<cffunction name="load" access="public" returntype="query" output="false">
		<cfargument name="intCompanyId" type="numeric" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblCompany.intCompanyId		/*  - bigint*/
				, tblCompany.btIsActive		/*  - bit*/
				, tblCompany.btIsRemoved		/*  - bit*/
				, tblCompany.vcName		/*  - varchar(128)*/
				, tblCompany.vcContactName		/*  - varchar(128)*/
				, tblCompany.vcContactEmail	/*  - varchar(128)*/
				, tblCompany.vcContactPhone	/*  - varchar(128)*/
				, tblCompany.vcDefaultPaymentTerms	/*  - varchar(128)*/
				, tblCompany.flDefaultHourlyRate	/*  - fl(53)*/
				, tblCompany.intCreatedById	/*  - int*/
				, tblCompany.dtCreatedOn		/*  - datetime*/
				, tblCompany.intModifiedById	/*  - int*/
				, tblCompany.dtModifiedOn		/*  - datetime*/
				, tblCompany.vcCompanyUUID
			FROM dbo.tblCompany
			WHERE
				tblCompany.intCompanyId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.intCompanyId#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="loadByUUID" access="public" returntype="query" output="false">
		<cfargument name="companyUUID" type="string" required="true">

		<cfquery name="local.qLoad">
			SELECT
				  tblCompany.intCompanyId
				, tblCompany.btIsActive
				, tblCompany.btIsRemoved
				, tblCompany.vcName
				, tblCompany.vcContactName
				, tblCompany.vcContactEmail
				, tblCompany.vcContactPhone
				, tblCompany.vcDefaultPaymentTerms
				, tblCompany.flDefaultHourlyRate
				, tblCompany.intCreatedById
				, tblCompany.dtCreatedOn
				, tblCompany.intModifiedById
				, tblCompany.dtModifiedOn
				, tblCompany.vcCompanyUUID
			FROM dbo.tblCompany
			WHERE
				tblCompany.vcCompanyUUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.companyUUID#">
		</cfquery>

		<cfreturn local.qLoad>
	</cffunction>

	<cffunction name="loadAll" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblCompany.intCompanyId		/*  - bigint*/
				, tblCompany.btIsActive		/*  - bit*/
				, tblCompany.btIsRemoved		/*  - bit*/
				, tblCompany.vcName		/*  - varchar(128)*/
				, tblCompany.vcContactName		/*  - varchar(128)*/
				, tblCompany.vcContactEmail	/*  - varchar(128)*/
				, tblCompany.vcContactPhone	/*  - varchar(128)*/
				, tblCompany.vcDefaultPaymentTerms	/*  - varchar(128)*/
				, tblCompany.flDefaultHourlyRate	/*  - fl(53)*/
				, tblCompany.intCreatedById	/*  - int*/
				, tblCompany.dtCreatedOn		/*  - datetime*/
				, tblCompany.intModifiedById	/*  - int*/
				, tblCompany.dtModifiedOn		/*  - datetime*/
				, tblCompany.vcCompanyUUID
			FROM dbo.tblCompany
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="loadAllNonRemovedCompanies" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblCompany.intCompanyId		/*  - bigint*/
				, tblCompany.btIsActive		/*  - bit*/
				, tblCompany.btIsRemoved		/*  - bit*/
				, tblCompany.vcName		/*  - varchar(128)*/
				, tblCompany.vcContactName		/*  - varchar(128)*/
				, tblCompany.vcContactEmail	/*  - varchar(128)*/
				, tblCompany.vcContactPhone	/*  - varchar(128)*/
				, tblCompany.vcDefaultPaymentTerms	/*  - varchar(128)*/
				, tblCompany.flDefaultHourlyRate	/*  - fl(53)*/
				, tblCompany.intModifiedById	/*  - int*/
				, tblCompany.dtModifiedOn		/*  - datetime*/
				, tblCompany.vcCompanyUUID
			FROM dbo.tblCompany
			WHERE tblCompany.btIsRemoved = 0
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="updateAllParsedInputWithIsRemoved" access="public" returntype="void" output="false">
		<cfargument name="companyId" type="numeric" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblCompany
			SET
				btIsRemoved = <cfqueryparam cfsqltype="cf_sql_bit" value="true"/>
				, intModifiedById = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.user.getIntUserID()#"/>
				, dtModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>
			WHERE
				intCompanyId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.companyId#"/>
		</cfquery>

	</cffunction>

</cfcomponent>