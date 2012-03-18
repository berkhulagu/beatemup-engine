package org.bh.robotlegs
{
	import flash.display.DisplayObjectContainer;
	import flash.system.ApplicationDomain;
	
	import org.bh.robotlegs.events.DebugCharacterEvent;
	import org.bh.robotlegs.events.GameplayEvent;
	import org.bh.robotlegs.events.LevelLoadedEvent;
	import org.bh.robotlegs.events.ResourceEvent;
	import org.bh.robotlegs.events.SwitchToScreenEvent;
	import org.bh.robotlegs.events.UIEvent;
	import org.bh.robotlegs.mvc.controller.StartGameplayCommand;
	import org.bh.robotlegs.mvc.controller.StartupCommand;
	import org.bh.robotlegs.mvc.controller.debug.ToggleCharacterDebugCommand;
	import org.bh.robotlegs.mvc.model.ApplicationModel;
	import org.bh.robotlegs.mvc.model.CameraModel;
	import org.bh.robotlegs.mvc.model.DebugModel;
	import org.bh.robotlegs.mvc.model.LevelModel;
	import org.bh.robotlegs.mvc.model.PlayerStatsModel;
	import org.bh.robotlegs.mvc.model.ResourceModel;
	import org.bh.robotlegs.mvc.model.StateMachineModel;
	import org.bh.robotlegs.mvc.model.components.vo.ConfigurationVO;
	import org.bh.robotlegs.mvc.model.components.vo.PlayerStatsVO;
	import org.bh.robotlegs.mvc.view.ApplicationMediator;
	import org.bh.robotlegs.mvc.view.DebugMediator;
	import org.bh.robotlegs.mvc.view.DialogMediator;
	import org.bh.robotlegs.mvc.view.LevelMediator;
	import org.bh.robotlegs.mvc.view.MenuMediator;
	import org.bh.robotlegs.mvc.view.UIMediator;
	import org.bh.robotlegs.mvc.view.components.DebugView;
	import org.bh.robotlegs.mvc.view.components.DialogView;
	import org.bh.robotlegs.mvc.view.components.LevelView;
	import org.bh.robotlegs.mvc.view.components.MenuView;
	import org.bh.robotlegs.mvc.view.components.UIView;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	public class GrimBeaperContext extends Context
	{
		public function GrimBeaperContext(contextView:DisplayObjectContainer=null)
		{
			super(contextView);
		}
		
		/** override startup */
		override public function startup():void {
			// map models
			injector.mapSingleton(LevelModel);
			injector.mapSingleton(PlayerStatsModel);
			injector.mapSingleton(ApplicationModel);
			injector.mapSingleton(CameraModel)
			injector.mapSingleton(StateMachineModel)
			injector.mapSingleton(DebugModel);
			injector.mapSingleton(ResourceModel);
			
			// map views 
			
			mediatorMap.mapView( UIView, UIMediator);
			mediatorMap.mapView( DialogView, DialogMediator);
			mediatorMap.mapView( MenuView, MenuMediator);
			mediatorMap.mapView( DebugView, DebugMediator);
			mediatorMap.mapView( LevelView, LevelMediator);
			mediatorMap.mapView( GrimBeaper, ApplicationMediator );
			
			
			// map commands
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent, true);
			commandMap.mapEvent( GameplayEvent.START_GAME, StartGameplayCommand, GameplayEvent, false)
			commandMap.mapEvent( UIEvent.RETRY_CLICKED, StartGameplayCommand, UIEvent, false)
			commandMap.mapEvent( DebugCharacterEvent.TOGGLE_CHARACTER_DEBUG, ToggleCharacterDebugCommand, DebugCharacterEvent, false)
							
			super.startup()
		}
	}
}