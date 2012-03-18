package org.bemupengine.robotlegs.mvc.model.components.ai
{
	public class Grid
	{
		private var _hScore : int;
		private var _gScore : int;
		private var _totalScore : int;

		public function Grid()
		{
		}

		public function get totalScore() : int
		{
			return _totalScore;
		}

		public function set totalScore( value : int ) : void
		{
			_totalScore = value;
		}

		public function get gScore() : int
		{
			return _gScore;
		}

		public function set gScore( value : int ) : void
		{
			_gScore = value;
		}

		public function get hScore() : int
		{
			return _hScore;
		}

		public function set hScore( value : int ) : void
		{
			_hScore = value;
		}
	}
}