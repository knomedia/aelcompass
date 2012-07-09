package com.knomedia.factories
{
	import com.knomedia.cache.UserDataCache;

	public class UserDataFactory
	{
		public function UserDataFactory()
		{
		}
		
		public static function createUserDataFromJSON( json:String ):Object
		{
			var returnedData:Object
			try
			{
				returnedData = JSON.parse( json );
			} 
			catch(error:Error) 
			{
				returnedData = { userData: [{}] };				
			}
			return returnedData.userData[0] as Object;
		}
		
		public static function createJSONFromUserData( obj:Object ):String
		{
			return JSON.stringify( obj );
		}
	}
}