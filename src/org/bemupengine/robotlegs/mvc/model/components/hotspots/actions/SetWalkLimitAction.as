package org.bemupengine.robotlegs.mvc.model.components.hotspots.actions
{
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.IHotspot;

	public class SetWalkLimitAction extends  AbstractAction
	{
		private var _minX : int;
		private var _maxX : int;
		private var _minY : int;
		private var _maxY : int;

		public function SetWalkLimitAction( tCreatedHotspot : IHotspot, tMinX : int, tMinY : int, tMaxX : int, tMaxY : int )
		{
			super( tCreatedHotspot );
			minX = tMinX;
			minY = tMinY;
			maxX = tMaxX;
			maxY = tMaxY;
		}

		public function get minX() : int
		{
			return _minX;
		}

		public function set minX( value : int ) : void
		{
			_minX = value;
		}

		public function get minY() : int
		{
			return _minY;
		}

		public function set minY( value : int ) : void
		{
			_minY = value;
		}

		public function get maxX() : int
		{
			return _maxX;
		}

		public function set maxX( value : int ) : void
		{
			_maxX = value;
		}

		public function get maxY() : int
		{
			return _maxY;
		}

		public function set maxY( value : int ) : void
		{
			_maxY = value;
		}

		override public function trigger() : void
		{
			trace( "trigger set walklimit" );
		}
	}
}