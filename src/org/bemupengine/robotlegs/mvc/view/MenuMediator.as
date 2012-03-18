package org.bemupengine.robotlegs.mvc.view
{
	import flash.display.MovieClip;
	import org.bemupengine.robotlegs.consts.MenuConsts;
	import org.bemupengine.robotlegs.consts.ScreenConsts;
	import org.bemupengine.robotlegs.events.GameplayEvent;
	import org.bemupengine.robotlegs.events.LevelLoadedEvent;
	import org.bemupengine.robotlegs.events.MenuEvent;
	import org.bemupengine.robotlegs.events.ResourceEvent;
	import org.bemupengine.robotlegs.events.SwitchToScreenEvent;
	import org.bemupengine.robotlegs.mvc.model.ResourceModel;
	import org.bemupengine.robotlegs.mvc.view.components.MenuView;
	import org.robotlegs.mvcs.Mediator;


	/** mediator for menu */
	public class MenuMediator extends Mediator
	{
		[Inject]
		public var view : MenuView;
		[Inject]
		public var resource : ResourceModel;

		public function MenuMediator()
		{
			super();
		}

		override public function onRegister() : void
		{
			trace( "OnRegister MenuMediator" );

			eventMap.mapListener( resource.eventDispatcher, ResourceEvent.LOADED + "|menu", onMenuLoaded, ResourceEvent );
			addContextListener( SwitchToScreenEvent.SWITCH, onSwitchScreen, SwitchToScreenEvent );
			addContextListener( LevelLoadedEvent.LOADED, hideMenu, LevelLoadedEvent );
		}

		/** menu is loaded, it should be displayed */
		private function onMenuLoaded( evt : ResourceEvent ) : void
		{
			var tMainMenu : MovieClip = resource.getMovieClipFromBatch( "menu", "menu" );
			view.addMenu( tMainMenu );
			view.displayMenu( ScreenConsts.MAIN_MENU );

			// listen to view for clicks
			addViewListener( MenuEvent.CLICKED, onClickedOnMenuButton );
			// AUTOSTART
			// dispatch(new GameplayEvent(GameplayEvent.START_GAME))
		}

		private function hideMenu( evt : LevelLoadedEvent ) : void
		{
			view.visible = false;
		}

		private function onSwitchScreen( evt : SwitchToScreenEvent ) : void
		{
			view.displayMenu( evt.screenId );
		}

		private function onClickedOnMenuButton( evt : MenuEvent ) : void
		{
			switch(evt.itemName)
			{
				case MenuConsts.BUTTON_START:
					// tell the application to start the game
					view.removeEventListener( MenuEvent.CLICKED, onClickedOnMenuButton );
					trace( "MenuConsts.BUTTON_START" );
					dispatch( new GameplayEvent( GameplayEvent.START_GAME ) );
					break;
				case MenuConsts.BUTTON_OPTIONS:
					break;
			}
		}
	}
}