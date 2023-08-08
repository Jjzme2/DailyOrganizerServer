<cfcomponent output="false">

	<cfset tableName  = "journals"> <!--- SET THIS --->
	<cfset dataSource = "personal_resources"> <!--- SET THIS --->

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
					t.id
					,t.UserId
					,t.journalName as journal_name
					,t.description as short_description
					,t.creationDate as created_on
					,t.modifiedDate as modified_on
				)
				VALUES (
					<cfqueryparam value="#entity.getId()#" 				cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getUserId()#" 			cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getjournalName()#" 		cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getShortDescripton()#" 		cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#entity.getCreatedOn()#"   		cfsqltype="cf_sql_datetime">,
					<cfqueryparam value="#entity.getModifiedOn()#"     cfsqltype="cf_sql_datetime">,
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

	<cffunction name="updateById" access="package" returntype="boolean" output="false" hint="Update an existing entry into the database.">
		<cfargument name="currentId"     type="string" required="true">
		<cfargument name="entity" type="struct" required="true">

		<cftry>
			<cfquery datasource=#dataSource#>
				UPDATE #tableName# t
				SET
					t.id 	  		= <cfqueryparam value="#entity.getId()#"   		  cfsqltype="cf_sql_varchar">
					,t.UserId 		= <cfqueryparam value="#entity.getUserId()#" 	  cfsqltype="cf_sql_varchar">
					,t.journalName 	= <cfqueryparam value="#entity.getjournalName()#" cfsqltype="cf_sql_varchar">
					,t.description 	= <cfqueryparam value="#entity.getShortDescripton()#" cfsqltype="cf_sql_varchar">
					,t.creationDate = <cfqueryparam value="#entity.getCreatedOn()#"	  cfsqltype="cf_sql_datetime">
					,t.modifiedDate = <cfqueryparam value="#entity.getModifiedOn()#"  cfsqltype="cf_sql_datetime">

				WHERE t.id          	 = <cfqueryparam value="#currentId#" 				 cfsqltype="cf_sql_varchar">
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

	<cffunction name="deleteById" access="package" output="false" hint="Delete an entry from the database.">
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

	<cffunction name="list" access="package" returntype="query" output="false" hint="Get the collection of all entries in this table.">
	<cfargument name="formatDate" type="boolean" default="false">

	    <cftry>
			<cfquery name="list" datasource=#dataSource#>
				SELECT
					t.id
					,t.UserId
					,t.journalName as journal_name
					,t.description as short_description
					<cfif arguments.formatDate>
						,DATE_FORMAT(t.creationDate, '%M %e, %Y') as created_on
						,DATE_FORMAT(t.modifiedDate, '%M %e, %Y') as modified_on
					<cfelse>
						,t.creationDate as created_on
						,t.modifiedDate as modified_on
					</cfif>

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

	<cffunction name="get" access="package" returntype="any" output="false" hint="Get a specific journal by id or name">
		<cfargument name="searchValue" type="string"  required="true">
		<cfargument name="useName"     type="boolean" default="false">
		<cfargument name="formatDate" type="boolean" default="false">


		<cfset var columnName = "">

		<cfif useName>
			<cfset columnName = "t.name">
		<cfelse>
			<cfset columnName = "t.id">
		</cfif>

		<cftry>
			<cfquery name="get" datasource="#dataSource#">
				SELECT
					t.id
					,t.UserId
					,t.journalName as journal_name
					,t.description as short_description
					<cfif arguments.formatDate>
						,DATE_FORMAT(t.creationDate, '%M %e, %Y') as created_on
						,DATE_FORMAT(t.modifiedDate, '%M %e, %Y') as modified_on
					<cfelse>
						,t.creationDate as created_on
						,t.modifiedDate as modified_on
					</cfif>
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

	<cffunction name="getAllByUserID" access="package" returntype="query" output="false" hint="Get all journals by user id">
		<cfargument name="userId" type="string" required="true">
		<cfargument name="formatDate" type="boolean" default="false">

		<cftry>
			<cfquery name="getAllByUserID" datasource="#dataSource#">
				SELECT
					t.id
					,t.UserId
					,t.journalName as journal_name
					,t.description as short_description
					,u.username as username
					<cfif arguments.formatDate>
						,DATE_FORMAT(t.creationDate, '%M %e, %Y') as created_on
						,DATE_FORMAT(t.modifiedDate, '%M %e, %Y') as modified_on
					<cfelse>
						,t.creationDate as created_on
						,t.modifiedDate as modified_on
					</cfif>
				FROM #tableName# t
				LEFT JOIN users u ON u.id = t.UserId

				WHERE t.UserId = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message=
				'{
					"customMessage": "Error occurred in getAllByUserID()."
					"errorMessage": "#cfcatch.message#"
				}'>
				<cfreturn false>
			</cfcatch>
		</cftry>

		<cfreturn getAllByUserID>
	</cffunction>

	<cffunction name="findReferencingTables" access="package" returntype="array" output="false" hint="Find tables that reference a specific journal by ID">
		<cfargument name="journalId" type="string" required="true">

		<cfset var referencingTables = []>

		<cftry>
			<!--- Query to get tables with foreign key references --->
			<cfquery name="tablesQuery" datasource="#dataSource#">
				SELECT DISTINCT TABLE_NAME
				FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
				WHERE REFERENCED_TABLE_NAME IS NOT NULL
				AND COLUMN_NAME = 'journalId'
				AND TABLE_SCHEMA = DATABASE()
			</cfquery>

			<!--- Loop through the table names and check if they reference the specific journal ID --->
			<cfloop query="tablesQuery">
				<cfset var refTable = tablesQuery.TABLE_NAME>

				<cfquery name="referenceQuery" datasource="#dataSource#">
					SELECT 1
					FROM #refTable#
					WHERE journalId = <cfqueryparam value="#arguments.journalId#" cfsqltype="cf_sql_varchar">
					LIMIT 1
				</cfquery>
				<cfif referenceQuery.recordCount GT 0>
					<cfset arrayAppend(referencingTables, refTable)>
				</cfif>
			</cfloop>

			<cfcatch type="any">
				<cfthrow type="CustomError" message=
				'{
					"customMessage": "Error occurred in findReferencingTables()."
					"errorMessage": "#cfcatch.message#"
				}'>
				<cfreturn []>
			</cfcatch>
		</cftry>

		<cfreturn referencingTables>
	</cffunction>

	<cffunction name="search" access="package" returntype="query" output="false" hint="Search for journals by name">
		<cfargument name="search" type="struct" required="true">
		<cfargument name="formatDate" type="boolean" default="false">

		<cfif NOT structKeyExists(arguments.search, "column")>
			<cfthrow type="CustomError" message=
			'{
				"customMessage": "Error occurred in search()."
				"errorMessage": "Missing required argument: column"
			}'>
			<cfreturn false>

		<cfelseif NOT structKeyExists(arguments.search, "value")>
			<cfthrow type="CustomError" message=
			'{
				"customMessage": "Error occurred in search()."
				"errorMessage": "Missing required argument: value"
			}'>
			<cfreturn false>
		</cfif>

		<cftry>
			<cfquery name="search" datasource="#dataSource#">
				SELECT
					t.id
					,t.UserId
					,t.journalName as journal_name
					,t.description as short_description
					<cfif arguments.formatDate>
						,DATE_FORMAT(t.creationDate, '%M %e, %Y') as created_on
						,DATE_FORMAT(t.modifiedDate, '%M %e, %Y') as modified_on
					<cfelse>
						,t.creationDate as created_on
						,t.modifiedDate as modified_on
					</cfif>
				FROM #tableName# t

				WHERE '#arguments.search.column#' LIKE <cfqueryparam value='%#arguments.search.value#%' cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message=
				'{
					"customMessage": "Error occurred in search()."
					"errorMessage": "#cfcatch.message#"
				}'>
				<cfreturn false>
			</cfcatch>
		</cftry>

		<cfreturn search>
	</cffunction>



</cfcomponent>
