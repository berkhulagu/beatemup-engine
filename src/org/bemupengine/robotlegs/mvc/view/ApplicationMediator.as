package org.bemupengine.robotlegs.mvc.view
{
	import org.robotlegs.mvcs.Mediator;

	/** mediator for the whole application */
	public class ApplicationMediator extends Mediator
	{
		[Inject]
		public var view : BemupEngine;

		/** constructor */
		public function ApplicationMediator()
		{
			super();
		}

		override public function onRegister() : void
		{
			trace( "OnRegister applicationmediator" );

			view.createChildren();
		}
	}
}