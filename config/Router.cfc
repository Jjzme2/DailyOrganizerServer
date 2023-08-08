/**
 * This is your application router.  From here you can controll all the incoming routes to your application.
 *
 * https://coldbox.ortusbooks.com/the-basics/routing
 */
component {

	function configure(){
		/**
		 * --------------------------------------------------------------------------
		 * Router Configuration Directives
		 * --------------------------------------------------------------------------
		 * https://coldbox.ortusbooks.com/the-basics/routing/application-router#configuration-methods
		 */
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 */

		// A nice healthcheck route example
		route( "/healthcheck", function( event, rc, prc ){
			return "Ok!";
		} );

		// // API Authentication Routes
		// post( "/api/login", "Auth.login" );
		// post( "/api/logout", "Auth.logout" );
		// post( "/api/register", "Auth.register" );

		// // @app_routes@

		// Get Journal List
		get( '/api/journalList/',                  'journals.index' );
		OPTIONS( '/api/journalList/',              'journals.preflight' );

		// Search Journal
		get( '/api/journalSearch/:column/:value',     'journals.search' ); //FIX -- Working on this
		OPTIONS( '/api/journalSearch/:column/:value', 'journals.preflight' );

		// Get Journal
		get( '/api/journal/:id',                   'journals.getJournal' );
		OPTIONS( '/api/journal/:id',               'journals.preflight' );

		// Get Quotes
		get( '/api/quotes/',                       'quotes.index' );
		OPTIONS( '/api/quotes/',                   'journals.preflight' );

		// Get User Journals
		get( '/api/journals/:id/bookmarks',        'journals.getBookmarksFromJournal' );
		get( '/api/journals/:id/checklists',       'journals.getChecklistsFromJournal' );
		get( '/api/journals/:id/events',           'journals.getEventsFromJournal' );
		get( '/api/journals/:id/favorites',        'journals.getFavoritesFromJournal' ); //FIX
		get( '/api/journals/:id/goals',            'journals.getGoalsFromJournal' );
		get( '/api/journals/:id/notes',            'journals.getNotesFromJournal' );
		get( '/api/journals/:id/quotes',           'journals.getQuotesFromJournal' );
		get( '/api/journals/:id/todos',            'journals.getToDosFromJournal' );
		get( '/api/journals/:id/vocabulary',       'journals.getVocabularyFromJournal' ); //FIX

		// Other Journal
		get( '/api/journals/:id/TOC',               'journals.getTOC' );
		get( '/api/journals/:id',                   'journals.getUserJournals' );
		OPTIONS( '/api/journals/:id',               'journals.preflight' );

		// Conventions-Based Routing
		route( ":handler/:action?" ).end();
	}

}
