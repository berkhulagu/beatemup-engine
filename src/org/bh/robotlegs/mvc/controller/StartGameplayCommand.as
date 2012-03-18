package org.bh.robotlegs.mvc.controller
{
	import org.bh.robotlegs.events.GameplayEvent;
	import org.bh.robotlegs.mvc.model.ResourceModel;
	import org.robotlegs.mvcs.Command;
	
	public class StartGameplayCommand extends Command
	{
		[Inject]
		public var resource:ResourceModel
		
		override public function execute():void
		{
			// load the 1st level
			resource.loadLevel(1);
		}
	}
}