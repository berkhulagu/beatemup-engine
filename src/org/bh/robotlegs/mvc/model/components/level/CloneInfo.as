package org.bh.robotlegs.mvc.model.components.level
{
	public class CloneInfo
	{
		private var _id:String
		private var _layer:String
		private var _numberoftimes:int
		private var _previous:String
		
		public function CloneInfo(id:String, layer:String, numberoftimes:int, previous:String )
		{
			this.id = id
			this.layer = layer
			this.numberoftimes = numberoftimes
			this.previous = previous
				
			if(this.numberoftimes == -1) 
				this.numberoftimes = int.MAX_VALUE
		}

		public function get previous():String
		{
			return _previous;
		}

		public function set previous(value:String):void
		{
			_previous = value;
		}

		public function get layer():String
		{
			return _layer;
		}

		public function set layer(value:String):void
		{
			_layer = value;
		}

		public function get numberoftimes():int
		{
			return _numberoftimes;
		}

		public function set numberoftimes(value:int):void
		{
			_numberoftimes = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

	}
}