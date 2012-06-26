package com.knomedia.events
{
	import flash.events.Event;

	public class RegistrationServiceEvent extends Event
	{
		public static const ALL_SESSIONS_LOADED:String = "allSessionsLoaded";
		public static const AUTHENTICATION_COMPLETE:String = "authenticationComplete";
		public static const SERVICE_ERROR:String = "serviceError";

		private var _sessionData:Array;
		private var _userData:Object;

		public function RegistrationServiceEvent(type:String, sessionData:Array, userData:Object = null)
		{
			super(type,true,true);

			this._sessionData = sessionData;
			this._userData = userData;
		}

		public function get sessionData():Array
		{
			return _sessionData;
		}
		public function get userData():Object
		{
			return _userData;
		}

		public override function clone():Event
		{
			return new RegistrationServiceEvent(type,sessionData,userData);
		}

		public override function toString():String
		{
			return formatToString("RegistrationServiceEvent","sessionData", "userData");
		}
	}
}