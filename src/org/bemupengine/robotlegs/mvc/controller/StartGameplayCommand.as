package org.bemupengine.robotlegs.mvc.controller
{
	import org.bemupengine.robotlegs.mvc.model.ResourceModel;
	import org.robotlegs.mvcs.Command;

	public class StartGameplayCommand extends Command
	{
		[Inject]
		public var resource : ResourceModel;

		override public function execute() : void
		{
			// load the 1st level
			resource.loadLevel( 1 );
		}
	}
}