package org.bh.robotlegs.mvc.model.components.hotspots
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.bh.robotlegs.mvc.model.components.hotspots.actions.IAction;

	public class Hotspot implements IHotspot
	{
		private var _id:int
		private var _type:String
		private var _x:int
		private var _y:int
		private var _radius:int
		private var _limit:int
		
		private var _actions:Vector.<IAction>

		private var dispatcher:EventDispatcher;
		
		public function Hotspot(tId:int, tType:String, tX:int,tY:int, tRadius:int, tLimit:int)
		{
			_id = tId
			_type = tType
			_x = tX
			_y = tY
			_radius = tRadius
			_limit = tLimit
		
			dispatcher = new EventDispatcher(this);
		}
		
		public function get limit():int
		{
			return _limit;
		}

		public function set limit(value:int):void
		{
			_limit = value;
		}

		public function get y():int
		{
			return _y;
		}

		public function set y(value:int):void
		{
			_y = value;
		}

		public function get x():int
		{
			return _x;
		}

		public function set x(value:int):void
		{
			_x = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function setActions(tVecActions:Vector.<IAction>):void {
			_actions = tVecActions
		}
		
		public function isInsideHotspot(tCurrentX:int):Boolean {
			if( (_x - _radius) < tCurrentX  && tCurrentX < (_x + _radius)) {
				return true
			} else
				return false
		}
		
		public function get actions():Vector.<IAction> {
			return _actions
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
			dispatcher.addEventListener(type, listener, useCapture, priority);
		}
		
		public function dispatchEvent(evt:Event):Boolean{
			return dispatcher.dispatchEvent(evt);
		}
		
		public function hasEventListener(type:String):Boolean{
			return dispatcher.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type:String):Boolean {
			return dispatcher.willTrigger(type);
		}
	}
}