/**
 * This will be the service that will handle all the Vocabulary related functions.
 *
 * You might be able to get away with just editing the 'Vocabulary' text in Find
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="VocabularyServer" extends="BaseServer" {

	property name="accessGateway" inject="VocabularyAccess";
	this.type = "Vocabulary";

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

		/** Might not be needed as we will be creating enemies through the back end.
		* This will get an empty VocabularyDTO.
		* @return An empty Vocabulary DTO.
		*/
		public VocabularyDTO function getEmpty ()
		{
			return new models.gateway.app.Vocabulary.VocabularyDTO();
		}

		/**
		* This will get an empty Vocabulary Model, an instance of an Vocabulary.
		* @return An empty Vocabulary Model.
		*/
		public Vocabulary function getEmptyModel ()
		{
			return new models.gateway.app.Vocabulary.VocabularyModel();
		}


	/**
	* ----------------------------------------------------------------------------------------------
    * Basic Vocabulary Crud Functions
	* ----------------------------------------------------------------------------------------------
	*/
		/**
		* This will store a new Vocabulary.
		* @param Vocabulary The Vocabulary to store.
		* @return The Vocabulary that was stored.
		*/
		public struct function store(required VocabularyDTO dataToAdd)
		{
			var response = {};
			try{
				// Execute
				accessGateway.create(dataToAdd);
				response = responder.sendResponse(true, "Vocabulary created successfully.", dataToAdd)
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will return the list of all Vocabularys.
		* @return
		*/
		public function list()
		{
			var response = {};
			try{
				var data = accessGateway.list();
				response = responder.sendResponse(true, "Vocabularys listed successfully.", data);
			}catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will read an existing Vocabulary.
		* @param id The id of the Vocabulary to read.
		* @return The Vocabulary that was read.
		*/
		public function read(required string id)
		{
			var response = {};
			try{
				var data = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Vocabulary read successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will update an existing Vocabulary.
		* @param id The id of the Vocabulary to update.
		* @return The Vocabulary that was updated.
		*/
		public function update(required string id, required VocabularyDTO Vocabulary)
		{
			var response = {}

			try{
				// Get Old Data
				var oldData = accessGateway.getAccessObjectByID(id);
				// Execute -- Has to be in this order to create new data to retrieve in the `newData` variable.
				accessGateway.updateAccessObjectByID(id, Vocabulary);
				// Get New Data
				var newData = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Vocabulary updated successfully.", {
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
		* This will delete an existing Vocabulary.
		* @param id The id of the Vocabulary to delete.
		* @return The Vocabulary that was deleted.
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
				response = responder.sendResponse(true, "Vocabulary deleted successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

	/**
	* ----------------------------------------------------------------------------------------------
	* Vocabulary CUSTOM FUNCTIONS
	* ----------------------------------------------------------------------------------------------
	*/
}