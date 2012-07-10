package com.knomedia.models
{
	import com.knomedia.events.SessionCacheEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	public class SessionCollection extends EventDispatcher
	{
		private var _uniqueDays:ArrayCollection;
		private var _selectedDay:String;
		private var _selectedTime:String;
		
		private var _allSessions:Array;
		private var dict:Dictionary;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function SessionCollection(target:IEventDispatcher=null)
		{
			super(target);
			createSortDictionary();
		}
		
		[Bindable(event="propertyChange")]
		public function get uniqueDays():ArrayCollection
		{
			return _uniqueDays;
		}
		
		public function getUniqueTimesForDay( day:String ):ArrayCollection
		{
			this.selectedDay = day;
			
			return calculateUniqueTimes()
		}
		
		private function calculateUniqueTimes():ArrayCollection
		{
			var foundTimes:Array = [];
			for each(var session:Session in allSessions)
			{
				if ( session.day == _selectedDay && foundTimes.indexOf( session.start ) == -1 )
				{
					foundTimes.push( session.start );
				}
			}
			return new ArrayCollection( foundTimes );
		}
		
		public function getSessionsForDayTime( day:String, time:String ):ArrayCollection
		{
			_selectedDay = day;
			_selectedTime = time;
			var foundSessions:Array = [];
			for each(var sess:Session in allSessions)
			{
				if ( sess.day == _selectedDay &&
					 sess.start == _selectedTime )
				{
					foundSessions.push( sess );
				}
			}
			return new ArrayCollection( foundSessions );
		}


		public function get selectedDay():String
		{
			return _selectedDay;
		}

		public function set selectedDay(value:String):void
		{
			_selectedDay = value;
		}

		public function get selectedTime():String
		{
			return _selectedTime;
		}

		public function set selectedTime(value:String):void
		{
			_selectedTime = value;
		}

		public function get allSessions():Array
		{
			return _allSessions;
		}

		public function set allSessions(value:Array):void
		{
			//determine if data is different before spending time processing
			_allSessions = value;
			calculateUniqueDays();
			dispatcher.dispatchEvent( new SessionCacheEvent( SessionCacheEvent.UPDATED ) );
		}
		
		private function calculateUniqueDays( ):void
		{
			var foundValues:Array = [];
			
			for each(var session:Session in _allSessions)
			{
				if ( foundValues.indexOf( session.day ) == -1 && session.day != null )
				{
					foundValues.push( session.day );
				}
			}
			foundValues.sort( compareDayStrings );
			_uniqueDays = new ArrayCollection( foundValues );
		}
		
		private function createSortDictionary():void
		{
			dict = new Dictionary();
			dict[ "sunday" ] = 0;
			dict[ "monday" ] = 1;
			dict[ "tuesday" ] = 2;
			dict[ "wednesday" ] = 3;
			dict[ "thursday" ] = 4;
			dict[ "friday" ] = 5;
			dict[ "saturday" ] = 6;
		}
		
		private function compareDayStrings( a:Object, b:Object ):int
		{
			var aIndex:int = dict[ (a as String).toLowerCase() ];
			var bIndex:int = dict[ (b as String).toLowerCase() ];
			
			var difference:int = aIndex - bIndex;
			var direction:int =  ( difference < 0 )?  -1 : 1;
			return direction;
			
		}
		
		public function getSessionById( id:String ):Session
		{
			var reqSession:Session;
			for each(var sess:Session in allSessions)
			{
				if (sess.sessionId == id)
				{
					reqSession = sess;
					break;
				}
			}
			return reqSession;
		}

	}
}