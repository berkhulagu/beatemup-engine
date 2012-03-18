package org.bh.robotlegs.mvc.view.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.bh.robotlegs.events.UIEvent;
	
	public class UIView extends Sprite
	{
		private var _score:TextField
		private var _health:MovieClip
		private var _dodge:MovieClip
		
		private var _dead:MovieClip
		
		public function UIView()
		{
			super();
		}
		
		public function initialize(tMC:MovieClip):void {
			this.addChild(tMC);
			
			// shortcut for score
			_score = tMC.getChildByName("score") as TextField
				
			// shortcut for health
			_health = tMC.getChildByName("health") as MovieClip
			
			// shortcut for dodgecounter
			_dodge  = tMC.getChildByName("dodge") as MovieClip
			
			// shortcut for dead
			_dead = tMC.getChildByName("dead") as MovieClip
		}
		
		public function set health(tHealth:int):void {
			if(_health) {
				_health.gotoAndPlay("health_" + tHealth)
			}
		}
		
		public function set score(tScore:int):void {
			if(_score)
				_score.text = String(tScore)
		}
		
		public function displayPlayerDeath():void {
			if(_dead) {
				_dead.gotoAndPlay("dead")
				_dead.addEventListener(Event.EXIT_FRAME, onAddRetryListener, false, 0, true);	
			}
		}
			
		private function onAddRetryListener(evt:Event):void {
			_dead.removeEventListener(Event.EXIT_FRAME, onAddRetryListener)
			var tRetry:MovieClip = _dead.getChildByName("retry") as MovieClip
			if(tRetry)
				tRetry.addEventListener(MouseEvent.CLICK, onRetryClicked, false, 0, true);
			
		}
		
		private function onRetryClicked(evt:MouseEvent):void {
			this.removeChildAt(0)
			dispatchEvent(new UIEvent(UIEvent.RETRY_CLICKED, null));
		}
	}
}