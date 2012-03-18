package org.bh.robotlegs.events
{
	import flash.events.Event;
	
	public class GameplayEvent extends Event
	{
		public static const START_GAME:String = "GPE.startGame"
		public static const PAUSE_GAME:String = "GPE.pauseGame"
		public static const STOP_GAME:String = "GPE.stopGame"
					
			
		public function GameplayEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}