package org.bemupengine.robotlegs.mvc.model
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flashx.textLayout.events.ModelChange;
	import org.bemupengine.robotlegs.events.CharacterAnimationEvent;
	import org.bemupengine.robotlegs.events.CharacterTalkableEvent;
	import org.bemupengine.robotlegs.events.ClearResponsesEvent;
	import org.bemupengine.robotlegs.events.ClearSubtitleEvent;
	import org.bemupengine.robotlegs.events.ConversationEndedEvent;
	import org.bemupengine.robotlegs.events.DebugEvent;
	import org.bemupengine.robotlegs.events.LevelLoadedEvent;
	import org.bemupengine.robotlegs.events.ResponseEvent;
	import org.bemupengine.robotlegs.events.SpeechEvent;
	import org.bemupengine.robotlegs.events.UIEvent;
	import org.bemupengine.robotlegs.mvc.model.components.camera.Camera;
	import org.bemupengine.robotlegs.mvc.model.components.camera.FollowerCameraDecorator;
	import org.bemupengine.robotlegs.mvc.model.components.camera.ICamera;
	import org.bemupengine.robotlegs.mvc.model.components.character.CharacterBean;
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.Hotspot;
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.IHotspot;
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.actions.AddEnemyAction;
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.actions.IAction;
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.actions.MoveHotspotAction;
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.actions.SetCameraAction;
	import org.bemupengine.robotlegs.mvc.model.components.hotspots.actions.SetWalkLimitAction;
	import org.bemupengine.robotlegs.mvc.model.components.level.CloneInfo;
	import org.bemupengine.robotlegs.mvc.model.components.level.LayerInfo;
	import org.bemupengine.robotlegs.mvc.model.components.level.postsimulation.IPostSimulation;
	import org.bemupengine.robotlegs.mvc.model.components.level.postsimulation.LimitCharacterMovementDecorator;
	import org.bemupengine.robotlegs.mvc.model.components.level.postsimulation.PostSimulation;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.IBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.ICheck;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.Rule;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.State;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.AddCharacterBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.AddConversationListenerBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.AnimationBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.CameraBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.DealDamageBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.FacingBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.FollowBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.HealthBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.LogBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.SetConversationBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.SpeedBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.UpdateCharacterStateBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.behaviours.WalkLimitBehaviour;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.checks.Check;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.dialog.Conversation;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.dialog.Response;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.dialog.Speech;
	import org.bemupengine.robotlegs.mvc.model.components.vo.LevelVO;
	import org.bemupengine.robotlegs.mvc.model.components.vo.RequestedLibraryVO;
	import org.bemupengine.robotlegs.utils.Coord2D;
	import org.osmf.events.TimeEvent;
	import org.robotlegs.mvcs.Actor;
	import uk.co.bigroom.input.KeyPoll;




	public class LevelModel extends Actor
	{
		[Inject]
		public var stateMachine : StateMachineModel;
		[Inject]
		public var debug : DebugModel;
		private var _levelVO : LevelVO = new LevelVO();
		private var _totalDistance : Number = 0;
		private var _insideHotspotsList : Dictionary = new Dictionary();
		private var _characterBeans : Vector.<CharacterBean> = new Vector.<CharacterBean>	;
		private var _avatarsCharacterBean : CharacterBean;
		private var _nextEnemyId : int = 1;
		private var _currentTime : Number = 0;
		private var _lastThoughtProcess : Number = 0;
		private var _avatarHitTimer : Timer = new Timer( 1000, 1 );
		private var _gamestate : int = 1;
		// 1. playing 2. dead
		private var _camera : ICamera;
		private var _postSimulation : IPostSimulation;
		// for dialogs
		private var _isInteracting : Boolean = false;
		private var _isResponseTurn : Boolean = false;
		private var _closestCharacterToInteract : CharacterBean;
		private var _speechSkipTimer : Timer = new Timer( 200, 1 );
		private var _currentConversation : Conversation = null;
		private var _currentSpeechIndex : int = 0;
		private var _conversationListeners : Vector.<AddConversationListenerBehaviour> = new Vector.<AddConversationListenerBehaviour>;
		private var _lastConversations : Vector.<String> = new Vector.<String>;

		public function LevelModel()
		{
			super();
		}

		public function get camera() : ICamera
		{
			return _camera;
		}

		public function set camera( value : ICamera ) : void
		{
			_camera = value;
		}

		public function cleanup() : void
		{
			_totalDistance = 0;
			_insideHotspotsList = new Dictionary();

			_characterBeans.splice( 0, _characterBeans.length - 1 );
			_characterBeans = new Vector.<CharacterBean>;

			_avatarsCharacterBean = null;
			_nextEnemyId = 1;

			_currentTime = 0;

			_lastThoughtProcess = 0;

			_avatarHitTimer.stop();
			_avatarHitTimer.reset();
			_gamestate = 1;
			// 1. playing 2. dead

			_levelVO.cleanup();

			_camera = null;
		}

		public function get characterBeans() : Vector.<CharacterBean>
		{
			return _characterBeans;
		}

		public function get totalDistance() : Number
		{
			return _totalDistance;
		}

		public function set totalDistance( value : Number ) : void
		{
			_totalDistance = value;
		}

		public function parseAndStoreConfig( tXML : XML ) : void
		{
			// parse and store
			var tLevelId : int = tXML.@id;
			var tRequiredCharacters : Vector.<String> = new Vector.<String>;
			var tClones : Vector.<CloneInfo> = new Vector.<CloneInfo>();
			var tLayers : Vector.<LayerInfo> = new Vector.<LayerInfo>();
			var tHotspots : Vector.<IHotspot> = new Vector.<IHotspot> ;
			var tCharacters : Vector.<CharacterBean> = new Vector.<CharacterBean>;

			// required characters
			for each (var tCharacterXML:XML in tXML.characters.character)
			{
				tRequiredCharacters.push( tCharacterXML.@type );
			}

			// characters
			for each (var tCharacterPosition:XML in tXML.characterpositions.character)
			{
				var tCharacterBean : CharacterBean = new CharacterBean( tCharacterPosition.@id, tCharacterPosition.@type, tCharacterPosition.@statemanager, tCharacterPosition.@initialstate, tCharacterPosition.@posX, tCharacterPosition.@posY, tCharacterPosition.@currentAnimation, tCharacterPosition.@speedX, tCharacterPosition.@speedY );

				// performs initial behaviour
				performBehaviours( tCharacterBean, tCharacterBean.stateManagerId, tCharacterBean.currentState, false );

				_characterBeans.push( tCharacterBean );
				tCharacters.push( tCharacterBean );

				// store a shortcut if its avatar
				if (tCharacterBean.id == "avatar")
				{
					_avatarsCharacterBean = tCharacterBean;
					_avatarsCharacterBean.randomFrameFriendly = false;
					playerPosition = new Coord2D( _avatarsCharacterBean.posX, _avatarsCharacterBean.posY );
				}
			}

			// cloning of the level components
			for each (var tClone:XML in tXML.clones.clone)
			{
				tClones.push( new CloneInfo( tClone.@id, tClone.@layer, tClone.@numberoftimes, tClone.@previous ) );
			}

			// layers
			for each (var tLayer:XML in tXML.layers.layer)
			{
				tLayers.push( new LayerInfo( tLayer.@name, tLayer.@speedcoef, tLayer.@previous ) );
			}

			// hotspots
			for each (var tHotspot:XML in tXML.hotspots.hotspot)
			{
				var tCreatedHotspot : IHotspot = new Hotspot( int( tHotspot.@id ), tHotspot.@type, int( tHotspot.@x ), int( tHotspot.@y ), int( tHotspot.@radius ), int( tHotspot.@limit ) );
				var tActions : Vector.<IAction> = new Vector.<IAction>;

				for each (var tAction:XML in tHotspot.action)
				{
					var tActionType : String = tAction.@type;

					switch(tActionType)
					{
						case "moveHotspot":
							var tIncrementX : int = tAction.@incrementedX;
							var tIncrementY : int = tAction.@incrementedY;
							tActions.push( new MoveHotspotAction( tCreatedHotspot, tIncrementX, tIncrementY ) );
							break;
						case "addEnemy":
							var id : String = tAction.@id;
							var enemyType : String = tAction.@enemyType;
							var tStateManagerId : int = tAction.@statemanager;
							var tInitialState : int = tAction.@initialstate;
							var tDistanceX : int = tAction.@distanceX;
							var tDistanceY : int = tAction.@distanceY;
							tActions.push( new AddEnemyAction( tCreatedHotspot, id, enemyType, tStateManagerId, tInitialState, tDistanceX, tDistanceY ) );
							break;
						case "setCamera":
							var tMinX : int = tAction.@minX;
							var tMaxX : int = tAction.@maxX;
							tActions.push( new SetCameraAction( tCreatedHotspot, tMinX, tMaxX ) );
							break;
						case "setWalkLimit":
							var tMinX : int = tAction.@minX;
							var tMaxX : int = tAction.@maxX;
							var tMinY : int = tAction.@minY;
							var tMaxY : int = tAction.@maxY;
							tActions.push( new SetWalkLimitAction( tCreatedHotspot, tMinX, tMinY, tMaxX, tMaxY ) );
							break;
						default:
							trace( "No action defined" );
					}
				}

				tCreatedHotspot.setActions( tActions );

				tHotspots.push( tCreatedHotspot );
			}

			// create the camera
			_camera = new FollowerCameraDecorator( new Camera( new Coord2D( _avatarsCharacterBean.posX, _avatarsCharacterBean.posY ) ), 400, 40100 );

			// create the post simulation
			_postSimulation = new LimitCharacterMovementDecorator( new PostSimulation(), _avatarsCharacterBean, 50, -90, 40500, -10 );

			_levelVO.setLevelInfo( tLevelId, tRequiredCharacters, tCharacters, tClones, tLayers, tHotspots );
		}

		public function getRequiredCharactersForLevel( tLevelId : int ) : Vector.<String>
		{
			return _levelVO.requiredCharacterTypes;
		}

		public function set playerPosition( tPlayerPosition : Coord2D ) : void
		{
			// set the player position data
			_levelVO.playerPosition = tPlayerPosition;
		}

		public function get enemyPositions() : Vector.<Coord2D>
		{
			return _levelVO.enemyPositions;
		}

		public function get playerPosition() : Coord2D
		{
			return _levelVO.playerPosition;
		}

		/** simulates the game, a key function */
		public function simulate( tTimePassed : Number, tKeyPoll : KeyPoll ) : void
		{
			if (_currentTime == 0)
				_currentTime = new Date().time;
			else
				_currentTime += tTimePassed;

			// check hotspots
			processHotspots( _totalDistance );

			// if the character is dead...
			if (_avatarsCharacterBean && _avatarsCharacterBean.health == 0 && _gamestate == 1)
			{
				_gamestate = 2 ;
				// dead...

				_avatarsCharacterBean.speed = 0;
				dispatch( new UIEvent( UIEvent.PLAYER_DIED, null ) );
			}

			var tSpeedX : Number = Math.cos( _avatarsCharacterBean.facing ) * _avatarsCharacterBean.speed;
			if (tSpeedX < 1 && tSpeedX > -1)
			{
				tSpeedX = 0;
			}
			var tDistanceCovered : Number = Math.ceil( tTimePassed * tSpeedX / 1000 );

			// increase total distance, the speed of the camera is equal to speed of avatar
			totalDistance += tDistanceCovered;

			dispatch( new UIEvent( UIEvent.SET_SCORE, totalDistance ) );

			var tThoughtDone : Boolean = false;

			// handle enemy positions
			for each (var tCharacterBean:CharacterBean in characterBeans)
			{
				// find the new position
				if (tCharacterBean.id != "avatar")
				{
					tCharacterBean.posX += Math.ceil( tTimePassed * Math.cos( tCharacterBean.facing ) * (tCharacterBean.speed) / 1000 );
					tCharacterBean.posY += (tTimePassed * Math.sin( tCharacterBean.facing ) * (tCharacterBean.speed) / 1000);

					if (_currentTime - _lastThoughtProcess > 50)
					{
						// think for enemy, so 'C' language style...
						think( tCharacterBean );

						// is he following someone?
						if (tCharacterBean.isFollowingSomeone)
							tCharacterBean.calculateFollow();

						tThoughtDone = true;
					}

					// if avatar can talk to this guy
					if (tCharacterBean.conversationId != null && tCharacterBean.conversationId != "")
					{
						// check the closeness to character
						if (Math.abs( _avatarsCharacterBean.posX - tCharacterBean.posX ) < 150 && Math.abs( _avatarsCharacterBean.posY - tCharacterBean.posY ) < 150)
						{
							if (!_closestCharacterToInteract)
							{
								_closestCharacterToInteract = tCharacterBean;
								dispatch( new CharacterTalkableEvent( CharacterTalkableEvent.SHOW, tCharacterBean ) );
							}
						}
						else
						{
							if (_closestCharacterToInteract && _closestCharacterToInteract.id == tCharacterBean.id)
							{
								dispatch( new CharacterTalkableEvent( CharacterTalkableEvent.HIDE, tCharacterBean ) );
								_closestCharacterToInteract = null;
							}
						}
					}
					else
					{
						// was he the closest character?
						if (_closestCharacterToInteract && _closestCharacterToInteract.id == tCharacterBean.id)
						{
							_closestCharacterToInteract = null;
							dispatch( new CharacterTalkableEvent( CharacterTalkableEvent.HIDE, tCharacterBean ) );
						}
					}
					// check collisions
					// if(tCharacterBean != _avatarsCharacterBean)
					// processCollision(tCharacterBean);
										
					// if its outside
					/*
					if(tCharacterBean.posX - _totalDistance < -250) {
					// this character is going to be removed from screen
					tCharacterBean.remove = true
					tCharacterBean.currentAnimation = ""				
					dispatch(new CharacterAnimationEvent(CharacterAnimationEvent.SET_ANIMATION, tCharacterBean))
					tCharacterBean = null
					}
					 */
				}
			}

			// update camera
			var tCameraDiff : Coord2D = _camera.update( _avatarsCharacterBean.posX, _avatarsCharacterBean.posY );

			_avatarsCharacterBean.posX = totalDistance + 400;
			_avatarsCharacterBean.posY -= tTimePassed * Math.sin( _avatarsCharacterBean.facing ) * _avatarsCharacterBean.speed / 1000;

			if (tThoughtDone)
				_lastThoughtProcess = _currentTime;

			// handle key strokes
			handleKeyStrokes( tKeyPoll );

			// apply post simulation requirements
			_postSimulation.update();
		}

		/** tests if there are any collisions, acts on it */
		private function processCollision( tEnemy : CharacterBean ) : void
		{
			if (_avatarsCharacterBean.health <= 0)
				return ;

			if (!_avatarHitTimer.running)
			{
				switch(tEnemy.type)
				{
					case "Soldier2_static":
						if (tEnemy.posX - _avatarsCharacterBean.posX < 80 && tEnemy.posX - _avatarsCharacterBean.posX > 0)
						{
							if (_avatarsCharacterBean.currentAnimation != "JumpUpdate_01")
							{
								_avatarsCharacterBean.health = _avatarsCharacterBean.health - 1;
								dispatch( new UIEvent( UIEvent.SET_HEALTH, _avatarsCharacterBean.health ) );

								_avatarHitTimer.reset();
								_avatarHitTimer.start();
							}
						}
						break;
					case "KamikazeBot":
						if (Math.abs( _avatarsCharacterBean.posX - tEnemy.posX ) < 25)
						{
							if (_avatarsCharacterBean.currentAnimation != "JumpUpdate_01")
							{
								_avatarsCharacterBean.health = _avatarsCharacterBean.health - 1;
								dispatch( new UIEvent( UIEvent.SET_HEALTH, _avatarsCharacterBean.health ) );

								_avatarHitTimer.reset();
								_avatarHitTimer.start();
							}
						}
						break;
					case "FlyBot":
						if (tEnemy.posX - _avatarsCharacterBean.posX < 100 && tEnemy.posX - _avatarsCharacterBean.posX > 0)
						{
							if (_avatarsCharacterBean.currentAnimation != "Slide_002")
							{
								{
									_avatarsCharacterBean.health = _avatarsCharacterBean.health - 1;
									dispatch( new UIEvent( UIEvent.SET_HEALTH, _avatarsCharacterBean.health ) );

									_avatarHitTimer.reset();
									_avatarHitTimer.start();
											
								}
							}
							break;
						}
				}
			}
		}

		/** tests the check */
		private function testCheck( tCharacterBean : CharacterBean, tCheck : ICheck ) : Boolean
		{
			var tRetVal : Boolean = false;

			switch(tCheck.command)
			{
				case "avatar_distance_equals_or_smaller":
					if (tCharacterBean.type != "avatar")
						if ((  Math.abs( tCharacterBean.posX - _avatarsCharacterBean.posX )) <= int( tCheck.value ))
							tRetVal = true;
					break;
				case "avatar_distance_equals_or_bigger":
					if (tCharacterBean.type != "avatar")
						if ((  Math.abs( tCharacterBean.posX - _avatarsCharacterBean.posX )) >= int( tCheck.value ))
							tRetVal = true;
					break;
				case "avatar_distance_y_greater_than":
					if (tCharacterBean.type != "avatar")
						if ( Math.abs( Math.ceil( _avatarsCharacterBean.posY ) - Math.ceil( tCharacterBean.posY ) ) >= int( tCheck.value ))
							tRetVal = true;
					break;
				case "avatar_distance_y_smaller_than":
					if (tCharacterBean.type != "avatar")
						if ( Math.abs( Math.ceil( _avatarsCharacterBean.posY ) - Math.ceil( tCharacterBean.posY ) ) <= int( tCheck.value ))
							tRetVal = true;
					break;
				case "avatar_passed_hotspot":
					// did this guy passed hotspot?
					if (_insideHotspotsList[int( tCheck.value )])
					{
						_insideHotspotsList[int( tCheck.value )] = null;
						// HACK!
						tRetVal = true;
					}
					break;
				case "mylife_equals_or_smaller":
					if (tCharacterBean.health <= int( tCheck.value ))
						tRetVal = true;
					break;
				case "key_pressed":
					break;
				case "timer":
					if (_currentTime - tCharacterBean.lastStateChangeAt > int( tCheck.value ))
						tRetVal = true;
					break;
				case "state_of_character":
					var tSplit : Array = tCheck.value.split( "," );
					for each (var tCharacterBean:CharacterBean in _characterBeans)
						if (	tCharacterBean.id == tSplit[0])
						{
							if (tCharacterBean.currentState == int( tSplit[1] ))
							{
								tRetVal = true;
							}
						}
					break;
				case "characterdead":
					var tIsDeadCB : CharacterBean = getCharacterBean( tCheck.value );
					if (tIsDeadCB && tIsDeadCB.health == 0)
						tRetVal = true;
					break;
				case "alwaystrue":
					tRetVal = true;
				case "levelinitialized":
					if (_camera)
						tRetVal = true;
					break;
			}

			return tRetVal;
		}

		/** think for that character bean */
		private function think( tCharacterBean : CharacterBean ) : void
		{
			// which state is he currently in
			var tState : State = stateMachine.getState( tCharacterBean.stateManagerId, tCharacterBean.currentState );

			if (tState)
			{
				// check the rules
				for each ( var tRule:Rule in tState.rules)
				{
					// test the checks

					var tCheckHolds : Boolean = false;

					if ( tRule.checks && tRule.checks.length != 0)
						tCheckHolds = true;

					for each (var tCheck:ICheck in tRule.checks)
					{
						if (!testCheck( tCharacterBean, tCheck ))
						{
							tCheckHolds = false;
							break;
						}
					}

					// if check is successful
					if (tCheckHolds)
					{
						// set the state
						tCharacterBean.currentState = tRule.nextState;
						tCharacterBean.lastStateChangeAt = _currentTime;

						// do the behaviours for the next state
						performBehaviours( tCharacterBean, tCharacterBean.stateManagerId, tCharacterBean.currentState, true );
					}
				}
			}
		}

		private function performBehaviours( tCharacterBean : CharacterBean, tStateManagerId : int, tStateId : int, tUpdateVisuals : Boolean ) : void
		{
			// get the state
			var tState : State = stateMachine.getState( tStateManagerId, tStateId );

			for each (var tBehaviour:IBehaviour in tState.behaviours)
			{
				if (tBehaviour is AnimationBehaviour)
				{
					var tAnimBehaviour : AnimationBehaviour = tBehaviour as AnimationBehaviour;
					tCharacterBean.currentAnimation = tAnimBehaviour.animationName;

					if (tUpdateVisuals)
						dispatch( new CharacterAnimationEvent( CharacterAnimationEvent.SET_ANIMATION, tCharacterBean ) );
				}
				else if (tBehaviour is SpeedBehaviour)
				{
					var tSpeedBehaviour : SpeedBehaviour = tBehaviour as SpeedBehaviour;
					tCharacterBean.speed = tSpeedBehaviour.speed;
				}
				else if (tBehaviour is FacingBehaviour)
				{
					var tFacingBehaviour : FacingBehaviour = tBehaviour as FacingBehaviour;
					tCharacterBean.facing = tFacingBehaviour.facing;
				}
				if (tBehaviour is CameraBehaviour)
				{
					var tCameraBehaviour : CameraBehaviour = tBehaviour as CameraBehaviour;
					// update the camera
					var tFCD : FollowerCameraDecorator = (_camera as FollowerCameraDecorator);

					tFCD.xMin = tCameraBehaviour.minX;
					tFCD.xMax = tCameraBehaviour.maxX;
				}
				else if (tBehaviour is WalkLimitBehaviour)
				{
					var tWalkLimitBehaviour : WalkLimitBehaviour = tBehaviour as WalkLimitBehaviour;
					_postSimulation = new LimitCharacterMovementDecorator( new PostSimulation(), _avatarsCharacterBean, tWalkLimitBehaviour.minX, tWalkLimitBehaviour.minY, tWalkLimitBehaviour.maxX, tWalkLimitBehaviour.maxY );
				}
				else if (tBehaviour is LogBehaviour)
				{
					var tLogBehaviour : LogBehaviour = tBehaviour as LogBehaviour;

					trace( "LOG> " + tLogBehaviour.text );
				}
				else if (tBehaviour is AddCharacterBehaviour)
				{
					var tAddCharacterBehaviour : AddCharacterBehaviour = tBehaviour as AddCharacterBehaviour;

					var tCharacterBean : CharacterBean = new CharacterBean( tAddCharacterBehaviour.enemyId, tAddCharacterBehaviour.enemyType, tAddCharacterBehaviour.stateManagerId, tAddCharacterBehaviour.initialState, tAddCharacterBehaviour.posX, tAddCharacterBehaviour.posY, "", 0 );

					_characterBeans.push( tCharacterBean );

					performBehaviours( tCharacterBean, tCharacterBean.stateManagerId, tCharacterBean.currentState, true );
				}
				else if (tBehaviour is SetConversationBehaviour)
				{
					var tSCB : SetConversationBehaviour = tBehaviour as SetConversationBehaviour;

					getCharacterBean( tSCB.characterId ).conversationId = tSCB.conversationId;

					if (tSCB.conversationId == "")
					{
						dispatch( new CharacterTalkableEvent( CharacterTalkableEvent.HIDE, tCharacterBean ) );
					}
				}
				else if (tBehaviour is AddConversationListenerBehaviour)
				{
					var tACLB : AddConversationListenerBehaviour = tBehaviour as AddConversationListenerBehaviour;
					_conversationListeners.push( tACLB );
				}
				else if (tBehaviour is UpdateCharacterStateBehaviour)
				{
					var tUCSB : UpdateCharacterStateBehaviour = tBehaviour as UpdateCharacterStateBehaviour;
					var tCharacterBean : CharacterBean = getCharacterBean( tUCSB.characterId );
					tCharacterBean.currentState = tUCSB.state;
					performBehaviours( tCharacterBean, tCharacterBean.stateManagerId, tCharacterBean.currentState, true );
				}
				else if (tBehaviour is DealDamageBehaviour)
				{
					var tDDB : DealDamageBehaviour = tBehaviour as DealDamageBehaviour;

					if (_avatarsCharacterBean.health - tDDB.damageAmount >= 0)
					{
						_avatarsCharacterBean.health = _avatarsCharacterBean.health - tDDB.damageAmount;
						dispatch( new UIEvent( UIEvent.SET_HEALTH, _avatarsCharacterBean.health ) );

						_avatarHitTimer.reset();
						_avatarHitTimer.start();
					}
				}
				else if (tBehaviour is FollowBehaviour)
				{
					var tFB : FollowBehaviour = tBehaviour as FollowBehaviour;
					var tSourceCharacter : CharacterBean = tCharacterBean;
					if (tFB.sourceCharacterId && tFB.sourceCharacterId != "")
					{
						tSourceCharacter = getCharacterBean( tFB.sourceCharacterId );
					}

					var tTargetCharacter : CharacterBean = getCharacterBean( tFB.targetCharacterId );

					if (tTargetCharacter)
						tSourceCharacter.follow( tTargetCharacter, tFB.offset );
				}
				else if (tBehaviour is HealthBehaviour)
				{
					var tHB : HealthBehaviour = tBehaviour as HealthBehaviour;
					tCharacterBean.health = tHB.health;
				}
			}
		}

		private function onConversationEnded( evt : ConversationEndedEvent ) : void
		{
			// TODO Auto Generated method stub
		}

		private function setCameraBehaviour( tCB : CameraBehaviour ) : void
		{
			var tFCD : FollowerCameraDecorator = (_camera as FollowerCameraDecorator);
			// tFCD.xMin = tCB.minX
			// tFCD.xMax = tCB.maxX
		}

		// iterates through all hotspots and processes them
		private function processHotspots( tCurrentX : int ) : void
		{
			for each (var tHotspot:IHotspot in _levelVO.hotspots)
			{
				if (tHotspot.isInsideHotspot( tCurrentX ))
				{
					if (_insideHotspotsList[tHotspot.id])
					{
						// you are already in. no trigger for you nah-ah!
					}
					else
					{
						// previously, you were not in
						_insideHotspotsList[tHotspot.id] = tHotspot;

						//
						trace( "In A Hotspot! id : " + tHotspot.id );

						// trigger your actionz!
						for each (var tAction:IAction in tHotspot.actions)
							triggerAction( tAction );

						// decrease limit
						tHotspot.limit--;

						// if it is zero, its time to deactive this hotspot
						if (tHotspot.limit == 0)
						{
							tHotspot.x = int.MAX_VALUE;
							tHotspot.y = int.MAX_VALUE;
						}
					}
				}
				else
				{
					// If that hotspot is in the list, remove 
					// if(_insideHotspotsList[tHotspot.id]) {
					// _insideHotspotsList[tHotspot.id] = null;
					// }
				}
			}
		}

		private function triggerAction( tActions : IAction ) : void
		{
			if (tActions is MoveHotspotAction)
			{
				var tMoveHotspotAction : MoveHotspotAction = tActions as MoveHotspotAction;
				tMoveHotspotAction.parent.x += tMoveHotspotAction.incrementX;
				tMoveHotspotAction.parent.y += tMoveHotspotAction.incrementY;
			}
			else if (tActions is AddEnemyAction)
			{
				var tAddEnemyAction : AddEnemyAction = tActions as AddEnemyAction;
				var tCharacterBean : CharacterBean = new CharacterBean( tAddEnemyAction.enemyId, tAddEnemyAction.enemyType, tAddEnemyAction.stateManagerId, tAddEnemyAction.initialState, tAddEnemyAction.parent.x + tAddEnemyAction.distanceX, tAddEnemyAction.parent.y + tAddEnemyAction.distanceY, "", 0 );

				_characterBeans.push( tCharacterBean );

				performBehaviours( tCharacterBean, tCharacterBean.stateManagerId, tCharacterBean.currentState, true );

				// tell the mediator to add a new character to scene
				// dispatch(new CharacterAnimationEvent( CharacterAnimationEvent.SET_ANIMATION, tCharacterBean))
			}
			else if (tActions is SetCameraAction)
			{
				var tSetCameraAction : SetCameraAction = tActions as SetCameraAction;
				// create the camera
				// _camera = new FollowerCameraDecorator(new Camera( new Coord2D(_avatarsCharacterBean.posX, _avatarsCharacterBean.posY)), tSetCameraAction.minX, tSetCameraAction.maxX);
				var tFCD : FollowerCameraDecorator = (_camera as FollowerCameraDecorator);
				tFCD.xMax = tSetCameraAction.maxX;
				tFCD.xMin = tSetCameraAction.minX;
			}
			else if (tActions is SetWalkLimitAction)
			{
				var tSetWalkLimitAction : SetWalkLimitAction = tActions as SetWalkLimitAction;
				_postSimulation = new LimitCharacterMovementDecorator( new PostSimulation(), _avatarsCharacterBean, tSetWalkLimitAction.minX, tSetWalkLimitAction.minY, tSetWalkLimitAction.maxX, tSetWalkLimitAction.maxY );
			}
		}

		private function handleKeyStrokes( tKeyPoll : KeyPoll ) : void
		{
			if (_avatarsCharacterBean.health == 0)
			{
				return;
			}
			var tCurrentavatarAnimation : String = _avatarsCharacterBean.currentAnimation	;
			var tAnimationToPlay : String = "";
			var tMoving : Boolean = false;

			var tDirX : Number = 0;
			var tDirY : Number = 0;

			var tMagX : int = 1;
			var tMagY : int = 1;

			var tDirCombined : Number = 0;
			var tMagCombined : int = 0;

			if (tKeyPoll.isDown( Keyboard.RIGHT ) || tKeyPoll.isDown( Keyboard.LEFT ) || tKeyPoll.isDown( Keyboard.UP ) || tKeyPoll.isDown( Keyboard.DOWN ))
			{
				if (!_isInteracting)
				{
					var tPrevIsMovingLeft : Boolean = _avatarsCharacterBean.isMovingLeft;

					if ( tKeyPoll.isDown( Keyboard.RIGHT ) && tKeyPoll.isUp( Keyboard.LEFT ))
					{
						tDirX = 0;
						_avatarsCharacterBean.isMovingLeft = false;
					}

					if ( tKeyPoll.isDown( Keyboard.LEFT ) && tKeyPoll.isUp( Keyboard.RIGHT ))
					{
						tDirX = Math.PI;
						_avatarsCharacterBean.isMovingLeft = true;
					}

					// if the user pressed both
					if ( tKeyPoll.isDown( Keyboard.LEFT ) && tKeyPoll.isDown( Keyboard.RIGHT ))
					{
						if (tPrevIsMovingLeft)
							tDirX = Math.PI;
						else
							tDirX = 0;
					}

					if ( tKeyPoll.isUp( Keyboard.RIGHT ) && tKeyPoll.isUp( Keyboard.LEFT ))
					{
						tMagX = 0;
					}

					// up and down
					if ( tKeyPoll.isDown( Keyboard.UP ) && tKeyPoll.isUp( Keyboard.DOWN ))
					{
						tDirY = Math.PI / 2;
					}

					if ( tKeyPoll.isDown( Keyboard.DOWN ) && tKeyPoll.isUp( Keyboard.UP ))
					{
						tDirY = 3 * Math.PI / 2;
					}

					if ( tKeyPoll.isUp( Keyboard.UP ) && tKeyPoll.isUp( Keyboard.DOWN ))
					{
						tMagY = 0;
					}

					if (Math.abs( tDirX - tDirY ) > Math.PI)
					{
						tDirX += 2 * Math.PI;
					}

					tDirCombined = ((tDirX * tMagX + tDirY * tMagY) / (tMagX + tMagY));

					if (tDirCombined > 2 * Math.PI)
					{
						tDirCombined -= 2 * Math.PI;
					}

					_avatarsCharacterBean.speed = 500;
					_avatarsCharacterBean.facing = tDirCombined;

					if (_avatarsCharacterBean.currentAnimation != "JumpUpdate_01" && _avatarsCharacterBean.currentAnimation != "Melee")
						tAnimationToPlay = "RunA_001";
				}
			}
			else
			{
				_avatarsCharacterBean.speed = 0;
				if (_avatarsCharacterBean.currentAnimation != "JumpUpdate_01" && _avatarsCharacterBean.currentAnimation != "Melee")
					tAnimationToPlay = "Still";
			}

			if (tKeyPoll.isDown( Keyboard.SPACE ) && !_isInteracting)
			{
				if (_avatarsCharacterBean.currentAnimation != "JumpUpdate_01" && _avatarsCharacterBean.currentAnimation != "Melee")
				{
					tAnimationToPlay = "JumpUpdate_01";

					var tTimer : Timer = new Timer( 350, 1 );
					tTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onAvatarJumpCompleted );
					tTimer.start();
				}
			}

			if (tKeyPoll.isDown( Keyboard.CONTROL ) && !_isInteracting)
			{
				if (_avatarsCharacterBean.currentAnimation != "JumpUpdate_01" && _avatarsCharacterBean.currentAnimation != "Melee")
				{
					tAnimationToPlay = "Melee";

					var tTimer : Timer = new Timer( 600, 1 );
					tTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onAvatarJumpCompleted );
					tTimer.start()	;

					// deal melee damage
					dealMeleeDamage();
				}
			}

			if (tKeyPoll.isDown( Keyboard.E ))
			{
				if (!_isInteracting)
				{
					// is there someone to interact?
					if (_closestCharacterToInteract)
					{
						dispatch( new DebugEvent( DebugEvent.APPEND, "Begin chat..." ) );

						dispatch( new CharacterTalkableEvent( CharacterTalkableEvent.HIDE, _closestCharacterToInteract ) );

						_isInteracting = true;
						var tConversation : Conversation = stateMachine.getConversation( _closestCharacterToInteract.conversationId );
						_currentConversation = tConversation;
						_currentSpeechIndex = 0;
						handleCurrentConversation()	;
					}
				}
			}

			if (tKeyPoll.isDown( Keyboard.X ))
			{
				// this one skips the speech.
				if (_isInteracting)
				{
					if (!_speechSkipTimer.running)
					{
						_speechSkipTimer.reset();
						_speechSkipTimer.start();

						// skip the speech
						_currentSpeechIndex++;
						handleCurrentConversation();
					}
				}
			}

			if (_isResponseTurn && (tKeyPoll.isDown( Keyboard.NUMBER_1 ) || tKeyPoll.isDown( Keyboard.NUMBER_2 ) || tKeyPoll.isDown( Keyboard.NUMBER_3 ) || tKeyPoll.isDown( Keyboard.NUMBER_4 )))
			{
				var tSelection : int = -1;
				if (tKeyPoll.isDown( Keyboard.NUMBER_1 ))
					tSelection = 0;
				if (tKeyPoll.isDown( Keyboard.NUMBER_2 ))
					tSelection = 1;
				if (tKeyPoll.isDown( Keyboard.NUMBER_3 ))
					tSelection = 2;
				if (tKeyPoll.isDown( Keyboard.NUMBER_4 ))
					tSelection = 3;

				// set the current conversation according to the selection
				if (tSelection < _currentConversation.responses.length)
				{
					var tResponse : Response = _currentConversation.responses[tSelection];
					_currentConversation = stateMachine.getConversation( tResponse.targetConversation );
					_currentSpeechIndex = 0;
					dispatch( new ClearResponsesEvent( ClearResponsesEvent.CLEAR ) )	;
					handleCurrentConversation();
				}
			}

			// debug stuff
			if (tKeyPoll.isDown( Keyboard.ENTER ))
			{
				// if last toggle time is 300 ms ago...
				if ( _currentTime - debug.lastToggleVisible > 300)
				{
					dispatch( new DebugEvent( DebugEvent.TOGGLE_SHOW, "" ) );
					debug.lastToggleVisible = _currentTime;
				}
			}

			if (tKeyPoll.isDown( Keyboard.R ))
			{
				debug.resetFrameIntervalStats();
			}

			// handle animations
			if (tAnimationToPlay != "" && (tCurrentavatarAnimation != tAnimationToPlay) )
			{
				_avatarsCharacterBean.currentAnimation = tAnimationToPlay;
				dispatch( new CharacterAnimationEvent( CharacterAnimationEvent.SET_ANIMATION, _avatarsCharacterBean ) );
			}
		}

		private function handleCurrentConversation() : void
		{
			handleConversation( _currentConversation, _currentSpeechIndex );
		}

		private function handleConversation( tConversation : Conversation, tSpeechIndex : int ) : void
		{
			if (_lastConversations.indexOf( tConversation.id ) == -1)
				_lastConversations.push( tConversation.id );

			if (tSpeechIndex < tConversation.speeches.length)
			{
				_isResponseTurn = false;

				var tSpeech : Speech = tConversation.speeches[tSpeechIndex];
				var tWho : String = tSpeech.who;
				var tSays : String = tSpeech.says;

				dispatch( new SpeechEvent( SpeechEvent.SPEECH, tWho, tSays, tConversation, tSpeechIndex ) );
			}
			else
			{
				// its response time
				if (!_isResponseTurn)
				{
					_isResponseTurn = true;
					if (tConversation.responses.length != 0)
					{
						dispatch( new ResponseEvent( ResponseEvent.ASK, tConversation.responses ) );
					}
					else
					{
						_isInteracting = false;
						// if(_closestCharacterToInteract && _closestCharacterToInteract.conversationId != null && _closestCharacterToInteract.conversationId != "")
						// dispatch( new CharacterTalkableEvent( CharacterTalkableEvent.SHOW, _closestCharacterToInteract));
						_closestCharacterToInteract = null;
						dispatch( new DebugEvent( DebugEvent.APPEND, "End of chat..." ) );
						dispatch( new ClearSubtitleEvent( ClearSubtitleEvent.CLEAR ) );

						// check the conversation list. maybe you talked something important
						var tIndex : int = 0;
						for each (var tACL:AddConversationListenerBehaviour in _conversationListeners)
						{
							if (tACL != null)
							{
								for each (var tTalkedConversationId:String in _lastConversations)
								{
									if (tACL.conversationId == tTalkedConversationId)
									{
										// do the state change requested
										var tCharacterBean : CharacterBean = getCharacterBean( tACL.characterId );
										tCharacterBean.currentState = tACL.state;

										performBehaviours( tCharacterBean, tCharacterBean.stateManagerId, tCharacterBean.currentState, true );

										// _conversationListeners = null
									}
								}
							}

							tIndex++;
						}

						_lastConversations.splice( 0, _lastConversations.length );
					}
				}
			}
		}

		private function dealMeleeDamage() : void
		{
			for each (var tCharacterBean:CharacterBean in _characterBeans)
			{
				if (tCharacterBean.id != "avatar")
				{
					var tDistanceX : int = _avatarsCharacterBean.posX - tCharacterBean.posX;
					var tDistanceY : int = _avatarsCharacterBean.posY - tCharacterBean.posY;

					if (Math.abs( tDistanceX ) < 150 && Math.abs( tDistanceY ) < 30)
					{
						// facing ?
						if (tDistanceX < 0 && _avatarsCharacterBean.isFacingRight || tDistanceX > 0 && _avatarsCharacterBean.isFacingLeft)
						{
							// does this guy have something to say, if so dont deal damage
							if (tCharacterBean.conversationId == null || tCharacterBean.conversationId == "" )
							{
								// deal the damage to that enemy
								tCharacterBean.health -= 1;
							}
						}
					}
				}
			}
		}

		private function onAvatarJumpCompleted( tTimerEvent : TimerEvent ) : void
		{
			if (_avatarsCharacterBean.speed == 0 || _avatarsCharacterBean.stopped)
				_avatarsCharacterBean.currentAnimation = "Still";
			else
				_avatarsCharacterBean.currentAnimation = "RunA_001";

			dispatch( new CharacterAnimationEvent( CharacterAnimationEvent.SET_ANIMATION, _avatarsCharacterBean ) );
		}

		public function getLayerInfo( tName : String ) : LayerInfo
		{
			for each (var tLayerInfo:LayerInfo in _levelVO.layers)
			{
				if (tLayerInfo.name == tName)
					return tLayerInfo;
			}

			return null;
		}

		public function updateCharacterBean( tParamCharacterBean : CharacterBean ) : void
		{
			for each (var tCharacterBean:CharacterBean in characterBeans)
			{
				if (tCharacterBean.id == tParamCharacterBean.id)
				{
					tCharacterBean.currentAnimation = tParamCharacterBean.currentAnimation;
					break;
				}
			}
		}

		public function get levelVO() : LevelVO
		{
			return _levelVO;
		}

		public function set levelVO( value : LevelVO ) : void
		{
			_levelVO = value;
		}

		public function getCharacterBean( tCharacterId : String ) : CharacterBean
		{
			for each (var tCharacterBean:CharacterBean in characterBeans)
			{
				if (tCharacterBean.id == tCharacterId)
				{
					return tCharacterBean;
				}
			}

			return null;
		}

		public function get avatarBean() : CharacterBean
		{
			return _avatarsCharacterBean;
		}
	}
}
	