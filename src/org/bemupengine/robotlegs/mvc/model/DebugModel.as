package org.bemupengine.robotlegs.mvc.model
{
	import org.bemupengine.robotlegs.mvc.model.components.character.CharacterBean;
	import org.bemupengine.robotlegs.mvc.model.components.debug.FrameIntervalsInfo;
	import org.robotlegs.mvcs.Actor;

	public class DebugModel extends Actor
	{
		private var _frameIntervalsInfo : FrameIntervalsInfo;
		private var _lastToggleVisible : Number = 0;
		private var _charactersOnDebug : Vector.<CharacterBean> = new Vector.<CharacterBean>;
		private var _enabled : Boolean = true;

		public function DebugModel()
		{
			super();
			_frameIntervalsInfo = new FrameIntervalsInfo();
		}

		public function get enabled() : Boolean
		{
			return _enabled;
		}

		public function set enabled( value : Boolean ) : void
		{
			_enabled = value;
		}

		public function get lastToggleVisible() : Number
		{
			return _lastToggleVisible;
		}

		public function set lastToggleVisible( value : Number ) : void
		{
			_lastToggleVisible = value;
		}

		public function addFrameInterval( tInterval : int ) : void
		{
			_frameIntervalsInfo.add( tInterval );
		}

		public function getFrameIntervalMax() : int
		{
			return _frameIntervalsInfo.max;
		}

		public function getFrameIntervalMin() : int
		{
			return _frameIntervalsInfo.min;
		}

		public function getFrameIntervalAvg() : int
		{
			return _frameIntervalsInfo.avg;
		}

		public function resetFrameIntervalStats() : void
		{
			_frameIntervalsInfo.reset()	;
		}

		public function addCharacterToBeDebugged( tCharacterBean : CharacterBean ) : void
		{
			_charactersOnDebug.push( tCharacterBean );
		}

		public function removeCharacterToBeDebugged( tCharacterId : String ) : void
		{
			var tIndex : int = 0;
			for each (var tCharacterBean:CharacterBean in _charactersOnDebug)
			{
				if (tCharacterBean.id == tCharacterId)
					break;
				else
					tIndex++;
			}

			if (tIndex != _charactersOnDebug.length)
				_charactersOnDebug.splice( tIndex, 1 );
		}

		public function getCharacterBean( tCharacterId : String ) : CharacterBean
		{
			for each (var tCharacterBean:CharacterBean in _charactersOnDebug)
			{
				if (tCharacterBean.id == tCharacterId)
					return tCharacterBean;
			}

			return null;
		}

		public function get characterBeans() : Vector.<CharacterBean>
		{
			return _charactersOnDebug;
		}
	}
}