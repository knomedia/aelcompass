package com.knomedia.services
{
	import com.adobe.protocols.dict.events.ErrorEvent;
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.events.SettingsEvent;
	import com.knomedia.factories.UserDataFactory;
	import com.knomedia.models.Session;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	
	public class RegistrationService extends EventDispatcher
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private var _srv:HTTPService;
		
		private var _registrationId:String;
		
		public function RegistrationService(target:IEventDispatcher=null)
		{
		 	super(target);
			_srv = new HTTPService();
			_srv.requestTimeout = 20;
			//_srv.showBusyCursor = true;
			_srv.url = ServiceParams.SERVICE_GATEWAY;
			_srv.resultFormat = "text";
			_srv.addEventListener(  FaultEvent.FAULT, onFault);
			
		}

		
		// ----------------------------------------------------------
		//					ERROR HANDLING
		// ----------------------------------------------------------
		private function onFault(event:FaultEvent):void
		{
			trace("service fault");
			dispatcher.dispatchEvent( new RegistrationServiceEvent( RegistrationServiceEvent.SERVICE_ERROR, null, event.message ));
		}
		
		
		// ----------------------------------------------------------
		//					GET ALL PRESENTATION DATA
		// ----------------------------------------------------------
		
		public function getAllPresentationData():void
		{
			var params:ServiceParams = new ServiceParams();
			params.ws_action = ServiceActions.GET_ALL_PRESENTATION_DATA;
			params.ws_id = params.test_ws_id;
			params.registration_id = params.test_registration_id;
			_srv.addEventListener( ResultEvent.RESULT, onAllPresentationDataLoaded);
			
			_srv.send( params );
		}

		private function onAllPresentationDataLoaded(event:ResultEvent):void
		{
			_srv.removeEventListener( ResultEvent.RESULT, onAllPresentationDataLoaded );
			var allSessions:Object =  JSON.parse( String(event.result) );
			var actualSessions:Array = [];
			for each(var session:Object in allSessions.sessions as Array)
			{
				actualSessions.push( Session.sessionFromObject( session ) );		
			}
			
			var evt:RegistrationServiceEvent = new RegistrationServiceEvent( RegistrationServiceEvent.ALL_SESSIONS_LOADED, actualSessions );
			dispatcher.dispatchEvent( evt );
		}
		
		// ----------------------------------------------------------
		//					AUTHENTICATE USER
		// ----------------------------------------------------------
		
		public function authenticateUser( registrationId:String ):void
		{
			_registrationId = registrationId;
			
			var params:ServiceParams = new ServiceParams();
			params.ws_action = ServiceActions.AUTHENTICATE_USER;
			params.ws_id = params.test_ws_id;
			params.registration_id = _registrationId;
			_srv.addEventListener( ResultEvent.RESULT, onAuthenticationResult);
			_srv.send( params );
		}

		private function onAuthenticationResult(event:ResultEvent):void
		{
			_srv.removeEventListener( ResultEvent.RESULT, onAuthenticationResult );
			var userData:Object = UserDataFactory.createUserDataFromJSON( event.result as String );
			var evt:RegistrationServiceEvent;
			if ( isValidUserData( userData ) )
			{
				evt = new RegistrationServiceEvent(RegistrationServiceEvent.AUTHENTICATION_COMPLETE, null, userData, _registrationId );
			} else {
				evt = new RegistrationServiceEvent( RegistrationServiceEvent.AUTHENTICATION_FAILED, null, userData, _registrationId );
			}
			dispatcher.dispatchEvent( evt );
			_registrationId = "";
		}
		
		private function isValidUserData( userData:Object ):Boolean
		{
			var ok:Boolean = false;
			if ( userData.hasOwnProperty( "last_name" ) )
			{
				ok = true;
			}
			return ok;
		}
		
		// ----------------------------------------------------------
		//					UPDATE REGISTRATION
		// ----------------------------------------------------------
		public function updateUserData( data:Object, registrationId:String ):void
		{
			
			var userData:String = UserDataFactory.createJSONFromUserData( data );
			_srv.addEventListener( ResultEvent.RESULT, onUpdateUserData);
			_registrationId = registrationId; 
			var params:ServiceParams = new ServiceParams();
			params.ws_action = ServiceActions.CHANGE_REGISTRATION;
			params.ws_id = params.test_ws_id;
			params.registration_id = _registrationId;
			params = addAllUserData( data, params );
			
			_srv.send( params );
		}
		private function dumpParams( params:ServiceParams ):void
		{
			for( var prop:* in params)
			{
				trace( "" + prop + ": " + params[prop] );
			}
			trace("ws_action: " + params.ws_action );
			trace("ws_id: " + params.ws_id);
			trace("registration_id: " + params.registration_id );
		}
		private function addAllUserData( data:Object, params:ServiceParams):ServiceParams
		{
			for(var prop:* in data)
			{
				params[prop] = data[prop];
			}
			return params;
		}

		private function onUpdateUserData(event:ResultEvent):void
		{
			_srv.removeEventListener(ResultEvent.RESULT, onUpdateUserData );
			_registrationId = "";
			var result:Object = JSON.parse( event.result as String);
			/*for( var prop:* in result)
			{
				if (!prop is Array)
				{
					trace(prop + ": " + result[prop]);
					
				}
				if (result[prop] == "on")
				{
				}
			}*/
			
			trace("RegistrationService: userDataUpdateComplete refreshing all data");
			dispatcher.dispatchEvent( new SettingsEvent( SettingsEvent.REFRESH ) );
			
		}
	}
}