package org.bh.robotlegs.mvc.model.components.statemachine
{
	public class StateMachine
	{
		private var _id:int // unique id
		
		private var _states:Vector.<State> = new Vector.<State>
		
		public function StateMachine(tId:int)
		{			
			_id = tId
		}
		
		public function getStateById(tStateId:int):State {
			for each(var tState:State in _states)
				if(tState.id == tStateId)
					return tState
					
			return null
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get states():Vector.<State>
		{
			return _states;
		}

		public function set states(value:Vector.<State>):void
		{
			_states = value;
		}

	}
}