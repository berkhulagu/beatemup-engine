package org.bh.robotlegs.mvc.controller
{
	import org.bh.robotlegs.consts.ResourceConsts;
	import org.bh.robotlegs.consts.ScreenConsts;
	import org.bh.robotlegs.events.ResourceEvent;
	import org.bh.robotlegs.events.SwitchToScreenEvent;
	import org.bh.robotlegs.mvc.model.ApplicationModel;
	import org.bh.robotlegs.mvc.model.PlayerStatsModel;
	import org.bh.robotlegs.mvc.model.ResourceModel;
	import org.bh.robotlegs.mvc.model.components.vo.RequestedLibraryVO;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Command;
	
	public class StartupCommand extends Command
	{
		[Inject]
		public var event:ContextEvent
		
		[Inject]
		public var application:ApplicationModel
		
		[Inject]
		public var resource:ResourceModel;
		
		override public function execute():void
		{
			application.width = 640;
			application.height= 480;
			
			// load the menu
			resource.initialize()
			resource.loadConfig();
			resource.loadMenu();
		}
		
		
	}
}