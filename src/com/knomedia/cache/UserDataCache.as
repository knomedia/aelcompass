package com.knomedia.cache
{
	import flash.events.IEventDispatcher;
	
	public class UserDataCache extends AbstractCache
	{
		public function UserDataCache(target:IEventDispatcher=null)
		{
			super(target);
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