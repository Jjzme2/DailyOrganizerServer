<cfoutput>
	<footer class="w-100 bottom-0 position-fixed border-top py-3 mt-5 bg-light">
		<div class="container">
			<p class="float-end">
				<a href="##" class="btn btn-info rounded-circle shadow" role="button">
					<i class="bi bi-arrow-bar-up"></i> <span class="visually-hidden">Top</span>
				</a>

				<!--- Fw reinit = hide in prod --->
				<cfset queryString = '?' & cgi.query_string>
				<cfset reinitValue = (queryString == ""
										? "?fwreinit=1"
										: (queryString.Contains("?fwreinit") || queryString.Contains('&fwreinit=1'))
										? ""
										: "&fwreinit=1")>

				<a href="#event.buildLink(rc.event & queryString & reinitValue)#" class="btn btn-info rounded-circle shadow" role="button">
					<i class="bi bi-power"></i> <span class="visually-hidden">Reinit</span>
				</a>
			</p>
			<p>
				<div class="main-footer">
					<cfif year(now()) NEQ 2023>
						<span class="text-muted">&copy; 2023 - #dateFormat(now(), 'yyyy')#</span>
					<cfelse>
						<span class="text-muted">&copy; 2023</span>
					</cfif>

					<!--- <a href="##" class="text-decoration-none">Company Name</a> --->
					<span class="text-muted">All Rights Reserved</span>
				</div>
			</p>
		</div>
	</footer>
</cfoutput>