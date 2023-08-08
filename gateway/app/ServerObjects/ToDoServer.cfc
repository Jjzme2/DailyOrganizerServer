/**
 * This will be the service that will handle all the ToDo related functions.
 *
 * You might be able to get away with just editing the 'ToDo' text in Find
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="ToDoServer" extends="BaseServer" {

	property name="accessGateway" inject="ToDoAccess";
	this.type = "ToDo";

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

		/** Might not be needed as we will be creating enemies through the back end.
		* This will get an empty ToDoDTO.
		* @return An empty ToDo DTO.
		*/
		public ToDoDTO function getEmpty ()
		{
			return new models.gateway.app.ToDo.ToDoDTO();
		}

		/**
		* This will get an empty ToDo Model, an instance of an ToDo.
		* @return An empty ToDo Model.
		*/
		public ToDo function getEmptyModel ()
		{
			return new models.gateway.app.ToDo.ToDoModel();
		}


	/**
	* ----------------------------------------------------------------------------------------------
    * Basic ToDo Crud Functions
	* ----------------------------------------------------------------------------------------------
	*/
		/**
		* This will store a new ToDo.
		* @param ToDo The ToDo to store.
		* @return The ToDo that was stored.
		*/
		public struct function store(required ToDoDTO dataToAdd)
		{
			var response = {};
			try{
				// Execute
				accessGateway.create(dataToAdd);
				response = responder.sendResponse(true, "ToDo created successfully.", dataToAdd)
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will return the list of all ToDos.
		* @return
		*/
		public function list()
		{
			var response = {};
			try{
				var data = accessGateway.list();
				response = responder.sendResponse(true, "ToDos listed successfully.", data);
			}catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will read an existing ToDo.
		* @param id The id of the ToDo to read.
		* @return The ToDo that was read.
		*/
		public function read(required string id)
		{
			var response = {};
			try{
				var data = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "ToDo read successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will update an existing ToDo.
		* @param id The id of the ToDo to update.
		* @return The ToDo that was updated.
		*/
		public function update(required string id, required ToDoDTO ToDo)
		{
			var response = {}

			try{
				// Get Old Data
				var oldData = accessGateway.getAccessObjectByID(id);
				// Execute -- Has to be in this order to create new data to retrieve in the `newData` variable.
				accessGateway.updateAccessObjectByID(id, ToDo);
				// Get New Data
				var newData = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "ToDo updated successfully.", {
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
		* This will delete an existing ToDo.
		* @param id The id of the ToDo to delete.
		* @return The ToDo that was deleted.
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
				response = responder.sendResponse(true, "ToDo deleted successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

	/**
	* ----------------------------------------------------------------------------------------------
	* ToDo CUSTOM FUNCTIONS
	* ----------------------------------------------------------------------------------------------
	*/

	public function getFromJournal(required string id)
		{
			var response = {};

			try{
				// Get the data before deleting it.
				var data = accessGateway.getFromJournal(id);
				// Define response
				response = responder.sendResponse(true, "ToDos retrieved successfully from JournalID: (#id#).", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}
}