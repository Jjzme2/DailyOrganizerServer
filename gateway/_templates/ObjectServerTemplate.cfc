/**
 * This will be the service that will handle all the YOUROBJECT related functions.
 *
 * You might be able to get away with just editing the 'YOUROBJECT' text in Find
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="YOUROBJECTServer" extends="BaseServer" {

	property name="accessGateway" inject="YOUROBJECTAccess";

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

		/** Might not be needed as we will be creating enemies through the back end.
		* This will get an empty YOUROBJECTDTO.
		* @return An empty YOUROBJECT DTO.
		*/
		public YOUROBJECTDTO function getEmpty ()
		{
			return new models.gateway.app.YOUROBJECT.YOUROBJECTDTO();
		}

		/**
		* This will get an empty YOUROBJECT Model, an instance of an YOUROBJECT.
		* @return An empty YOUROBJECT Model.
		*/
		public YOUROBJECT function getEmptyModel ()
		{
			return new models.gateway.app.YOUROBJECT.YOUROBJECTModel();
		}


	/**
	* ----------------------------------------------------------------------------------------------
    * Basic YOUROBJECT Crud Functions
	* ----------------------------------------------------------------------------------------------
	*/
		/**
		* This will store a new YOUROBJECT.
		* @param YOUROBJECT The YOUROBJECT to store.
		* @return The YOUROBJECT that was stored.
		*/
		public struct function store(required YOUROBJECTDTO dataToAdd)
		{
			var response = {};
			try{
				// Execute
				accessGateway.create(dataToAdd);
				response = responder.sendResponse(true, "YOUROBJECT created successfully.", dataToAdd)
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will return the list of all YOUROBJECTs.
		* @return
		*/
		public function list()
		{
			var response = {};
			try{
				var data = accessGateway.list();
				response = responder.sendResponse(true, "YOUROBJECTs listed successfully.", data);
			}catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will read an existing YOUROBJECT.
		* @param id The id of the YOUROBJECT to read.
		* @return The YOUROBJECT that was read.
		*/
		public function read(required string id)
		{
			var response = {};
			try{
				var data = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "YOUROBJECT read successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will update an existing YOUROBJECT.
		* @param id The id of the YOUROBJECT to update.
		* @return The YOUROBJECT that was updated.
		*/
		public function update(required string id, required YOUROBJECTDTO YOUROBJECT)
		{
			var response = {}

			try{
				// Get Old Data
				var oldData = accessGateway.getAccessObjectByID(id);
				// Execute -- Has to be in this order to create new data to retrieve in the `newData` variable.
				accessGateway.updateAccessObjectByID(id, YOUROBJECT);
				// Get New Data
				var newData = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "YOUROBJECT updated successfully.", {
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
		* This will delete an existing YOUROBJECT.
		* @param id The id of the YOUROBJECT to delete.
		* @return The YOUROBJECT that was deleted.
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
				response = responder.sendResponse(true, "YOUROBJECT deleted successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

	/**
	* ----------------------------------------------------------------------------------------------
	* YOUROBJECT CUSTOM FUNCTIONS
	* ----------------------------------------------------------------------------------------------
	*/
}