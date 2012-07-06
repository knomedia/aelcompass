package com.knomedia.events
{
	import flash.events.Event;
	import com.knomedia.models.Session;

	public class SessionRequestEvent extends Event
	{
		public static const ADD:String = "add";
		public static const REMOVE:String = "remove";

		private var _session:Session;

		public function SessionRequestEvent(type:String, session:Session)
		{
			super(type,true,true);

			this._session = session;
		}

		public function get session():Session
		{
			return _session;
		}

		public override function clone():Event
		{
			return new SessionRequestEvent(type,session);
		}

		public override function toString():String
		{
			return formatToString("SessionRequestEvent","session");
		}
	}
}