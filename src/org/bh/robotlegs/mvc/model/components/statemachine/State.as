package org.bh.robotlegs.mvc.model.components.statemachine
{
	public class State
	{
		private var _id:int;
		
		private var _behaviours:Vector.<IBehaviour> = new Vector.<IBehaviour>
		private var _rules:Vector.<Rule> = new Vector.<Rule>
		
		public function State()
		{
		}

		public function get rules():Vector.<Rule>
		{
			return _rules;
		}

		public function set rules(value:Vector.<Rule>):void
		{
			_rules = value;
		}

		public function get behaviours():Vector.<IBehaviour>
		{
			return _behaviours;
		}

		public function set behaviours(value:Vector.<IBehaviour>):void
		{
			_behaviours = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

	}
}