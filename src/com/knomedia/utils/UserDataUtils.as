package com.knomedia.utils
{
	import com.knomedia.cache.UserDataCache;
	import com.knomedia.models.Session;

	public class UserDataUtils
	{
		public function UserDataUtils()
		{
		}
		
		public static function updateSessionsWithUserData( sessions:Array, userCache:UserDataCache ):Array
		{
			var ids:Array = createIdArray( userCache );
			for each( var session:Session in sessions)
			{
				var index:int = ids.indexOf( session.sessionId );
				if (index != -1)
				{
					session.userAttending = true;
					//trace("Attending: " + session.day + " " + session.start + " " + session.name );
				} else {
					session.userAttending = false;
				}
			}
			return sessions;
		}
		
		private static function createIdArray( userCache:UserDataCache ):Array
		{
			var ids:Array = [];
			for( var prop:* in userCache.userData)
			{
				if (userCache.userData[ prop ] =="on" )
				{
					ids.push( prop )
				}
			}
			return ids;
		}
	}
}