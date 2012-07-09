package com.knomedia.events
{
	import com.knomedia.models.Session;
	
	import flash.events.Event;

	public class SessionSwapEvent extends Event
	{
		public static const SWAP_SESSIONS:String = "swapSessions";
		public static const SINGLE_ADD:String = "singleAdd";
		public static const CONFIRMED_SWAP:String = "confirmedSwap";
		public static const SUCCESS:String = "success";
		public static const FAIL:String = "fail";
		public static const FAULT:String = "fault";

		private var _sessionToAdd:Session;
		private var _sessionToRemove:Session;

		public function SessionSwapEvent(type:String, sessionToAdd:Session, sessionToRemove:Session = null)
		{
			super(type,true,true);

			this._sessionToAdd = sessionToAdd;
			this._sessionToRemove = sessionToRemove;
		}

		public function get sessionToAdd():Session
		{
			return _sessionToAdd;
		}

		public function get sessionToRemove():Session
		{
			return _sessionToRemove;
		}

		public override function clone():Event
		{
			return new SessionSwapEvent(type,sessionToAdd,sessionToRemove);
		}

		public override function toString():String
		{
			return formatToString("SessionSwapEvent","sessionToAdd","sessionToRemove");
		}
	}
}