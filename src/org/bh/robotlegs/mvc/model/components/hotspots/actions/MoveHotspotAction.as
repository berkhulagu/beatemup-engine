package org.bh.robotlegs.mvc.model.components.hotspots.actions
{
	import org.bh.robotlegs.mvc.model.components.hotspots.IHotspot;

	public class MoveHotspotAction extends AbstractAction
	{
		private var _incrementX:int
		private var _incrementY:int
		
		public function MoveHotspotAction(tParent:IHotspot, tIncrementX:int, tIncrementY:int)
		{
			super(tParent)
			_incrementX = tIncrementX
			_incrementY = tIncrementY
		}
		
		override public function trigger():void {
			trace("Triggering MoveHotspotAction!")
		}

		public function get incrementY():int
		{
			return _incrementY;
		}

		public function set incrementY(value:int):void
		{
			_incrementY = value;
		}

		public function get incrementX():int
		{
			return _incrementX;
		}

		public function set incrementX(value:int):void
		{
			_incrementX = value;
		}

	}
}