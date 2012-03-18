package org.bemupengine.robotlegs.mvc.model.components.vo
{
	public class ApplicationVO
	{
		private var _width:int;
		private var _height:int;
		
		public function ApplicationVO()
		{
		}

		public function get height():int
		{
			return _height;
		}

		public function set height(value:int):void
		{
			_height = value;
		}

		public function get width():int
		{
			return _width;
		}

		public function set width(value:int):void
		{
			_width = value;
		}

	}
}