/**
 * This will be the service that will handle all the Goal related functions.
 *
 * You might be able to get away with just editing the 'Goal' text in Find
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="GoalServer" extends="BaseServer" {

	property name="accessGateway" inject="GoalAccess";
	this.type = "Goal";

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

		/** Might not be needed as we will be creating enemies through the back end.
		* This will get an empty GoalDTO.
		* @return An empty Goal DTO.
		*/
		public GoalDTO function getEmpty ()
		{
			return new models.gateway.app.Goal.GoalDTO();
		}

		/**
		* This will get an empty Goal Model, an instance of an Goal.
		* @return An empty Goal Model.
		*/
		public Goal function getEmptyModel ()
		{
			return new models.gateway.app.Goal.GoalModel();
		}


	/**
	* ----------------------------------------------------------------------------------------------
    * Basic Goal Crud Functions
	* ----------------------------------------------------------------------------------------------
	*/
		/**
		* This will store a new Goal.
		* @param Goal The Goal to store.
		* @return The Goal that was stored.
		*/
		public struct function store(required GoalDTO dataToAdd)
		{
			var response = {};
			try{
				// Execute
				accessGateway.create(dataToAdd);
				response = responder.sendResponse(true, "Goal created successfully.", dataToAdd)
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will return the list of all Goals.
		* @return
		*/
		public function list()
		{
			var response = {};
			try{
				var data = accessGateway.list();
				response = responder.sendResponse(true, "Goals listed successfully.", data);
			}catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will read an existing Goal.
		* @param id The id of the Goal to read.
		* @return The Goal that was read.
		*/
		public function read(required string id)
		{
			var response = {};
			try{
				var data = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Goal read successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will update an existing Goal.
		* @param id The id of the Goal to update.
		* @return The Goal that was updated.
		*/
		public function update(required string id, required GoalDTO Goal)
		{
			var response = {}

			try{
				// Get Old Data
				var oldData = accessGateway.getAccessObjectByID(id);
				// Execute -- Has to be in this order to create new data to retrieve in the `newData` variable.
				accessGateway.updateAccessObjectByID(id, Goal);
				// Get New Data
				var newData = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Goal updated successfully.", {
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
		* This will delete an existing Goal.
		* @param id The id of the Goal to delete.
		* @return The Goal that was deleted.
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
				response = responder.sendResponse(true, "Goal deleted successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

	/**
	* ----------------------------------------------------------------------------------------------
	* Goal CUSTOM FUNCTIONS
	* ----------------------------------------------------------------------------------------------
	*/

	public function getFromJournal(required string id)
		{
			var response = {};

			try{
				// Get the data before deleting it.
				var data = accessGateway.getFromJournal(id);
				// Define response
				response = responder.sendResponse(true, "Goals retrieved successfully from JournalID: (#id#).", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

}