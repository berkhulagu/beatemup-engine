package org.bemupengine.robotlegs.mvc.model
{
	import org.bemupengine.robotlegs.mvc.model.components.vo.PlayerStatsVO;
	import org.robotlegs.mvcs.Actor;

	public class PlayerStatsModel extends Actor
	{
		public var playerStatsVO : PlayerStatsVO = new PlayerStatsVO();

		public function PlayerStatsModel()
		{
			super();

			playerStatsVO.level = 1;
			playerStatsVO.score = 0;
			playerStatsVO.highScore = 0;
			playerStatsVO.achievements = new Vector.<int>();
		}
	}
}