package com.knomedia.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	public class SessionCollection extends EventDispatcher
	{
		private var _uniqueDays:ArrayCollection;
		private var _selectedDay:String;
		private var _selectedTime:String;
		
		private var _allSessions:Array;
		
		public function SessionCollection(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function getUniqueDays():ArrayCollection
		{
			return null;
		}
		
		public function getUniqueTimesForDay( day:String ):ArrayCollection
		{
			return null;
		}
		
		public function getSessionsForDayTime( day:String, time:String ):ArrayCollection
		{
			return null;
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
			_allSessions = value;
		}

	}
}