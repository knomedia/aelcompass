package com.knomedia.models
{
	[RemoteClass(alias="com.knomedia.models.NewsModel")]
	public class NewsModel
	{
		public var heading:String;
		public var author:String;
		public var body:String;
		public var published:Date;
		
		public function NewsModel()
		{
		}
		
		static public function createFromObject( obj:Object ):NewsModel
		{
			var nw:NewsModel = new NewsModel();
			nw.heading = obj.heading;
			nw.author = obj.author;
			nw.body = obj.body;
			nw.published = parseDate( obj.published );
			
			return nw;
		}
		
		private static function parseDate( str : String ) : Date
		{
			var matches : Array = str.match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)/);
			
			var d : Date = new Date();
			
			d.setUTCFullYear(int(matches[1]), int(matches[2]) - 1, int(matches[3]));
			d.hours = int(matches[4]);
			d.minutesUTC = int(matches[5]);
			d.secondsUTC = int(matches[6]);
			return d;
		}
	}
}