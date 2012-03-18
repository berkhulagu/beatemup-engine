package org.bemupengine.robotlegs
{
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	import org.bemupengine.robotlegs.events.DebugCharacterEvent;
	import org.bemupengine.robotlegs.events.GameplayEvent;
	import org.bemupengine.robotlegs.events.LevelLoadedEvent;
	import org.bemupengine.robotlegs.events.ResourceEvent;
	import org.bemupengine.robotlegs.events.SwitchToScreenEvent;
	import org.bemupengine.robotlegs.events.UIEvent;
	import org.bemupengine.robotlegs.mvc.controller.StartGameplayCommand;
	import org.bemupengine.robotlegs.mvc.controller.StartupCommand;
	import org.bemupengine.robotlegs.mvc.controller.debug.ToggleCharacterDebugCommand;
	import org.bemupengine.robotlegs.mvc.model.ApplicationModel;
	import org.bemupengine.robotlegs.mvc.model.CameraModel;
	import org.bemupengine.robotlegs.mvc.model.DebugModel;
	import org.bemupengine.robotlegs.mvc.model.LevelModel;
	import org.bemupengine.robotlegs.mvc.model.PlayerStatsModel;
	import org.bemupengine.robotlegs.mvc.model.ResourceModel;
	import org.bemupengine.robotlegs.mvc.model.StateMachineModel;
	import org.bemupengine.robotlegs.mvc.model.components.vo.ConfigurationVO;
	import org.bemupengine.robotlegs.mvc.model.components.vo.PlayerStatsVO;
	import org.bemupengine.robotlegs.mvc.view.ApplicationMediator;
	import org.bemupengine.robotlegs.mvc.view.DebugMediator;
	import org.bemupengine.robotlegs.mvc.view.DialogMediator;
	import org.bemupengine.robotlegs.mvc.view.LevelMediator;
	import org.bemupengine.robotlegs.mvc.view.MenuMediator;
	import org.bemupengine.robotlegs.mvc.view.UIMediator;
	import org.bemupengine.robotlegs.mvc.view.components.DebugView;
	import org.bemupengine.robotlegs.mvc.view.components.DialogView;
	import org.bemupengine.robotlegs.mvc.view.components.LevelView;
	import org.bemupengine.robotlegs.mvc.view.components.MenuView;
	import org.bemupengine.robotlegs.mvc.view.components.UIView;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;


	public class BemupEngineContext extends Context
	{
		public function BemupEngineContext( contextView : DisplayObjectContainer = null )
		{
			super( contextView );
		}

		/** override startup */
		override public function startup() : void
		{
			// map models
			injector.mapSingleton( LevelModel );
			injector.mapSingleton( PlayerStatsModel );
			injector.mapSingleton( ApplicationModel );
			injector.mapSingleton( CameraModel );
			injector.mapSingleton( StateMachineModel );
			injector.mapSingleton( DebugModel );
			injector.mapSingleton( ResourceModel );

			// map views

			mediatorMap.mapView( UIView, UIMediator );
			mediatorMap.mapView( DialogView, DialogMediator );
			mediatorMap.mapView( MenuView, MenuMediator );
			mediatorMap.mapView( DebugView, DebugMediator );
			mediatorMap.mapView( LevelView, LevelMediator );
			mediatorMap.mapView( BemupEngine, ApplicationMediator );

			// map commands
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent, true );
			commandMap.mapEvent( GameplayEvent.START_GAME, StartGameplayCommand, GameplayEvent, false );
			commandMap.mapEvent( UIEvent.RETRY_CLICKED, StartGameplayCommand, UIEvent, false );
			commandMap.mapEvent( DebugCharacterEvent.TOGGLE_CHARACTER_DEBUG, ToggleCharacterDebugCommand, DebugCharacterEvent, false );

			super.startup();
		}
	}
}