package com.knomedia.models
{
	[RemoteClass(alias="com.knomedia.models")]
	public class Session
	{
		public var head:String;
		public var day:String;
		public var id:String;
		public var sortId:int;
		public var count:int;
		public var name:String;
		public var track:String;
		public var type:String;
		public var info:String;
		public var limit:int;
		public var sessionId:String;
		public var preReq:String;
		public var status:String;
		public var start:String;
		public var end:String;
		
		public var userAttending:Boolean = false;
		
		public function Session()
		{
		}
		
		public function get countStats():String
		{
			return count + " of " + limit + " seats taken";
		}
		
		public static function sessionFromObject( obj:Object ):Session
		{
			var session:Session = new Session();
			session.head = obj.se_head;
			session.day = obj.se_day_1;
			session.id = obj.se_id;
			session.sortId = obj.sort_id;
			session.count = obj.se_count;
			session.name = obj.se_name;
			session.track = obj.se_track;
			session.type = obj.se_type;
			session.info =  cleanUpInfo( obj.se_more_info, session.name);
			session.limit = obj.se_limit;
			session.sessionId = obj.se_session_id;
			session.preReq = obj.se_prereq;
			session.status = obj.se_status;
			session.start = obj.se_start_1;
			session.end = obj.se_end_1;
			
			return session;
		}
		
		private static function cleanUpInfo( info:Object, name:String):String
		{
			var infoString:String = ( info == null )? "<p>" + name + "<br />Details to follow...</p>" : String(info);
			if ( infoString != "" && true)
			{
				// remove line breaks
				var patrn:RegExp = new RegExp("\r\n", "g");
				infoString = infoString.replace( patrn, "");
				// remove tabs
				patrn = new RegExp("\t", "g");
				infoString = infoString.replace( patrn, "" );
				//trace(infoString);
				// remove name
				patrn = new RegExp( "\<b>.*?</b>", "i");
				infoString = infoString.replace(patrn, "");
				
				// Pulling intro <p><br /> tags w or w/o a space
				patrn = new RegExp("\<p>( *|)<br( |)/>( *|)", "is");
				infoString = infoString.replace(patrn, "");
				
				// pull last </p> tag
				patrn = new RegExp("\</p>", "i");
				infoString = infoString.replace( patrn, "" );
				
				// replace <br /> with \n\n
				patrn = new RegExp("\<br( |)/>", "gi");
				infoString = infoString.replace( patrn, "<br /><br />");
				//trace(infoString);
				
				infoString = "<p>" + infoString + "</p>";
			}
			return infoString;
		}
	}
}