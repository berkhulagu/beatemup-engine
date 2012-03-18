package org.bh.robotlegs.mvc.model
{
	import org.bh.robotlegs.mvc.model.components.vo.ApplicationVO;
	import org.robotlegs.mvcs.Actor;
	
	public class ApplicationModel extends Actor
	{
		private var _applicationVO:ApplicationVO = new ApplicationVO()
		
		public function ApplicationModel()
		{
			super();
		}
		
		public function set width(tWidth:int):void {
			_applicationVO.width = tWidth
		}
		
		public function set height(tHeight:int):void {
			_applicationVO.height = tHeight
		}
		
		public function get height():int {
			return _applicationVO.height
		}
		
		public function get width():int {
			return _applicationVO.width
		}
	}
}