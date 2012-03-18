package org.bh.robotlegs.mvc.model.components.vo
{
	/** Value object that holds the stats for player */
	public class PlayerStatsVO
	{		
		private var _score:int
		private var _highScore:int
		private var _achievements:Vector.<int>;
		private var _level:int
		
		public function PlayerStatsVO()
		{
		}

		public function get level():int
		{
			return _level;
		}

		public function set level(value:int):void
		{
			_level = value;
		}

		public function get achievements():Vector.<int>
		{
			return _achievements;
		}

		public function set achievements(value:Vector.<int>):void
		{
			_achievements = value;
		}

		public function get highScore():int
		{
			return _highScore;
		}

		public function set highScore(value:int):void
		{
			_highScore = value;
		}

		/**/
		public function get score():int
		{
			return _score;
		}

		/**
		 * @private
		 */
		public function set score(value:int):void
		{
			_score = value;
		}

	}
}