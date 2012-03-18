package org.bh.robotlegs.mvc.model.components.hotspots.actions
{
	import org.bh.robotlegs.mvc.model.components.hotspots.IHotspot;
	
	public class SetCameraAction extends AbstractAction
	{
		private var _minX:int
		private var _maxX:int
		
		public function SetCameraAction(tParent:IHotspot, tMinX:int,tMaxX:int)
		{
			super(tParent)
			_minX = tMinX
			_maxX = tMaxX
		}
		
		public function get minX():int
		{
			return _minX;
		}
		
		public function set minX(value:int):void
		{
			_minX = value;
		}
		
		public function get maxX():int
		{
			return _maxX;
		}
		
		public function set maxX(value:int):void
		{
			_maxX = value;
		}
		
				override public function trigger():void
		{
			trace("trigger set camera")
		}
	}
}