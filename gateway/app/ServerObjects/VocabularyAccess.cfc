<cfcomponent output="false">

	<cfset tableName  = "vocabulary">
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
					,word
					,definition
				)
				VALUES (
					<cfqueryparam value="#entity.getID()#" 		   cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getWord()#" 	   cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getDefinition()#" cfsqltype="cf_sql_varchar">,
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
					t.id          = <cfqueryparam value="#entity.getID()#"         cfsqltype="cf_sql_varchar">
					,t.word       = <cfqueryparam value="#entity.getWord()#" 	   cfsqltype="cf_sql_varchar">
					,t.definition = <cfqueryparam value="#entity.getDefinition()#" cfsqltype="cf_sql_varchar">

				WHERE t.id         = <cfqueryparam value="#currentId#" 			   cfsqltype="cf_sql_varchar">
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
					id as vocabulary_id
					,word as vocabulary_word
					,definition as vocabulary_definition
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
					id as vocabulary_id
					,word as vocabulary_word
					,definition as vocabulary_definition
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
</cfcomponent>
