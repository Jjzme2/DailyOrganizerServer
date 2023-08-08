/**
 * This will be the service that will handle all the bookmark related functions.
 *
 * You might be able to get away with just editing the 'bookmark' text in Find
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="bookmarkServer" extends="BaseServer" {

	property name="accessGateway" inject="bookmarkAccess";
	this.type = 'Bookmark';

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

		/** Might not be needed as we will be creating enemies through the back end.
		* This will get an empty bookmarkDTO.
		* @return An empty bookmark DTO.
		*/
		public bookmarkDTO function getEmpty ()
		{
			return new models.gateway.app.bookmark.bookmarkDTO();
		}

		/**
		* This will get an empty bookmark Model, an instance of an bookmark.
		* @return An empty bookmark Model.
		*/
		public bookmark function getEmptyModel ()
		{
			return new models.gateway.app.bookmark.bookmarkModel();
		}


	/**
	* ----------------------------------------------------------------------------------------------
    * Basic bookmark Crud Functions
	* ----------------------------------------------------------------------------------------------
	*/
		/**
		* This will store a new bookmark.
		* @param bookmark The bookmark to store.
		* @return The bookmark that was stored.
		*/
		public struct function store(required bookmarkDTO dataToAdd)
		{
			var response = {};
			try{
				// Execute
				accessGateway.create(dataToAdd);
				response = responder.sendResponse(true, "bookmark created successfully.", dataToAdd)
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will return the list of all bookmarks.
		* @return
		*/
		public function list()
		{
			var response = {};
			try{
				var data = accessGateway.list();
				response = responder.sendResponse(true, "bookmarks listed successfully.", data);
			}catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will read an existing bookmark.
		* @param id The id of the bookmark to read.
		* @return The bookmark that was read.
		*/
		public function read(required string id)
		{
			var response = {};
			try{
				var data = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "bookmark read successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will update an existing bookmark.
		* @param id The id of the bookmark to update.
		* @return The bookmark that was updated.
		*/
		public function update(required string id, required bookmarkDTO bookmark)
		{
			var response = {}

			try{
				// Get Old Data
				var oldData = accessGateway.getAccessObjectByID(id);
				// Execute -- Has to be in this order to create new data to retrieve in the `newData` variable.
				accessGateway.updateAccessObjectByID(id, bookmark);
				// Get New Data
				var newData = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "bookmark updated successfully.", {
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
		* This will delete an existing bookmark.
		* @param id The id of the bookmark to delete.
		* @return The bookmark that was deleted.
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
				response = responder.sendResponse(true, "bookmark deleted successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

	/**
	* ----------------------------------------------------------------------------------------------
	* bookmark CUSTOM FUNCTIONS
	* ----------------------------------------------------------------------------------------------
	*/

	public function getFromJournal(required string id)
		{
			var response = {};

			try{
				// Get the data before deleting it.
				var data = accessGateway.getFromJournal(id);
				// Define response
				response = responder.sendResponse(true, "Bookmarks retrieved successfully from JournalID: (#id#).", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}
}