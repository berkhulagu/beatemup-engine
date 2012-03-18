package org.bh.robotlegs.mvc.model.components.statemachine.checks
{
	import org.bh.robotlegs.mvc.model.components.statemachine.ICheck;

	public class Check implements ICheck
	{
		private var _command:String
		private var _value:String
		public function Check(tCommand:String, tValue:String)
		{
			_command = tCommand
			_value = tValue
		}

		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
		}

		public function get command():String
		{
			return _command;
		}

		public function set command(value:String):void
		{
			_command = value;
		}

	}
}