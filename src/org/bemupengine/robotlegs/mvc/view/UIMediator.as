package org.bemupengine.robotlegs.mvc.view
{
	import flash.display.MovieClip;
	import org.bemupengine.robotlegs.consts.ResourceConsts;
	import org.bemupengine.robotlegs.events.LevelLoadedEvent;
	import org.bemupengine.robotlegs.events.UIEvent;
	import org.bemupengine.robotlegs.mvc.model.ResourceModel;
	import org.bemupengine.robotlegs.mvc.view.components.UIView;
	import org.robotlegs.mvcs.Mediator;


	/** mediator for HUD */
	public class UIMediator extends Mediator
	{
		[Inject]
		public var view : UIView;
		[Inject]
		public var resource : ResourceModel;

		public function UIMediator()
		{
			super();
		}

		override public function onRegister() : void
		{
			trace( "OnRegister HUDMediator" );

			eventMap.mapListener( resource.eventDispatcher, LevelLoadedEvent.LOADED, displayUI, LevelLoadedEvent );
			addContextListener( UIEvent.SET_DODGE, updateDodge, UIEvent );
			addContextListener( UIEvent.SET_HEALTH, updateHealth, UIEvent );
			addContextListener( UIEvent.SET_SCORE, updateScore, UIEvent );

			addContextListener( UIEvent.PLAYER_DIED, handlePlayerDeath, UIEvent );
		}

		private function handlePlayerDeath( evt : UIEvent ) : void
		{
			view.displayPlayerDeath();
		}

		private function displayUI( evt : LevelLoadedEvent ) : void
		{
			var tUI : MovieClip = resource.getMovieClipFromBatch( ResourceConsts.BATCH_MENU, "UI" );
			view.initialize( tUI );
		}

		private function updateDodge( evt : UIEvent ) : void
		{
		}

		private function updateHealth( evt : UIEvent ) : void
		{
			view.health = evt.param as int;
		}

		private function updateScore( evt : UIEvent ) : void
		{
			var tScore : int = evt.param as int;

			if (tScore < 0)
				tScore = 0;
			view.score = tScore;
		}
	}
}