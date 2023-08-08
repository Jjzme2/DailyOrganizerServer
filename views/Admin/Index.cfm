<cfoutput>
<!--- Check if Admin before allowing access --->
<cfif true> <!--- TODO: Set IsAdmin --->
	<h1>Welcome to the Tower of Infinity Server</h1>
<cfelse>
	<p>Access denied. You must be an admin to view this page.</p>
</cfif>


	<!--- Note: Broken
		<!--- AJAX Practice/ Markdown Cfc calls --->
		<h2>Markdown:</h2>
		<textarea id='markdownText' placeholder='Markdown'></textarea>
		<select id='markdownType'>
			<option value='title'>Title</option>
			<option value='link'>Link</option>
			<option value='list'>List</option>
		</select>
		<button id="getMarkdownButton">Convert To Markdown</button>

		<!--- Note: Broken --->
		<h2>Add Goal:</h2>
		<input type='text' id='goalName' placeholder='Goal Name' />
		<input type='date' id='dueDate' placeholder='Due Date' />
		<select id='priority'>
			<option value='Low'>Low</option>
			<option value='Medium'>Medium</option>
			<option value='High'>High</option>
		</select>
		<button id='addGoal'>Add Goal</button>
	--->
</cfoutput>
