package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	import org.bemupengine.robotlegs.BemupEngineContext;
	import org.bemupengine.robotlegs.mvc.view.components.DebugView;
	import org.bemupengine.robotlegs.mvc.view.components.DialogView;
	import org.bemupengine.robotlegs.mvc.view.components.LevelView;
	import org.bemupengine.robotlegs.mvc.view.components.MenuView;
	import org.bemupengine.robotlegs.mvc.view.components.UIView;



	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="1200", height="600")]
	public class BemupEngine extends Sprite
	{
		public var context : BemupEngineContext;
		private var _menuView : MenuView;
		private var _levelView : LevelView;
		private var _uiView : UIView;
		private var _dialogView : DialogView;
		private var _debugView : DebugView;

		public function BemupEngine()
		{
			Security.allowDomain( "*" );
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			context = new BemupEngineContext( this );
		}

		public function createChildren() : void
		{
			_menuView = new MenuView();
			_levelView = new LevelView();
			_uiView = new UIView();
			_dialogView = new DialogView();
			_debugView = new DebugView();

			addChild( _menuView );
			addChild( _levelView );
			addChild( _dialogView );
			addChild( _uiView );
			addChild( _debugView );
		}
	}
}