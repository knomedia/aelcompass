package com.knomedia.commands
{
	import com.knomedia.events.SessionSwapEvent;
	import com.knomedia.models.NavModel;
	import com.knomedia.models.Session;
	import com.knomedia.views.ConfirmSwapView;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	public class ConfirmSessionSwapCommand implements IEventAwareCommand
	{
		private var _sessionToAdd:Session;
		private var _sessionToRemove:Session;
		
		[Inject]
		public var navModel:NavModel;
		
		public function ConfirmSessionSwapCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			var evt:SessionSwapEvent = SessionSwapEvent( value );
			_sessionToAdd = evt.sessionToAdd;
			_sessionToRemove = evt.sessionToRemove;
		}
		
		public function execute():void
		{
			navModel.navigator.activeView.navigator.pushView( ConfirmSwapView, {add: _sessionToAdd, remove: _sessionToRemove} );
		}
	}
}