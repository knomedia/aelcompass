package com.knomedia.factories
{
	public class UserDataFactory
	{
		public function UserDataFactory()
		{
		}
		
		public static function createUserDataFromJSON( json:String ):Object
		{
			var returnedData:Object = JSON.parse( json );
			return returnedData.userData[0] as Object;
		}
	}
}