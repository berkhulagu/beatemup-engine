package org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;

	public class CameraBehaviour implements IBehaviour
	{		
		private var _minX:int;
		private var _maxX:int;
		private var _tween:Boolean;
		
		public function CameraBehaviour(tMinX:int, tMaxX:int, tTween:int )
		{
			minX = tMinX;
			maxX = tMaxX;
				
			if(tTween == 0) {
				tween = false;
			} else 
				tween = true;
		}

		public function get tween():Boolean
		{
			return _tween;
		}

		public function set tween(value:Boolean):void
		{
			_tween = value;
		}

		public function get maxX():int
		{
			return _maxX;
		}

		public function set maxX(value:int):void
		{
			_maxX = value;
		}

		public function get minX():int
		{
			return _minX;
		}

		public function set minX(value:int):void
		{
			_minX = value;
		}

	}
}