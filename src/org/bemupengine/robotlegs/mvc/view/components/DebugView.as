package org.bemupengine.robotlegs.mvc.view.components
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public class DebugView extends Sprite
	{
		private var _isEnabled : Boolean;
		private var _debugWindow : Sprite;
		private var _textField : TextField;

		public function DebugView()
		{
			super();

			// create a debug window
			_debugWindow = new Sprite();
			_debugWindow.graphics.beginFill( 0x000000 );
			_debugWindow.graphics.drawRect( 800, 0, 400, 600 );
			_debugWindow.graphics.endFill();

			_debugWindow.graphics.beginFill( 0xEEEEEE );
			_debugWindow.graphics.drawRect( 805, 5, 390, 590 );
			_debugWindow.graphics.endFill();

			_textField = new TextField();
			_textField.multiline = true;
			_textField.width = 380;
			_textField.height = 580;
			_textField.x = 820;
			_textField.y = 20;

			_debugWindow.addChild( _textField );
			_debugWindow.visible = false;

			this.addChild( _debugWindow );
		}

		public function toogleVisibility() : void
		{
			if (_debugWindow.visible)
				_debugWindow.visible = false;
			else
				_debugWindow.visible = true;
		}

		public function set show( tValue : Boolean ) : void
		{
			_debugWindow.visible = tValue;
		}

		public function write( tText : String ) : void
		{
			_textField.htmlText += tText;
		}
	}
}