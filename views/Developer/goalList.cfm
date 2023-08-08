<cfoutput>
<h2>Goals:</h2>
	<table class='main-table'>
		<tr>
			<th>Goal Name</th>
			<th>Association</th>
			<th>Notes</th>
			<th>Active</th>
		</tr>
		<cfloop array="#prc.goals#" index="goal">
			<tr>
				<td>#goal.goal_name#</td>
				<td>#goal.association_name#</td>
				<td>#goal.notes#</td>
				<td>
					<input type='checkbox' id='isActive_#goal.id#' <cfif goal.is_active>checked</cfif> />
				</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>
