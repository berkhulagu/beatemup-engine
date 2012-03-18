package org.bh.robotlegs.mvc.model.components.level
{
	public class LayerInfo
	{
		private var _name:String
		private var _speedcoef:Number
		private var _previousLayerName:String
		
		public function LayerInfo(name:String, speedcoef:Number, previousLayerName:String)
		{
			this.name = name
			this.speedcoef = speedcoef
			this.previousLayerName = previousLayerName
		}

		public function get previousLayerName():String
		{
			return _previousLayerName;
		}

		public function set previousLayerName(value:String):void
		{
			_previousLayerName = value;
		}

		public function get speedcoef():Number
		{
			return _speedcoef;
		}

		public function set speedcoef(value:Number):void
		{
			_speedcoef = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

	}
}