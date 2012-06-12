package com.knomedia.services
{
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.models.Session;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	
	[Event(name="allSessionsLoaded", type="com.knomedia.events.RegistrationServiceEvent")]
	public class RegistrationService extends EventDispatcher
	{
		
		private var _srv:HTTPService;
		
		public function RegistrationService(target:IEventDispatcher=null)
		{
		 	super(target);
			_srv = new HTTPService();
			_srv.url = ServiceParams.SERVICE_GATEWAY;
			_srv.resultFormat = "text";
		}
		
		public function getAllPresentationData():void
		{
			var params:ServiceParams = new ServiceParams();
			params.ws_action = ServiceActions.GET_ALL_PRESENTATION_DATA;
			params.ws_id = params.test_ws_id;
			params.registration_id = params.test_registration_id;
			_srv.addEventListener( ResultEvent.RESULT, onResult);
			
			_srv.send( params );
		}

		private function onResult(event:ResultEvent):void
		{
			var allSessions:Object =  JSON.parse( String(event.result) );
			var actualSessions:Array = [];
			for each(var session:Object in allSessions.sessions as Array)
			{
				actualSessions.push( Session.sessionFromObject( session ) );		
			}
			
			var evt:RegistrationServiceEvent = new RegistrationServiceEvent( RegistrationServiceEvent.ALL_SESSIONS_LOADED, actualSessions );
			dispatchEvent( evt );
		}
	}
}