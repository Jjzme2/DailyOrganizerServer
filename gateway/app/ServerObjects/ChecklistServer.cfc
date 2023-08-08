/**
 * This will be the service that will handle all the Checklist related functions.
 *
 * You might be able to get away with just editing the 'Checklist' text in Find
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="ChecklistServer" extends="BaseServer" {

	property name="accessGateway" inject="ChecklistAccess";
	this.type = "Checklist";

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

		/** Might not be needed as we will be creating enemies through the back end.
		* This will get an empty ChecklistDTO.
		* @return An empty Checklist DTO.
		*/
		public ChecklistDTO function getEmpty ()
		{
			return new models.gateway.app.Checklist.ChecklistDTO();
		}

		/**
		* This will get an empty Checklist Model, an instance of an Checklist.
		* @return An empty Checklist Model.
		*/
		public Checklist function getEmptyModel ()
		{
			return new models.gateway.app.Checklist.ChecklistModel();
		}


	/**
	* ----------------------------------------------------------------------------------------------
    * Basic Checklist Crud Functions
	* ----------------------------------------------------------------------------------------------
	*/
		/**
		* This will store a new Checklist.
		* @param Checklist The Checklist to store.
		* @return The Checklist that was stored.
		*/
		public struct function store(required ChecklistDTO dataToAdd)
		{
			var response = {};
			try{
				// Execute
				accessGateway.create(dataToAdd);
				response = responder.sendResponse(true, "Checklist created successfully.", dataToAdd)
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will return the list of all Checklists.
		* @return
		*/
		public function list()
		{
			var response = {};
			try{
				var data = accessGateway.list();
				response = responder.sendResponse(true, "Checklists listed successfully.", data);
			}catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will read an existing Checklist.
		* @param id The id of the Checklist to read.
		* @return The Checklist that was read.
		*/
		public function read(required string id)
		{
			var response = {};
			try{
				var data = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Checklist read successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will update an existing Checklist.
		* @param id The id of the Checklist to update.
		* @return The Checklist that was updated.
		*/
		public function update(required string id, required ChecklistDTO Checklist)
		{
			var response = {}

			try{
				// Get Old Data
				var oldData = accessGateway.getAccessObjectByID(id);
				// Execute -- Has to be in this order to create new data to retrieve in the `newData` variable.
				accessGateway.updateAccessObjectByID(id, Checklist);
				// Get New Data
				var newData = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Checklist updated successfully.", {
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
		* This will delete an existing Checklist.
		* @param id The id of the Checklist to delete.
		* @return The Checklist that was deleted.
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
				response = responder.sendResponse(true, "Checklist deleted successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

	/**
	* ----------------------------------------------------------------------------------------------
	* Checklist CUSTOM FUNCTIONS
	* ----------------------------------------------------------------------------------------------
	*/

	public function getFromJournal(required string id)
		{
			var response = {};

			try{
				// Get the data before deleting it.
				var data = accessGateway.getFromJournal(id);
				// Define response
				response = responder.sendResponse(true, "Checklists retrieved successfully from JournalID: (#id#).", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}
}