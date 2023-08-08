<cfcomponent output="false">

	<cfset tableName  = ""> <!--- SET THIS --->
	<cfset dataSource = ""> <!--- SET THIS --->

	<!---
	 * -------------------------------------------------------------
	 * 	CRUD FUNCTIONS
	 * -------------------------------------------------------------
	 --->

	<cffunction name="create" access="package" returntype="boolean" output="false" hint="Adds a new entry into the database.">
		<cfargument name="entity" type="struct" required="true">

		<cftry>
			<cfquery datasource=#dataSource#>
				INSERT INTO #tableName# (
					id
					,name
					,typeID
					,modifierAtk
					,modifierHealth
					,modifierDef
					,t.experienceGain as experience_gain
					,t.goldGain as gold_gain
					,t.imageLocation as image_location
				)
				VALUES (
					NEWID(),
					<cfqueryparam value="#entity.getName()#" 			cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getTypeId()#"   		cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getModifierAtk()#"     cfsqltype="cf_sql_numeric">,
					<cfqueryparam value="#entity.getModifierHealth()#"	cfsqltype="cf_sql_numeric">,
					<cfqueryparam value="#entity.getModifierDef()#"		cfsqltype="cf_sql_numeric">,
					<cfqueryparam value="#entity.getExperienceGain()#"	cfsqltype="cf_sql_numeric">,
					<cfqueryparam value="#entity.getGoldGain()#"		cfsqltype="cf_sql_numeric">,
					<cfqueryparam value="#entity.getImageLocation()#"	cfsqltype="cf_sql_varchar">
				)
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message="Error occurred in create().">
				<cfreturn false>
			</cfcatch>
		</cftry>

		<cfreturn true>
	</cffunction>

	<cffunction name="updateById" access="package" returntype="boolean" output="false">
		<cfargument name="currentId"     type="string" required="true">
		<cfargument name="entity" type="struct" required="true">

		<cftry>
			<cfquery datasource=#dataSource#>
				UPDATE #tableName# t
				SET
					t.id            	 = <cfqueryparam value="#entity.getId()#"          	 cfsqltype="cf_sql_varchar">
					,t.name    	 		 = <cfqueryparam value="#entity.getName()#" 	 	 cfsqltype="cf_sql_varchar">
					,t.typeID	 	 	 = <cfqueryparam value="#entity.getTypeId()#"	 	 cfsqltype="cf_sql_varchar">
					,t.modifierAtk		 = <cfqueryparam value="#entity.getModifierAtk()#"	 cfsqltype="cf_sql_numeric">
					,t.modifierHealth	 = <cfqueryparam value="#entity.getModifierHealth()#"cfsqltype="cf_sql_numeric">
					,t.modifierDef  	 = <cfqueryparam value="#entity.getModifierDef()#" 	 cfsqltype="cf_sql_numeric">
					,t.experienceGain	 = <cfqueryparam value="#entity.getExperienceGain()#"cfsqltype="cf_sql_numeric">
					,t.goldGain			 = <cfqueryparam value="#entity.getGoldGain()#"		 cfsqltype="cf_sql_numeric">
					,t.imageLocation	 = <cfqueryparam value="#entity.getImageLocation()#" cfsqltype="cf_sql_varchar">
				WHERE t.id          	 = <cfqueryparam value="#currentId#" 				 cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message="Error occurred in updateAccessObjectByID().">
				<cfreturn false>
			</cfcatch>
		</cftry>

		<cfreturn true>
	</cffunction>

	<cffunction name="deleteById" access="package" output="false">
		<cfargument name="entityId" type="string" required="true">

        <cftry>
			<cfquery datasource=#dataSource#>
				DELETE FROM #tableName# t
				WHERE t.id = <cfqueryparam value="#entityId#" cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="customError" message="Error occurred in deleteAccessObjectByID().">
			</cfcatch>
		</cftry>
	</cffunction>


	<!---
	 * -------------------------------------------------------------
	 * 	GETTERS
	 * -------------------------------------------------------------
	 --->

	<cffunction name="list" access="package" returntype="query" output="false">
	    <cftry>
			<cfquery name="list" datasource=#dataSource#>
				SELECT
					t.id as enemy_id
					,t.name as enemy_name
					,et.name as enemy_type
					,t.modifierAtk as atk_modifier
					,t.modifierHealth as health_modifier
					,t.modifierDef as def_modifier
					,t.experienceGain as experience_gain
					,t.goldGain as gold_gain
					,t.imageLocation as image_location
				FROM #tableName# t
				LEFT JOIN enemyType et ON et.id = t.typeId
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message="Error occurred in list().">
				<cfreturn false>
			</cfcatch>
		</cftry>

		<cfreturn list>
	</cffunction>

	<cffunction name="get" access="package" returntype="any" output="false">
		<cfargument name="searchValue" type="string"  required="true">
		<cfargument name="useName"     type="boolean" default="false">

		<cfset var columnName = "">

		<cfif useName>
			<cfset columnName = "t.name">
		<cfelse>
			<cfset columnName = "t.id">
		</cfif>

		<cftry>
			<cfquery name="get" datasource="#dataSource#">
				SELECT
					t.id as enemy_id
					,t.name as enemy_name
					,et.name as enemy_type
					,t.modifierAtk as atk_modifier
					,t.modifierHealth as health_modifier
					,t.modifierDef as def_modifier
					,t.experienceGain as experience_gain
					,t.goldGain as gold_gain
					,t.imageLocation as image_location
				FROM #tableName# t
				LEFT JOIN enemyType et ON et.id = t.typeId

				WHERE #columnName# = <cfqueryparam value="#searchValue#" cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message="Error occurred in get().">
				<cfreturn false>
			</cfcatch>
		</cftry>

		<cfreturn {}.append(get)>
	</cffunction>

</cfcomponent>
