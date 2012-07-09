package com.knomedia.commands
{
	import com.knomedia.events.AppEvent;
	import com.knomedia.models.NavModel;
	import com.knomedia.views.ErrorView;
	
	import flash.events.Event;
	
	import org.swizframework.utils.commands.IEventAwareCommand;
	
	import spark.components.ViewNavigator;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.SlideViewTransitionMode;
	import spark.transitions.ViewTransitionDirection;
	
	public class ShowGlobalErrorCommand implements IEventAwareCommand
	{
		private var message:String;
		
		[Inject]
		public var navModel:NavModel;
		
		public function ShowGlobalErrorCommand()
		{
		}
		
		public function set event(value:Event):void
		{
			message = AppEvent( value ).data as String;
		}
		
		public function execute():void
		{
			var vn:ViewNavigator = navModel.navigator.selectedNavigator as ViewNavigator;
			var trans:SlideViewTransition = new SlideViewTransition();
			trans.mode = SlideViewTransitionMode.UNCOVER;
			trans.direction = ViewTransitionDirection.DOWN;
			vn.pushView( ErrorView, message, null, trans );
		}
	}
}