/**
 * Journal REST Handler
 */
component extends="BaseApi" {

	property name="dataServer" 	    inject="JournalServer";

	// Other servers
	property name="bookmarkServer" 	 inject="BookmarkServer";
	property name="quoteServer" 	 inject="QuoteServer";
	property name="checklistServer"  inject="ChecklistServer";
	property name="eventServer" 	 inject="EventServer";
	// property name="favoriteServer" 	 inject="FavoriteServer";
	property name="goalServer" 		 inject="GoalServer";
	property name="noteServer" 		 inject="NoteServer";
	property name="todoServer" 		 inject="TodoServer";
	property name="vocabularyServer" inject="VocabularyServer";

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

	remote function search( event, rc, prc ){
		var target = dataServer.search( column=rc.column, value=rc.value );
		event.renderData( type="json", data=target );
	}

	remote function getUserJournals ( event, rc, prc ) {
		var target = dataServer.getAllByUserID( rc.id );
		event.renderData( type="json", data=target );
	}

	remote function getTOC ( event, rc, prc ) {
		var target = dataServer.findReferencingTables( rc.id );
		event.renderData( type="json", data=target );
	}

	/**
	 * --------------------------------------------------------------------------------
	 * GET FROM JOURNAL
	 * --------------------------------------------------------------------------------
	 */
}
