package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import org.bh.robotlegs.GrimBeaperContext;
	import org.bh.robotlegs.consts.ScreenConsts;
	import org.bh.robotlegs.mvc.model.components.camera.Camera;
	import org.bh.robotlegs.mvc.model.components.camera.FollowerCameraDecorator;
	import org.bh.robotlegs.mvc.model.components.camera.ICamera;
	import org.bh.robotlegs.mvc.view.components.DebugView;
	import org.bh.robotlegs.mvc.view.components.DialogView;
	import org.bh.robotlegs.mvc.view.components.LevelView;
	import org.bh.robotlegs.mvc.view.components.MenuView;
	import org.bh.robotlegs.mvc.view.components.UIView;
	import org.bh.robotlegs.utils.Coord2D;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="1200", height="600")]
	public class GrimBeaper extends Sprite
	{
		public var context:GrimBeaperContext
		
		private var _menuView:MenuView
		private var _levelView:LevelView
		private var _uiView:UIView
		private var _dialogView:DialogView
		private var _debugView:DebugView
		
		public function GrimBeaper()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			context = new GrimBeaperContext(this);
		}
		
		public function createChildren():void
		{
			_menuView  = new MenuView()
			_levelView = new LevelView()
			_uiView = new UIView()
			_dialogView = new DialogView();
			_debugView = new DebugView()
				
				
			addChild(_menuView)
			addChild(_levelView);
			addChild(_dialogView)
			addChild(_uiView)
			addChild(_debugView)
		}
		
	}
}