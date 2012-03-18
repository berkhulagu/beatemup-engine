package org.bemupengine.robotlegs.mvc.model.components.debug
{
	public class FrameIntervalsInfo
	{
		// all are milliseconds
		private var _min : int;
		private var _max : int;
		private var _avg : int;
		private var _currentTotal : int;
		private var _currentSamples : int;

		public function FrameIntervalsInfo()
		{
			reset();
		}

		public function get avg() : int
		{
			return _currentTotal / _currentSamples;
		}

		public function get max() : int
		{
			return _max;
		}

		public function get min() : int
		{
			return _min;
		}

		public function add( tInterval : int ) : void
		{
			if (tInterval < _min)
				_min = tInterval;

			if (tInterval > _max)
				_max = tInterval;

			_currentTotal += tInterval;
			_currentSamples++;
		}

		public function reset() : void
		{
			_min = 99;
			_max = 0;
			_avg = 0;

			_currentTotal = 0;
			_currentSamples = 0;
		}
	}
}