package com.knomedia.events
{
	import flash.events.Event;

	public class SessionCacheEvent extends Event
	{
		public static const UPDATED:String = "updated";

		public function SessionCacheEvent(type:String)
		{
			super(type,true,true);
		}

		public override function clone():Event
		{
			return new SessionCacheEvent(type);
		}

		public override function toString():String
		{
			return formatToString("SessionCacheEvent");
		}
	}
}