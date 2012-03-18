package org.bh.robotlegs.mvc.view
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import org.bh.robotlegs.consts.ResourceConsts;
	import org.bh.robotlegs.events.CharacterAnimationEvent;
	import org.bh.robotlegs.events.CharacterTalkableEvent;
	import org.bh.robotlegs.events.DebugCharacterEvent;
	import org.bh.robotlegs.events.DebugEvent;
	import org.bh.robotlegs.events.LevelLoadedEvent;
	import org.bh.robotlegs.events.ResourceEvent;
	import org.bh.robotlegs.events.UIEvent;
	import org.bh.robotlegs.mvc.model.ApplicationModel;
	import org.bh.robotlegs.mvc.model.DebugModel;
	import org.bh.robotlegs.mvc.model.LevelModel;
	import org.bh.robotlegs.mvc.model.PlayerStatsModel;
	import org.bh.robotlegs.mvc.model.ResourceModel;
	import org.bh.robotlegs.mvc.model.components.animations.Animation;
	import org.bh.robotlegs.mvc.model.components.character.CharacterBean;
	import org.bh.robotlegs.mvc.model.components.level.CloneInfo;
	import org.bh.robotlegs.mvc.model.components.level.LayerInfo;
	import org.bh.robotlegs.mvc.model.components.level.LevelComponentMover;
	import org.bh.robotlegs.mvc.model.components.vo.ApplicationVO;
	import org.bh.robotlegs.mvc.model.components.vo.RequestedLibraryVO;
	import org.bh.robotlegs.mvc.view.components.LevelView;
	import org.bh.robotlegs.utils.Coord2D;
	import org.robotlegs.mvcs.Mediator;
	
	import uk.co.bigroom.input.KeyPoll;
	
	/** mediator for gameplay view */
	public class LevelMediator extends Mediator
	{
		[Inject]
		public var view:LevelView
		
		[Inject]
		public var level:LevelModel
		
		[Inject]
		public var playerStats:PlayerStatsModel 
		
		[Inject]
		public var resource:ResourceModel
		
		[Inject]
		public var application:ApplicationModel
		
		[Inject]
		public var debug:DebugModel
		
		// last frames time
		private var lastFramesDate:Number
		
		// key poll
		private var keyPoll:KeyPoll
		
		// layer dictionary
		private var _layers:Vector.<MovieClip> = new Vector.<MovieClip>();
		
		// level component movers
		private var _levelComponentMovers:Vector.<LevelComponentMover>
			
		// offset for layer cloning
		private var _layerOffset:Number = 0;
		
		public function LevelMediator()
		{
			super();
		}

		override public function onRegister():void {		
			trace("OnRegister gameplaymediator")

			eventMap.mapListener( resource.eventDispatcher, LevelLoadedEvent.LOADED, renderLevel, LevelLoadedEvent) 
			
			eventMap.mapListener( level.eventDispatcher, CharacterAnimationEvent.SET_ANIMATION, onSetCharacterAnimation, CharacterAnimationEvent);
			
			addContextListener( CharacterTalkableEvent.SHOW, showMarkOnCharacter, CharacterTalkableEvent)
			addContextListener( CharacterTalkableEvent.HIDE, hideMarkOnCharacter, CharacterTalkableEvent)

			addContextListener(UIEvent.RETRY_CLICKED, cleanup, UIEvent);
			
			_levelComponentMovers = new Vector.<LevelComponentMover>
				
		}
		
		private function hideMarkOnCharacter(evt:CharacterTalkableEvent):void
		{
			view.removeFromCharacterHolder(evt.characterBean, "_talktome")
		}
		
		private function showMarkOnCharacter(evt:CharacterTalkableEvent):void
		{
			// create the excl. mark icon
			var tExclMark:MovieClip = resource.getMovieClipFromBatch(ResourceConsts.BATCH_MENU, "talktome");
			tExclMark.name = "_talktome"
			view.attachToCharacterHolder(evt.characterBean, tExclMark)
		}
		
		private function cleanup(evt:UIEvent):void {
			view.removeChildAt(0)
				
			lastFramesDate = 0;
			
			_layers.splice(0, _layers.length -1);
			_layers = new Vector.<MovieClip>
				
			_levelComponentMovers.splice(0, _levelComponentMovers.length -1);
			_levelComponentMovers = new Vector.<LevelComponentMover>
			
			eventMap.unmapListener( view, Event.ENTER_FRAME, onEnterFrame, Event) 
		}
		
		private function renderLevel(evt:LevelLoadedEvent):void {
			
			// update camera info
			view.updateCameraInfo(level.camera)

			// get the movieclip for level
			var tLevelGraphics:MovieClip = resource.getMovieClipFromBatch("level_" + evt.levelId, "level_"  + evt.levelId)
			
			// add it to view
			view.setLevelGraphics(tLevelGraphics);
						
			// it could be the case that this level has cloned components
			initializeLevelComponentCloning(tLevelGraphics);
			
			// initialize character animations
			initializeCharacterAnimations()
			
			// init layer dictionary 
			initializeLayerDirectory();
			
			// show debugger
			dispatch(new DebugEvent(DebugEvent.TOGGLE_SHOW, ""))
			
			// add the enter_frame listener	
			lastFramesDate = new Date().time
			eventMap.mapListener( view, Event.ENTER_FRAME, onEnterFrame, Event) 
				
			keyPoll = new KeyPoll(view.stage)
		}
		
		private function initializeCharacterAnimations():void {
			for each(var tCharacterBean:CharacterBean in level.characterBeans) {
				setCharacterAnimation(tCharacterBean)
			}
		}
		
		private function initializeLayerDirectory():void {
			for each(var tLayerInfo:LayerInfo in level.levelVO.layers) {
				_layers.push(view.getLevelComponent(tLayerInfo.name));
			}
		}

		private function initializeLevelComponentCloning(tLevelGraphics:MovieClip):void {
			if(level.levelVO.clones.length != 0) {
				for each(var tCloneInfo:CloneInfo in level.levelVO.clones) {
					
					// get the layer info
					var tLayerInfo:LayerInfo = level.getLayerInfo(tCloneInfo.layer)
					
					// where do we add this?
					var tCloneHolder:MovieClip = tLevelGraphics.getChildByName(tCloneInfo.id) as MovieClip
					
					var tLevelComponentMover:LevelComponentMover = null;
					
					if(tCloneHolder)  {
						tLevelComponentMover = createLevelComponentMover(tCloneHolder, tCloneInfo, true, tLayerInfo.speedcoef, new Coord2D(0,0));
					} else {
						var tLength:int = 0;
						
						for each(var tLevelComponentMover:LevelComponentMover in _levelComponentMovers) {
							if(tCloneInfo.layer == tLevelComponentMover.layer) {
								// how many more instances do we need ?
								var tNumCopiesRequired:int = Math.ceil(application.width/ tLevelComponentMover.triggerWidth);
								
								if(tNumCopiesRequired > tCloneInfo.numberoftimes )
									tNumCopiesRequired = tCloneInfo.numberoftimes
					
								tLength += (tLevelComponentMover.moveLimit+tNumCopiesRequired + 1)*tLevelComponentMover.triggerWidth
							}
						}
						
						var tOffSet:Coord2D = new Coord2D(tLength,0)
						tCloneHolder = tLevelGraphics.getChildByName(tCloneInfo.layer) as MovieClip
						tLevelComponentMover = createLevelComponentMover(tCloneHolder, tCloneInfo, false, tLayerInfo.speedcoef, tOffSet);
					}
					
					// add this to the list of level component movers
					_levelComponentMovers.push(tLevelComponentMover)
						
				}
			}
		}
		
		private function createLevelComponentMover(tCloneHolder:DisplayObjectContainer, tCloneInfo:CloneInfo, tIsToBeClonedAlreadyChild:Boolean, tSpeedCoef:Number, tOffset:Coord2D):LevelComponentMover {
			var tToBeCloned:MovieClip
			
			if(tIsToBeClonedAlreadyChild) {
				tToBeCloned = tCloneHolder.getChildAt(0) as MovieClip
			} else {
				tToBeCloned = resource.getMovieClipFromBatch(ResourceConsts.BATCH_LEVELBASE + level.levelVO.levelId, "cn." + tCloneInfo.id);
				tToBeCloned.x = tOffset.x
				tCloneHolder.addChild(tToBeCloned)
			}
			
			// vector of movieclips that will be used for level component moving
			var tVecComponents:Vector.<DisplayObject> = new Vector.<DisplayObject>;
			tVecComponents.push(tToBeCloned)
			
			// get its childs width
			var tWidth:Number = tToBeCloned.width
			
			// how many more instances do we need ?
			var tNumCopiesRequired:int = Math.ceil(application.width/ tWidth);
			
			if(tNumCopiesRequired > tCloneInfo.numberoftimes )
				tNumCopiesRequired = tCloneInfo.numberoftimes
			
			for(var i:int = 0; i<tNumCopiesRequired; ++i) {
				// get the movieclip to be cloned
				var tMCClone:MovieClip = resource.getMovieClipFromBatch(ResourceConsts.BATCH_LEVELBASE + level.levelVO.levelId, "cn." + tCloneInfo.id);
				//tMCClone.cacheAsBitmap = true
				
				tMCClone.x = tMCClone.width*(i+1) + tOffset.x
				
				tCloneHolder.addChild(tMCClone);
				
				tVecComponents.push(tMCClone);
			}
			
			// whenever one level component is out of scene,
			// it will be moved at the end of the last component
			var tLevelComponentMover:LevelComponentMover= new LevelComponentMover(tVecComponents, tCloneInfo.numberoftimes - tNumCopiesRequired, tWidth/tSpeedCoef, tOffset, tCloneInfo.layer, tIsToBeClonedAlreadyChild);

			return tLevelComponentMover
		}
		
		private function onEnterFrame(evt:Event):void {
			
			// navigate to right, depending on the difference between now and last frame time
			var tNewDate:Number = new Date().time
			var tDiff:Number = tNewDate - lastFramesDate
				
			// update camera info
			view.updateCameraInfo(level.camera)
				
			// check level component cloners
			processLayers(tDiff);
				
			// level model should handle the simulation
			level.simulate(tDiff, keyPoll );
			
			// update the position for each enemy
			for each(var tCharacterBean:CharacterBean in level.characterBeans) {
				view.updatePosition(tCharacterBean);
			}
			
			//  do z-sorting
			performZSorting();
				
			// save the new date as last date	
			lastFramesDate = tNewDate
			
			// handle debug stuff, maybe this has to be moved to debug mediator
			handleDebug(tDiff)
			
		}	
		
		private function performZSorting():void {
			view.performZSorting();
		}
		
		
		private function handleDebug(tDiff:Number):void {
			if(debug.enabled) {
				debug.addFrameInterval(tDiff);
				var tCharacters:String = "\nCharacters  X/Y/Speed/Animation/State/facing "
				tCharacters 		  += "\n--------------------------------------\n"	
				for each(var tCharacterBean:CharacterBean in debug.characterBeans) {
					if(tCharacterBean && tCharacterBean.currentAnimation != "")
						tCharacters += ">" + tCharacterBean.id + "> " +   int(tCharacterBean.posX) + " / " + int(tCharacterBean.posY) + " / " + tCharacterBean.speed + " / " + tCharacterBean.currentAnimation + "/" + tCharacterBean.currentState + "/" + int(tCharacterBean.facing*180/Math.PI) +  "\n";
				}
				/*
				dispatch(new DebugEvent(DebugEvent.WRITE, "Time passed between frames >>> Min: " + debug.getFrameIntervalMin() + " ms " 
					+ "/Max: " + debug.getFrameIntervalMax() + " ms "
					+ "/Avg: " + debug.getFrameIntervalAvg() + " ms "
					+ tCharacters
					+ "(Hit 'R' to reset)"))
				*/
			}
		}
		
		private function setCharacterAnimation(tCharacterBean:CharacterBean):void {
			// create the animation movieclip
			var tMovieClip:MovieClip = resource.getMovieClipFromBatch(tCharacterBean.type, tCharacterBean.currentAnimation )
			if(tMovieClip) {
				tMovieClip.mouseChildren = false
				tMovieClip.buttonMode = true
				tMovieClip.characterId = tCharacterBean.id
				
					/*
				if(tCharacterBean.facing >= Math.PI/2 && tCharacterBean.facing <= 3*Math.PI/2 && tCharacterBean.isMovingLeft ) {
					tMovieClip.rotationY = 180
				} */
				
					
				eventMap.mapListener( tMovieClip, CharacterAnimationEvent.SET_ANIMATION, onSetCharacterAnimation, CharacterAnimationEvent)
				eventMap.mapListener( tMovieClip, MouseEvent.CLICK, onCheckCharacterDebug, MouseEvent); 
			} 
			
			// set the animation movieclip for the character
			var tRemovedMovieclip:MovieClip = view.setCharacterAnimation(tCharacterBean, tMovieClip);

			if(tRemovedMovieclip) {
				eventMap.unmapListener( tRemovedMovieclip, CharacterAnimationEvent.SET_ANIMATION, onSetCharacterAnimation, CharacterAnimationEvent)
				eventMap.unmapListener( tRemovedMovieclip, MouseEvent.CLICK, onCheckCharacterDebug, MouseEvent); 
			
				tRemovedMovieclip = null
			}	
			
			if(!tMovieClip) {
				trace("setCharacterAnimation. tMovieClip is null, Type/anim" + tCharacterBean.type + "/" +  tCharacterBean.currentAnimation)
				tCharacterBean = null
			}
			
			
		}
		
		private function onCheckCharacterDebug(evt:MouseEvent):void {
			if(keyPoll.isDown(Keyboard.SHIFT)) {
				dispatch(new DebugCharacterEvent(DebugCharacterEvent.TOGGLE_CHARACTER_DEBUG, evt.target.characterId));
			}
		}
		
		private function onSetCharacterAnimation(evt:CharacterAnimationEvent):void {
			setCharacterAnimation(evt.characterBean);
		}
		
		private function processLayers(tDiff:Number):void {
			// 
			
			// move each of the layers with respect to their speed coef
			var tIndex:int = 0;
			for each(var tLayerInfo:LayerInfo in level.levelVO.layers) {
				//_layers[tIndex].x = -1*Math.ceil(level.totalDistance*tLayerInfo.speedcoef);
				var tLayer:MovieClip = _layers[tIndex];
				if(tLayer)
					tLayer.x = -1*Math.ceil(level.camera.getNextCameraPosition().x*tLayerInfo.speedcoef);
				
				tIndex++;
			}
			
			// teleport components if necessary
			tIndex = 0;
			for each(var tLevelComponentMover:LevelComponentMover in _levelComponentMovers) {
				
				var tCameraPositionX:int = level.camera.getNextCameraPosition().x
				// if avatar is moving to right
				if(level.avatarBean.isFacingRight) {
					if(!tLevelComponentMover.hasExceeded) {
						var tBlockPositionX:int = tLevelComponentMover.getBlocksPosX();
						if( tCameraPositionX> tBlockPositionX ) {
							tLevelComponentMover.moveNext(level.camera.getNextCameraPosition().x - tLevelComponentMover.getBlocksPosX());
						}
					}
				}
				else {
					if(level.avatarBean.isFacingLeft) {
						var tBlockPositionX:int = tLevelComponentMover.getBlocksPosX(true)
						if(tCameraPositionX < tBlockPositionX && tCameraPositionX > tLevelComponentMover.offset.x) {
							tLevelComponentMover.movePrev(level.camera.getNextCameraPosition().x + tLevelComponentMover.getBlocksPosX(true));
						}
					}
				}
							
			
			}
		}
		
	}
}