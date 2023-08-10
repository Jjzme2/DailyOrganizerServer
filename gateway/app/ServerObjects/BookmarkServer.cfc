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

	/**
	 * This will get an empty bookmarkDTO.
	 * @return An empty bookmark DTO.
	 */
	public BookmarkDTO function getEmpty()
	{
		return new models.DTO.BookmarkDTO();
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
		public struct function store(required struct dataToAdd)
		{
			var response = {};
			var dataObject = populator.populateFromStruct(getEmpty(), arguments.dataToAdd);

			try{
				// Execute
				accessGateway.create(dataObject);
				response = responder.sendResponse(true, "bookmark created successfully.", dataObject)
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
				var data = accessGateway.get(id);
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

	public function getYoutubeURLs(required boolean isYoutube, string journalId)
	{
		var response = {};

		try{
			var data = accessGateway.getYoutubeURLs(isYoutube=isYoutube, journalID=journalId);
			// Define response
			response = responder.sendResponse(true, "Videos retrieved successfully", data);
		}
		catch(any e){
			response = responder.sendResponse(false, serializeJSON(e.message), {})
			throw(e);
		}

		return response;
	}

	public function getBySearchTerm(required string searchTerm, string journalId){
		var response = {};

		try{
			var data = accessGateway.getBySearchTerm(searchTerm=arguments.searchTerm, journalID=arguments.journalId);
			// Define response
			response = responder.sendResponse(true, "URLs containing: [#arguments.searchTerm#] retrieved successfully", data);
		}
		catch(any e){
			response = responder.sendResponse(false, serializeJSON(e.message), {})
			throw(e);
		}

		return response;
	}


}