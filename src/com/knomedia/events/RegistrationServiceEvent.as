package com.knomedia.events
{
	import flash.events.Event;

	public class RegistrationServiceEvent extends Event
	{
		public static const ALL_SESSIONS_LOADED:String = "allSessionsLoaded";
		public static const AUTHENTICATION_COMPLETE:String = "authenticationComplete";
		public static const AUTHENTICATION_FAILED:String = "authenticationFailed"
		public static const SERVICE_ERROR:String = "serviceError";

		private var _sessionData:Array;
		private var _userData:Object;
		private var _registrationId:String;

		public function RegistrationServiceEvent(type:String, sessionData:Array, userData:Object = null, registrationId:String = "")
		{
			super(type,true,true);

			this._sessionData = sessionData;
			this._userData = userData;
			this._registrationId = registrationId;
		}

		public function get sessionData():Array
		{
			return _sessionData;
		}
		public function get userData():Object
		{
			return _userData;
		}
		public function get registrationId():String
		{
			return _registrationId;
		}

		public override function clone():Event
		{
			return new RegistrationServiceEvent(type,sessionData,userData,registrationId);
		}

		public override function toString():String
		{
			return formatToString("RegistrationServiceEvent","sessionData", "userData", "registrationId");
		}
	}
}