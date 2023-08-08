/**
 * This will be the service that will handle all the Event related functions.
 *
 * You might be able to get away with just editing the 'Event' text in Find
 *
 * @Author Jj Zettler
 * @date 4/28/2023
 * @version 0.1
 */
//  extends="BaseService"
component singleton accessors="true" name="EventServer" extends="BaseServer" {

	property name="accessGateway" inject="EventAccess";
	this.type = "Event";

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

		/** Might not be needed as we will be creating enemies through the back end.
		* This will get an empty EventDTO.
		* @return An empty Event DTO.
		*/
		public EventDTO function getEmpty ()
		{
			return new models.gateway.app.Event.EventDTO();
		}

		/**
		* This will get an empty Event Model, an instance of an Event.
		* @return An empty Event Model.
		*/
		public Event function getEmptyModel ()
		{
			return new models.gateway.app.Event.EventModel();
		}


	/**
	* ----------------------------------------------------------------------------------------------
    * Basic Event Crud Functions
	* ----------------------------------------------------------------------------------------------
	*/
		/**
		* This will store a new Event.
		* @param Event The Event to store.
		* @return The Event that was stored.
		*/
		public struct function store(required EventDTO dataToAdd)
		{
			var response = {};
			try{
				// Execute
				accessGateway.create(dataToAdd);
				response = responder.sendResponse(true, "Event created successfully.", dataToAdd)
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will return the list of all Events.
		* @return
		*/
		public function list()
		{
			var response = {};
			try{
				var data = accessGateway.list();
				response = responder.sendResponse(true, "Events listed successfully.", data);
			}catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}
			return response;
		}

		/**
		* This will read an existing Event.
		* @param id The id of the Event to read.
		* @return The Event that was read.
		*/
		public function read(required string id)
		{
			var response = {};
			try{
				var data = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Event read successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

		/**
		* This will update an existing Event.
		* @param id The id of the Event to update.
		* @return The Event that was updated.
		*/
		public function update(required string id, required EventDTO Event)
		{
			var response = {}

			try{
				// Get Old Data
				var oldData = accessGateway.getAccessObjectByID(id);
				// Execute -- Has to be in this order to create new data to retrieve in the `newData` variable.
				accessGateway.updateAccessObjectByID(id, Event);
				// Get New Data
				var newData = accessGateway.getAccessObjectByID(id);
				response = responder.sendResponse(true, "Event updated successfully.", {
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
		* This will delete an existing Event.
		* @param id The id of the Event to delete.
		* @return The Event that was deleted.
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
				response = responder.sendResponse(true, "Event deleted successfully.", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}

	/**
	* ----------------------------------------------------------------------------------------------
	* Event CUSTOM FUNCTIONS
	* ----------------------------------------------------------------------------------------------
	*/

	public function getFromJournal(required string id)
		{
			var response = {};

			try{
				// Get the data before deleting it.
				var data = accessGateway.getFromJournal(id);
				// Define response
				response = responder.sendResponse(true, "Events retrieved successfully from JournalID: (#id#).", data);
			}
			catch(any e){
				response = responder.sendResponse(false, serializeJSON(e.message), {})
				throw(e);
			}

			return response;
		}
}