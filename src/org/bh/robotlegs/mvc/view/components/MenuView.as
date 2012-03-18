package org.bh.robotlegs.mvc.view.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import org.bh.robotlegs.consts.MenuConsts;
	import org.bh.robotlegs.consts.ScreenConsts;
	import org.bh.robotlegs.events.MenuEvent;
	import org.bh.robotlegs.mvc.model.ResourceModel;
	import org.bh.robotlegs.mvc.view.menu.MenuButton;
	
	public class MenuView extends MovieClip
	{
		private var _menu:MovieClip
		private var _currentScreen:int;
		
		private var initList:Dictionary = new Dictionary()
		
		public function MenuView()
		{
			super();
		}
				
		public function get isMenuInitialized():Boolean {
			if(_menu)
				return true
			else
				return false
		}
		
		public function addMenu(tMenu:MovieClip):void {
			_menu = tMenu
			_menu.name = "menu"
			this.addChild(_menu);
			
		}
		
		public function displayMenu(tScreenId:int):void {
			
			// do something to display correct screen
			switch(tScreenId) {
				case ScreenConsts.MAIN_MENU:
					_menu.gotoAndPlay("main");
					break
				case ScreenConsts.OPTIONS_MENU:
					_menu.gotoAndPlay("options");
					break;
				case ScreenConsts.LOADING:
					_menu.gotoAndPlay("loading");
					break
				
			}
			
			_currentScreen = tScreenId;
			
			if(!initList[_currentScreen])		
				_menu.addEventListener(Event.EXIT_FRAME, onScreenInitialized, false, 0, true);
		}
		
		
	
		
		private function onScreenInitialized(evt:Event):void {
			_menu.removeEventListener(Event.EXIT_FRAME, onScreenInitialized);
			
			switch(_currentScreen) {
				case ScreenConsts.MAIN_MENU:
					var tMain:MovieClip = _menu.getChildByName("main") as MovieClip
					var tBtnStart:MenuButton = tMain.getChildByName("btnStartGame") as MenuButton;
					var tBtnOptions:MenuButton = tMain.getChildByName("btnOptions") as MenuButton;
					
					tBtnStart.addEventListener(MouseEvent.CLICK, onStartClicked, false, 0, true);
					tBtnOptions.addEventListener(MouseEvent.CLICK, onOptionsClicked, false, 0, true);
					
					
					break
				case ScreenConsts.OPTIONS_MENU:
				
					break
						
			}
			
			initList[_currentScreen] = true
		}
		
		/** triggered when user clicks start */
		private function onStartClicked(evt:MouseEvent):void {
			dispatchEvent(new MenuEvent(MenuEvent.CLICKED, MenuConsts.BUTTON_START));
		}
		
		/** triggered when user clicks options */
		private function onOptionsClicked(evt:MouseEvent):void {
			dispatchEvent(new MenuEvent(MenuEvent.CLICKED, MenuConsts.BUTTON_OPTIONS));
			
		}
		
		public function displayLoading():void
		{
			// TODO Auto Generated method stub
			displayMenu(ScreenConsts.LOADING)
		}
	}
}