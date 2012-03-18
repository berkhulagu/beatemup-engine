package org.bh.robotlegs.mvc.model.components.animations
{
	import flash.display.MovieClip;

	public class Animation
	{
		private var _name:String;
		private var _url:String;
		private var _graphics:MovieClip
		
		public function Animation(tName:String, tURL:String)
		{
			_name = tName
			_url = 	tURL
		
		}

		public function get url():String
		{
			return _url;
		}

		public function set graphics(value:MovieClip):void
		{
			_graphics = value;
			_graphics.name = _name
				
		}

		public function get graphics():MovieClip
		{
			return _graphics;
		}

		public function get name():String
		{
			return _name;
		}

		/** plays the animation */
		public function playAnimation():void {
			if(_graphics)
				_graphics.play()
		}	
		
		/** stops the animation */
		public function stopAnimation():void {
			if(_graphics)
				_graphics.stop()
		}
		

	}
}