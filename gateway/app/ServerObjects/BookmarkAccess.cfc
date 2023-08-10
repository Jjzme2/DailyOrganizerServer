<cfcomponent output="false">

	<cfset tableName  = "bookmarks"> <!--- SET THIS --->
	<cfset dataSource = "personal_resources"> <!--- SET THIS --->

	<!---
	 * -------------------------------------------------------------
	 * 	CRUD FUNCTIONS
	 * -------------------------------------------------------------
	 --->

	<cffunction name="create" access="package" returntype="boolean" output="false" hint="Adds a new entry into the database.">
		<cfargument name="entity" type="BookmarkDTO" required="true">

		<cftry>
			<cfquery datasource=#dataSource#>
				INSERT INTO #tableName# (
					id
					,journalId
					,creationDate
					,modifiedDate
					,title
					,URL
					,isYoutubeVideo
					,Description
				)
				VALUES (
					<cfqueryparam  value="#entity.getBookmark_id()#" 	  cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getJournal_id()#" 	  cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getCreated_on()#"   	  cfsqltype="cf_sql_datetime">
					,<cfqueryparam value="#entity.getModified_on()#"      cfsqltype="cf_sql_datetime">
					,<cfqueryparam value="#entity.getBookmark_title()#"	  cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getUrl()#"			  cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getIs_youtube_url()#"	  cfsqltype="cf_sql_bit">
					,<cfqueryparam value="#entity.getShort_description()#"cfsqltype="cf_sql_varchar">
				)
			</cfquery>

			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in create().",
					"errorMessage": "#cfcatch.message#" }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>
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
					t.id             = <cfqueryparam value="#entity.getId()#"          	 	cfsqltype="cf_sql_varchar">
					,t.journalId     = <cfqueryparam value="#entity.getJournalId()#" 	 	cfsqltype="cf_sql_varchar">
					,t.creationDate	 = <cfqueryparam value="#entity.getCreatedOn()#"	 	cfsqltype="cf_sql_datetime">
					,t.modifiedDate	 = <cfqueryparam value="#entity.getModifiedOn()#"	 	cfsqltype="cf_sql_datetime">
					,t.title		 = <cfqueryparam value="#entity.getBookmarkTitle()#"	cfsqltype="cf_sql_varchar">
					,t.URL  	 	 = <cfqueryparam value="#entity.getURL()#" 	 		    cfsqltype="cf_sql_varchar">
					,t.isYoutubeVideo	 = <cfqueryparam value="#entity.getisYoutubeVideo()#"     cfsqltype="cf_sql_bit">
					,t.Description	 = <cfqueryparam value="#entity.getShortDescription()#"	cfsqltype="cf_sql_varchar">

				WHERE t.id          	 = <cfqueryparam value="#currentId#" 			 cfsqltype="cf_sql_varchar">
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
					t.id as bookmark_id
					,t.journalId as journal_id
					,t.creationDate as created_on
					,t.modifiedDate as modified_on
					,t.title as bookmark_title
					,t.URL as url
					,t.isYoutubeVideo as is_youtube_url
					,t.Description as short_description
				FROM #tableName# t

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
					t.id as bookmark_id
					,t.journalId as journal_id
					,t.creationDate as created_on
					,t.modifiedDate as modified_on
					,t.title as bookmark_title
					,t.URL as url
					,t.isYoutubeVideo as is_youtube_url
					,t.Description as short_description
				FROM #tableName# t

				WHERE #columnName# = <cfqueryparam value="#searchValue#" cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfthrow type="CustomError" message="Error occurred in get().">
				<cfreturn {}>
			</cfcatch>
		</cftry>

		<cfreturn {}.append(get)>
	</cffunction>

	<cffunction name="getFromJournal" access="package" returntype="any" output="false">
		<cfargument name="journalId" type="string"  required="true">

		<cftry>
			<cfquery name="get" datasource="#dataSource#">
				SELECT
					t.id as bookmark_id
					,t.journalId as journal_id
					,t.creationDate as created_on
					,t.modifiedDate as modified_on
					,t.title as bookmark_title
					,t.URL as url
					,t.isYoutubeVideo as is_youtube_url
					,t.Description as short_description
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

	<cffunction name="getBySearchTerm" access="package" returntype="any" output="false">
		<cfargument name="searchTerm" 		 type="string"  required="true">
		<cfargument name="journalID" type="string"  default="">

		<cfquery name="getWithURL" datasource="#dataSource#">
			SELECT
				t.id as bookmark_id
				,t.journalId as journal_id
				,t.creationDate as created_on
				,t.modifiedDate as modified_on
				,t.title as bookmark_title
				,t.URL as url
				,t.isYoutubeVideo as is_youtube_url
				,t.Description as short_description
			FROM #tableName# t

			WHERE t.URL LIKE <cfqueryparam value="%#arguments.searchTerm#%" cfsqltype="cf_sql_varchar">
			<cfif len(arguments.journalID)>
				AND t.journalId = <cfqueryparam value="#arguments.journalID#" cfsqltype="cf_sql_varchar">
			</cfif>
		</cfquery>

		<cfreturn getWithURL>
	</cffunction>

	<cffunction name="getYoutubeURLs" access="package" returntype="any" output="false">
		<cfargument name="isYoutube" type="boolean" required="true">
		<cfargument name="journalID" type="string"  default="">

		<cfquery name="getYoutubeURLs" datasource="#dataSource#">
			SELECT
				t.id as bookmark_id
				,t.journalId as journal_id
				,t.creationDate as created_on
				,t.modifiedDate as modified_on
				,t.title as bookmark_title
				,t.URL as url
				,t.isYoutubeVideo as is_youtube_url
				,t.Description as short_description
			FROM #tableName# t

			WHERE t.isYoutubeVideo = <cfqueryparam value="#arguments.isYoutube#" cfsqltype="cf_sql_bit">
			<cfif len(arguments.journalID)>
				AND t.journalId = <cfqueryparam value="#arguments.journalID#" cfsqltype="cf_sql_varchar">
			</cfif>
		</cfquery>

		<cfreturn getYoutubeURLs>
	</cffunction>
</cfcomponent>
