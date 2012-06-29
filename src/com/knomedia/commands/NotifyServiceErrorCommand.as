package com.knomedia.commands
{
	import com.knomedia.events.RegistrationServiceEvent;
	import com.knomedia.models.NavModel;
	import com.knomedia.views.ErrorView;
	
	import flash.events.Event;
	
	import mx.messaging.messages.IMessage;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	import spark.components.TabbedViewNavigator;
	import spark.components.ViewNavigator;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	import spark.transitions.ViewTransitionDirection;
	
	public class NotifyServiceErrorCommand implements IEventAwareCommand
	{
		[Inject]
		public var appNav:NavModel;
		
		private var message:IMessage;
		public function NotifyServiceErrorCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			message = IMessage( RegistrationServiceEvent( value ).userData );
		}
		
		public function execute():void
		{
			trace( message['faultString'] );
			var vn:ViewNavigator = appNav.navigator.selectedNavigator as ViewNavigator;
			var trans:SlideViewTransition = new SlideViewTransition();
			trans.mode = SlideViewTransitionMode.UNCOVER;
			trans.direction = ViewTransitionDirection.DOWN;
			vn.pushView( ErrorView, message, null, trans );
		}
	}
}