package org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours
{
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;

	public class LogBehaviour implements IBehaviour
	{
		private var _text : String;

		public function LogBehaviour( tTrace : String )
		{
			_text = tTrace;
		}

		public function get text() : String
		{
			return _text;
		}

		public function set text( value : String ) : void
		{
			_text = value;
		}
	}
}