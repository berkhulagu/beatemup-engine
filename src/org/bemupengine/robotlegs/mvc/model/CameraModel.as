package org.bemupengine.robotlegs.mvc.model
{
	import org.bemupengine.robotlegs.utils.Coord2D;
	import org.robotlegs.mvcs.Actor;

	public class CameraModel extends Actor
	{
		private var _position : Coord2D;

		public function CameraModel()
		{
			super();

			_position = new Coord2D( 0, 0 );
		}

		public function get position() : Coord2D
		{
			return _position;
		}

		public function set position( value : Coord2D ) : void
		{
			_position = value;
		}
	}
}