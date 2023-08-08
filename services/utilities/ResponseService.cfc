component name="ResponseService" {

	/**
	 * Send a simple response
	 * @status: success or error
	 * @message: message to send
	 */
	public struct function sendSimpleResponse(required string status, required string message) {
		return {
			"status": "success",
			"message": arguments.message
		};
	}

	/**
	 * Send a response with data
	 * @status: success or error
	 * @message: message to send
	 * @data: data to send
	 */
	public struct function sendResponse(required string status, required string message, required any data) {
		var res = {
			"status": !arguments.status ? "error" : "success",
			"message": arguments.message,
			"data": arguments.data
		}

		if(!arguments.status) {
			cfthrow(type="CustomError", message=arguments.message, detail=serializeJSON(arguments.data))
		}else{ return res; }
	}

}
