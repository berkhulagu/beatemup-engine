package org.bh.robotlegs.mvc.view
{
	import org.bh.robotlegs.events.DebugEvent;
	import org.bh.robotlegs.mvc.model.components.character.CharacterBean;
	import org.bh.robotlegs.mvc.view.components.DebugView;
	import org.robotlegs.mvcs.Mediator;
	
	public class DebugMediator extends Mediator
	{
		[Inject]
		public var view:DebugView
		
		public function DebugMediator()
		{
			super();
		}
		
		override public function onRegister():void {
			addContextListener( DebugEvent.TOGGLE_SHOW,  toggleVisibility, DebugEvent);
			addContextListener( DebugEvent.WRITE,  onNewDebugMessage, DebugEvent);
			addContextListener( DebugEvent.APPEND, onNewDebugMessage, DebugEvent);
		}

		private function toggleVisibility(evt:DebugEvent):void {
			view.toogleVisibility();
		}
		
		private function onNewDebugMessage(evt:DebugEvent):void {
			view.write(evt.text);
		}
		

	}
}