/**
 * My RESTFul Event Handler
 */
component extends="coldbox.system.RestHandler" {

	property name="populator"  	inject="wirebox:populator";
	property name="customLogger"inject="Logging:Logger";
	property name="devHelper"  	inject="DevHelper";
	// property name="mdGen"  		inject="dev/docGen:MarkdownGenerationService"; -- Needs work
	property name="converter"  	inject="ConversionService";
	property name="validator" 	inject="ValidationService";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	 * Handle PreFlight Requests
	 */
	remote function preFlight( event, rc, prc ){
		// logService.sendLog(message="PreFlight Request Made @ #now()#", prefix="CORS_Preflight");
	}

}
