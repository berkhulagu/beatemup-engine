package org.bemupengine.robotlegs.mvc.view.components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class DialogView extends Sprite
	{
		private var subtitle : TextField;
		private var responses : TextField;

		public function DialogView()
		{
			super();

			subtitle = new TextField();
			subtitle.width = 600;
			subtitle.height = 300;
			subtitle.autoSize = TextFieldAutoSize.CENTER;
			subtitle.multiline = true;
			subtitle.x = 400;
			subtitle.y = 300;

			addChild( subtitle );

			responses = new TextField();
			responses.width = 600;
			responses.height = 300;
			responses.autoSize = TextFieldAutoSize.CENTER;
			responses.multiline = true;
			responses.x = 300;
			responses.y = 200;

			addChild( responses );
		}

		public function addResponse( tResponse : String ) : void
		{
			responses.htmlText += tResponse + "<br>";
		}

		public function setSubtitle( tText : String ) : void
		{
			subtitle.htmlText = tText;
		}

		public function clearResponses() : void
		{
			responses.text = "";
		}
	}
}