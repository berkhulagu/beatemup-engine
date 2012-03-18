package org.bh.robotlegs.mvc.model.components.statemachine.dialog
{
	public class Response
	{
		private var _ask:String
		private var _targetConversation:String
		
		public function Response(ask:String, targetConversation:String)
		{
			this.ask = ask
			this.targetConversation = targetConversation
		}

		public function get targetConversation():String
		{
			return _targetConversation;
		}

		public function set targetConversation(value:String):void
		{
			_targetConversation = value;
		}

		public function get ask():String
		{
			return _ask;
		}

		public function set ask(value:String):void
		{
			_ask = value;
		}

	}
}