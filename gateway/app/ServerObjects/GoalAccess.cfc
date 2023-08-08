<cfcomponent output="false">

	<cfset tableName  = "goals">
	<cfset dataSource = "personal_resources">

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
					,journalId
					,creationDate
					,modifiedDate
					,title
					,description
					,progress
					,maxProgress
				)
				VALUES (
					<cfqueryparam value="#entity.getID()#" 			cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getJournalId()#" 	cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getCreatedOn()#"  	cfsqltype="cf_sql_date">,
					<cfqueryparam value="#entity.getModifiedOn()#"	cfsqltype="cf_sql_datetime">,
					<cfqueryparam value="#entity.getTitle()#"	    cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getProgress()#"	cfsqltype="cf_sql_numeric">,
					<cfqueryparam value="#entity.getMaxProgress()#"	cfsqltype="cf_sql_numeric">,
				)
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message=
				'{
					"customMessage": "Error occurred in create()."
					"errorMessage": "#cfcatch.message#"
				}'>
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
					t.id           = <cfqueryparam value="#entity.getID()#"          	cfsqltype="cf_sql_varchar">
					,t.journalId   = <cfqueryparam value="#entity.getJournalId()#" 	 	cfsqltype="cf_sql_varchar">
					,t.creationDate= <cfqueryparam value="#entity.getCreatedOn()#"	 	cfsqltype="cf_sql_date">
					,t.modifiedDate= <cfqueryparam value="#entity.getModifiedOn()#"	 	cfsqltype="cf_sql_datetime">
					,t.title	   = <cfqueryparam value="#entity.getGoalTitle()#" cfsqltype="cf_sql_varchar">
					,t.description = <cfqueryparam value="#entity.getDescription()#"    cfsqltype="cf_sql_varchar">
					,t.progress	   = <cfqueryparam value="#entity.getProgress()#"       cfsqltype="cf_sql_numeric">
					,t.maxProgress = <cfqueryparam value="#entity.getMaxProgress()#"    cfsqltype="cf_sql_numeric">

				WHERE t.id         = <cfqueryparam value="#currentId#" 				 cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message=
				'{
					"customMessage": "Error occurred in updateById()."
					"errorMessage": "#cfcatch.message#"
				}'>
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
				<cfthrow type="customError" message=
				'{
					"customMessage": "Error occurred in deleteById()."
					"errorMessage": "#cfcatch.message#"
				}'>
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
					id as goal_id
					,journalId as journal_id
					,creationDate as created_on
					,modifiedDate as modified_on
					,title as goal_title
					,description as goal_description
					,progress as goal_progress
					,maxProgress as goal_maxProgress

				FROM #tableName# t

			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message=
				'{
					"customMessage": "Error occurred in list()."
					"errorMessage": "#cfcatch.message#"
				}'>
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
					id as goal_id
					,journalId as journal_id
					,creationDate as created_on
					,modifiedDate as modified_on
					,title as goal_title
					,description as goal_description
					,progress as goal_progress
					,maxProgress as goal_maxProgress

				FROM #tableName# t

				WHERE #columnName# = <cfqueryparam value="#searchValue#" cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message=
				'{
					"customMessage": "Error occurred in get()."
					"errorMessage": "#cfcatch.message#"
				}'>
				<cfreturn false>
			</cfcatch>
		</cftry>

		<cfreturn {}.append(get)>
	</cffunction>

		<cffunction name="getFromJournal" access="package" returntype="any" output="false">
		<cfargument name="journalId" type="string"  required="true">

		<cftry>
			<cfquery name="get" datasource="#dataSource#">
				SELECT
					id as goal_id
					,journalId as journal_id
					,creationDate as created_on
					,modifiedDate as modified_on
					,title as goal_title
					,description as goal_description
					,progress as goal_progress
					,maxProgress as goal_maxProgress
				FROM #tableName# t

				WHERE t.journalId = <cfqueryparam value="#journalId#" cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message=
				'{
					"customMessage": "Error occurred in getFromJournal()."
					"errorMessage": "#cfcatch.message#"
				}'>
				<cfreturn []>
			</cfcatch>
		</cftry>

		<cfreturn get>
	</cffunction>

</cfcomponent>
