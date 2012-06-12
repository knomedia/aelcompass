package com.knomedia.events
{
	import flash.events.Event;

	public class RegistrationServiceEvent extends Event
	{
		public static const ALL_SESSIONS_LOADED:String = "allSessionsLoaded";

		private var _data:Array;

		public function RegistrationServiceEvent(type:String, data:Array)
		{
			super(type,true,true);

			this._data = data;
		}

		public function get data():Array
		{
			return _data;
		}

		public override function clone():Event
		{
			return new RegistrationServiceEvent(type,data);
		}

		public override function toString():String
		{
			return formatToString("RegistrationServiceEvent","data");
		}
	}
}