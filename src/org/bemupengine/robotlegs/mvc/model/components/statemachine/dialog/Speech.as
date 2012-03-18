package org.bemupengine.robotlegs.mvc.model.components.statemachine.dialog
{
	public class Speech
	{
		private var _who : String;
		private var _says : String;

		public function Speech( who : String, says : String )
		{
			this.who = who;
			this.says = says;
		}

		public function get says() : String
		{
			return _says;
		}

		public function set says( value : String ) : void
		{
			_says = value;
		}

		public function get who() : String
		{
			return _who;
		}

		public function set who( value : String ) : void
		{
			_who = value;
		}
	}
}