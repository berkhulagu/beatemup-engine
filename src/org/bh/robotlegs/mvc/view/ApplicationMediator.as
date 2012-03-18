package org.bh.robotlegs.mvc.view
{
	import org.bh.robotlegs.events.SwitchToScreenEvent;
	import org.bh.robotlegs.mvc.view.components.LevelView;
	import org.bh.robotlegs.mvc.view.components.UIView;
	import org.bh.robotlegs.mvc.view.components.MenuView;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/** mediator for the whole application */
	public class ApplicationMediator extends Mediator
	{
		[Inject]
		public var view:GrimBeaper
		
		/** constructor */
		public function ApplicationMediator()
		{
			super();
		}
		
		override public function onRegister():void {		
			trace("OnRegister applicationmediator")
			
			view.createChildren()
		}
		
	}
}