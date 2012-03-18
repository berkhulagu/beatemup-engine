package org.bemupengine.robotlegs.mvc.controller
{
	import org.bemupengine.robotlegs.mvc.model.ApplicationModel;
	import org.bemupengine.robotlegs.mvc.model.ResourceModel;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Command;

	public class StartupCommand extends Command
	{
		[Inject]
		public var event : ContextEvent;
		[Inject]
		public var application : ApplicationModel;
		[Inject]
		public var resource : ResourceModel;

		override public function execute() : void
		{
			application.width = 640;
			application.height = 480;

			// load the menu
			resource.initialize();
			resource.loadConfig();
			resource.loadMenu();
		}
	}
}