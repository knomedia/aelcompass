package com.knomedia.cache
{
	import flash.events.IEventDispatcher;
	
	public class SessionCache extends AbstractCache
	{
		public function SessionCache(target:IEventDispatcher=null)
		{
			super(target);
		}
		

		
		public function get lastUpdated():Date
		{
			return so.getValue( "lastSessionUpdate", new Date() );
		}
		
		public function set lastUpdated(value:Date):void
		{
			so.setValue( "lastSessionUpdate", value );
		}
		
		public function getAllSessions():Array
		{
			return so.getValue( "allSessions", [] );
		}
		
		public function setAllSessions( value:Array ):void
		{
			// determine if data is different before storing
			so.setValue( "allSessions", value );
		}
		
		
	}
}