<cfoutput>
<!doctype html>
	<html lang="en">
		<cfinclude template="./DocHead.cfm">

		<body
			data-spy="scroll"
			data-target=".navbar"
			data-offset="50"
			style="padding-top: 60px"
			class="d-flex flex-column h-100"
			>
			<!---Top NavBar --->
			<header>
				<cfinclude template="./Navbar.cfm">
			</header>

			<!---Container And Views --->
			<main class="main-layout">
				<!--- Show messages in messagebox --->
				#getInstance( "messagebox@cbMessageBox" ).renderit()#
				#renderView()#
			</main>

			<!--- Footer --->
			<cfinclude template="./Footer.cfm">

			<!---
				JavaScript
				- Bootstrap
				- Alpine.js
			--->

			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script> <!--- jQuery --->
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
			<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

			<!--- DataTables --->
			<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

			<!--- D3 --->
			<script src="https://d3js.org/d3.v7.min.js"></script>

			<!--- FileSaver.js --->
			<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.0/FileSaver.min.js" integrity="sha512-csNcFYJniKjJxRWRV1R7fvnXrycHP6qDR21mgz1ZP55xY5d+aHLfo9/FcGDQLfn2IfngbAHd8LdfsagcCqgTcQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

			<!--- Custom JS --->

			<script src="/assets/js/cfcCallers.js"></script>

			<!---
				<script src="/assets/js/util.js"></script>
				<script src="/includes/js/datatables.js"></script>
				<script src="/includes/js/d3.js"></script>
			--->
		</body>
	</html>
</cfoutput>
