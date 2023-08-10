/**
 * This will be the service that will handle all the Journal related functions.
 *
 * You might be able to get away with just editing the 'Journal' text in Find
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="JournalServer" extends="BaseServer" {

	property name="accessGateway" inject="JournalAccess";
	this.type = "Journal";

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

		/** Might not be needed as we will be creating enemies through the back end.
		* This will get an empty JournalDTO.
		* @return An empty Journal DTO.
		*/
		public JournalDTO function getEmpty ()
		{
			return new models.gateway.app.Journal.JournalDTO();
		}

		/**
		* This will get an empty Journal Model, an instance of an Journal.
		* @return An empty Journal Model.
		*/
		public Journal function getEmptyModel ()
		{
			return new models.gateway.app.Journal.JournalModel();
		}


	/**
	* ----------------------------------------------------------------------------------------------
    * Basic Journal Crud Functions
	* ----------------------------------------------------------------------------------------------
	*/
		/**
		* This will store a new Journal.
		* @param Journal The Journal to store.
		* @return The Journal that was stored.
		*/
		public struct function store(required JournalDTO dataToAdd)
		{
			var response = {};
			try{
				// Execute
				accessGateway.create(dataToAdd);
				response = responder.sendResponse(true, "Journal created successfully.", dataToAdd)
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will return the list of all Journals.
		* @return
		*/
		public function list(boolean autoFormat = true)
		{
			var response = {};
			try{
				var data = accessGateway.list(autoFormat);
				response = responder.sendResponse(true, "Journals listed successfully.", data);
			}catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will read an existing Journal.
		* @param id The id of the Journal to read.
		* @return The Journal that was read.
		*/
		public function read(required string id)
		{
			var response = {};
			try{
				var data = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Journal read successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will update an existing Journal.
		* @param id The id of the Journal to update.
		* @return The Journal that was updated.
		*/
		public function update(required string id, required JournalDTO Journal)
		{
			var response = {}

			try{
				// Get Old Data
				var oldData = accessGateway.getAccessObjectByID(id);
				// Execute -- Has to be in this order to create new data to retrieve in the `newData` variable.
				accessGateway.updateAccessObjectByID(id, Journal);
				// Get New Data
				var newData = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Journal updated successfully.", {
					"oldData" : oldData,
					"newData" : newData
				});
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will delete an existing Journal.
		* @param id The id of the Journal to delete.
		* @return The Journal that was deleted.
		*/
		public function delete(required string id)
		{
			var response = {};

			try{
				// Get the data before deleting it.
				var data = accessGateway.getAccessObjectByID(id);
				// Execute
				accessGateway.deleteAccessObjectByID(id);
				// Define response
				response = responder.sendResponse(true, "Journal deleted successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

	/**
	* ----------------------------------------------------------------------------------------------
	* Journal CUSTOM FUNCTIONS
	* ----------------------------------------------------------------------------------------------
	*/

	public function findReferencingTables(required string journalId)
	{
		var response = {};
		try{
			var data  = accessGateway.findReferencingTables(journalId);
			response = responder.sendResponse(true, "Tables with Journal.", data);
		}catch(any e){
			response = responder.sendResponse(false, serializeJSON(e.message), {})
			throw(e);
		}
		return response;
	}
	public function search(required string column, required string value)
	{
		var response = {};

		try{
			var data =
				arguments.column == 'name' ?
				accessGateway.get(searchValue=arguments.value, useName=true, formatDate=true) :
				accessGateway.get(searchValue=arguments.value, useName=false, formatDate=true);

			response = responder.sendResponse(true, "Search [Column: #arguments.column# | Value: #arguments.value#] returned the data shown.", data);
		}catch(any e){
			response = responder.sendResponse(false, serializeJSON(e.message), {})
			throw(e);
		}
		return response;
	}

	/**
	* ----------------------------------------------------------------------------------------------
	* Journal Relationship Functions
	* ----------------------------------------------------------------------------------------------
	*/

	/**
	* This will return the list of all Journals by a specific user.
	* @return
	*/
	public function getAllByUserID(required string userID, boolean autoFormat = true)
	{
		var response = {};
		try{
			var data = accessGateway.getAllByUserID(userID, autoFormat);
			response = responder.sendResponse(true, "Journals listed successfully.", data);
		}catch(any e){
			response = responder.sendResponse(false, serializeJSON(e.message), {})
			throw(e);
		}
		return response;
	}
}