/**
 * Journal REST Handler
 */
component extends="BaseApi" {

	property name="dataServer" 	    inject="QuoteServer";

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	remote function index( event, rc, prc ){
		var target = dataServer.list();
		event.renderData( type="json", data=target );
	}
}
