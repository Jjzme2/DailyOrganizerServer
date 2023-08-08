<cfsilent>
	<cfset includeNavbarText = true>
	<cfset navBarMessage = "Welcome">
	<cfset includeMobileToggler = true>

	<cfset navLinks = [
		[navLinkId = 'Home', destination = mainLink],
		<!--- Admin Links
		[navLinkId = 'Admin',
			subLinks = [
				[subLinkIds = 'Forms',
					endPoints = [
						[endPointId = 'Enemies',     destination = 'admin/forms/enemies'],
						[endPointId = 'Enemy Types', destination = 'admin/forms/enemyTypes'],
					],
				]],
			],
		--->

		<!--- Personal Resources Links --->
		[navLinkId = 'Personal Resources',
			subLinks = [
				[subLinkIds = 'Bookmarks',
					endPoints = [
						[endPointId = 'Show',        destination = 'developer/showGoals'],
						[endPointId = 'Create', 	 destination = 'admin/forms/enemyTypes'],
					],
				]],
			],

		<!--- Developer Resources Links --->
		[navLinkId = 'Developer Resources',
			subLinks = [
				[subLinkIds = 'Goals',
					endPoints = [
						[endPointId = 'Show',        destination = 'developer/showGoals'],
						[endPointId = 'Enemy Types', destination = 'admin/forms/enemyTypes'],
					],
				]],
			],
	]>
</cfsilent>

<cfoutput>
	<cfparam name="session.loggedInId" default="">

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container-fluid">
			<cfif includeNavbarText>
				<a class="navbar-brand" href="#event.buildLink(mainLink)#">
					<cfif brandName neq "">
						<strong>#brandName#</strong>
					<cfelseif navBarMessage neq "">
						<strong>#navBarMessage#</strong>
					<cfelse>
						<strong>Home</strong>
					</cfif>
				</a>
			</cfif>

			<cfif includeMobileToggler>
				<button
					class="navbar-toggler"
					type="button"
					data-bs-toggle="collapse"
					data-bs-target="##navbarSupportedContent"
					aria-controls="navbarSupportedContent"
					aria-expanded="false"
					aria-label="Toggle navigation"
				>
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
			</cfif>

			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<cfloop array="#navLinks#" index="navLink">
					<li class="nav-item">
						<cfif !structKeyExists(navLink, "subLinks")>
							<!--- Should be a simple click link and go to page --->
							<a class="nav-link" href="#event.buildLink(navLink.destination)#">#navLink.navLinkId#</a>
						<cfelse>
						<!--- Should be a dropdown menu for subLinks --->
							<ul class="nav-item dropdown">
								<a
									class="nav-link dropdown-toggle"
									href="##"
									id="navbarDropdown"
									role="button"
									data-bs-toggle="dropdown"
									aria-expanded="false"
								>
									#navLink.navLinkId#<b class="caret"></b>
								</a>

								<ul class="nav-item dropdown-menu" aria-labelledby="navbarDropdown">
									<li>
										<cfloop array="#navLink.subLinks#" item="subLink">
											<ul class="nav-item">#subLink.subLinkIds#</li>
												<cfloop array="#subLink.endPoints#" index="ep">
													<li style="margin-left: 30px;">
														<a class="nav-item" href="#event.buildLink(ep.destination)#">#ep.endPointId#</a>
													</li>
												</cfloop>
											</ul>
										</cfloop>
									</li>
								</ul>
							</ul>

						</cfif>
					</li>
				</cfloop>
			</ul>

			</div>
		</div>
	</nav>
</cfoutput>
