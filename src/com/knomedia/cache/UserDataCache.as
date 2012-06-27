package com.knomedia.cache
{
	import flash.events.IEventDispatcher;
	
	public class UserDataCache extends AbstractCache
	{
		public function UserDataCache(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function get lastUpdate():Date
		{
			return so.getValue( "lastUserDataUpdate", new Date(500) );
		}
		public function set lastUpdate( value:Date ):void
		{
			so.setValue( "lastUserDataUpdate", value );
		}
		

		public function get registrationId():String
		{
			return so.getValue( "registrationId", "" );
		}

		public function set registrationId(value:String):void
		{
			so.setValue( "registrationId", value );
		}
		
		public function set userData( value:Object ):void
		{
			so.setValue( "userData", value );
		}
		
		public function get userData():Object
		{
			return so.getValue( "userData", {} );
		}

		
	}
}