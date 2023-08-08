/**
 * This will be the service that will handle all the Note related functions.
 *
 * You might be able to get away with just editing the 'Note' text in Find
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="NoteServer" extends="BaseServer" {

	property name="accessGateway" inject="NoteAccess";
	this.type = "Note";

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

		/** Might not be needed as we will be creating enemies through the back end.
		* This will get an empty NoteDTO.
		* @return An empty Note DTO.
		*/
		public NoteDTO function getEmpty ()
		{
			return new models.gateway.app.Note.NoteDTO();
		}

		/**
		* This will get an empty Note Model, an instance of an Note.
		* @return An empty Note Model.
		*/
		public Note function getEmptyModel ()
		{
			return new models.gateway.app.Note.NoteModel();
		}


	/**
	* ----------------------------------------------------------------------------------------------
    * Basic Note Crud Functions
	* ----------------------------------------------------------------------------------------------
	*/
		/**
		* This will store a new Note.
		* @param Note The Note to store.
		* @return The Note that was stored.
		*/
		public struct function store(required NoteDTO dataToAdd)
		{
			var response = {};
			try{
				// Execute
				accessGateway.create(dataToAdd);
				response = responder.sendResponse(true, "Note created successfully.", dataToAdd)
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will return the list of all Notes.
		* @return
		*/
		public function list()
		{
			var response = {};
			try{
				var data = accessGateway.list();
				response = responder.sendResponse(true, "Notes listed successfully.", data);
			}catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will read an existing Note.
		* @param id The id of the Note to read.
		* @return The Note that was read.
		*/
		public function read(required string id)
		{
			var response = {};
			try{
				var data = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Note read successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will update an existing Note.
		* @param id The id of the Note to update.
		* @return The Note that was updated.
		*/
		public function update(required string id, required NoteDTO Note)
		{
			var response = {}

			try{
				// Get Old Data
				var oldData = accessGateway.getAccessObjectByID(id);
				// Execute -- Has to be in this order to create new data to retrieve in the `newData` variable.
				accessGateway.updateAccessObjectByID(id, Note);
				// Get New Data
				var newData = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Note updated successfully.", {
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
		* This will delete an existing Note.
		* @param id The id of the Note to delete.
		* @return The Note that was deleted.
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
				response = responder.sendResponse(true, "Note deleted successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

	/**
	* ----------------------------------------------------------------------------------------------
	* Note CUSTOM FUNCTIONS
	* ----------------------------------------------------------------------------------------------
	*/

		public function getFromJournal(required string id)
		{
			var response = {};

			try{
				// Get the data before deleting it.
				var data = accessGateway.getFromJournal(id);
				// Define response
				response = responder.sendResponse(true, "Notes retrieved successfully from JournalID: (#id#).", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}
}