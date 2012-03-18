
package org.bh.robotlegs.mvc.model
{
	import flash.utils.Dictionary;
	
	import org.bh.robotlegs.mvc.model.components.statemachine.IBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.ICheck;
	import org.bh.robotlegs.mvc.model.components.statemachine.Rule;
	import org.bh.robotlegs.mvc.model.components.statemachine.State;
	import org.bh.robotlegs.mvc.model.components.statemachine.StateMachine;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.AddCharacterBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.AddConversationListenerBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.AnimationBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.CameraBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.DealDamageBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.FacingBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.FollowBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.HealthBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.LogBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.SetConversationBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.SpeedBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.UpdateCharacterStateBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.behaviours.WalkLimitBehaviour;
	import org.bh.robotlegs.mvc.model.components.statemachine.checks.Check;
	import org.bh.robotlegs.mvc.model.components.statemachine.dialog.Conversation;
	import org.bh.robotlegs.mvc.model.components.statemachine.dialog.Response;
	import org.bh.robotlegs.mvc.model.components.statemachine.dialog.Speech;
	import org.bh.robotlegs.utils.Coord2D;
	import org.robotlegs.mvcs.Actor;
	
	/** holds all the state machines configurations */
	public class StateMachineModel extends Actor
	{
		private var _stateMachinesDictionary:Dictionary = new Dictionary()
		private var _conversations:Dictionary = new Dictionary();
		
		public function StateMachineModel()
		{
			super();
		}
		
		/** initializes the state machine model with config xml */
		public function initializeStates(tAllStateMachinesConfigXML:XML):void {
			for each(var tStateMachineXML:XML in tAllStateMachinesConfigXML.statemachine) {
				var tStateMachine:StateMachine = new StateMachine(int(tStateMachineXML.@id));
				
				
				for each(var tStateXML:XML in tStateMachineXML.state) {
					var tState:State = new State();
					tState.id = int(tStateXML.@id);
					
					for each(var tBehavioursXML:XML in tStateXML.behaviours) {
						var tBehaviourXMLList:XMLList = tBehavioursXML.children()

						for(var i:int = 0; i<tBehaviourXMLList.length(); ++i) {
							var tBehaviourXML:XML = tBehaviourXMLList[i] as XML
							var tBehaviourName:String = tBehaviourXML.name().toString()
							if(tBehaviourName ==  "animation") {
								var tAnimationBehaviour:AnimationBehaviour = new AnimationBehaviour(tBehaviourXML.@value)
								tState.behaviours.push(tAnimationBehaviour);
							} else
							if(tBehaviourName == "speed") {
								var tSpeedBehaviour:SpeedBehaviour = new SpeedBehaviour(int(tBehaviourXML.@value))
								tState.behaviours.push(tSpeedBehaviour);
							} else 
							if(tBehaviourName == "facing") {
								var tFacingBehaviour:FacingBehaviour = new FacingBehaviour(int(tBehaviourXML.@value))
								tState.behaviours.push(tFacingBehaviour);
							} else 
							if(tBehaviourName == "camera") {
								var tCameraBehaviour:CameraBehaviour = new CameraBehaviour(int(tBehaviourXML.@minX), int(tBehaviourXML.@maxX), int(tBehaviourXML.@tween))
								tState.behaviours.push(tCameraBehaviour);
									
							} else 
							if(tBehaviourName == "walkLimit")  {
								var tWalkLimitBehaviour:WalkLimitBehaviour = new WalkLimitBehaviour(int(tBehaviourXML.@minX), int(tBehaviourXML.@minY), int(tBehaviourXML.@maxX),int(tBehaviourXML.@maxY))
								tState.behaviours.push(tWalkLimitBehaviour);
								
							} else 
							if(tBehaviourName == "addcharacter")	{
								var tAddCharacterBehaviour:AddCharacterBehaviour = new AddCharacterBehaviour(tBehaviourXML.@enemyid, tBehaviourXML.@enemytype, tBehaviourXML.@statemanager, tBehaviourXML.@initialstate, tBehaviourXML.@posX, tBehaviourXML.@posY);  
								tState.behaviours.push(tAddCharacterBehaviour);
							} else
							if(tBehaviourName == "updatecharacterstate")	{
								var tUpdateCharacterStateBehaviour:UpdateCharacterStateBehaviour = new UpdateCharacterStateBehaviour(tBehaviourXML.@characterid, int(tBehaviourXML.@state));  
								tState.behaviours.push(tUpdateCharacterStateBehaviour);
							} else								
							if(tBehaviourName == "setconversation") {
								var tSCB:SetConversationBehaviour = new SetConversationBehaviour(tBehaviourXML.@characterid, tBehaviourXML.@conversationid)
								tState.behaviours.push(tSCB);
							} else
							if(tBehaviourName == "addconversationlistener") {
								var tACLB:AddConversationListenerBehaviour = new AddConversationListenerBehaviour(tBehaviourXML.@conversationid, tBehaviourXML.@characterid, tBehaviourXML.@state)
								tState.behaviours.push(tACLB);
							}
							else	
							if(tBehaviourName == "follow")	{
								var tFollowBehaviour:FollowBehaviour = new FollowBehaviour(tBehaviourXML.@source, tBehaviourXML.@target, new Coord2D(int(tBehaviourXML.@offsetx), int(tBehaviourXML.@offsety)));  
								tState.behaviours.push(tFollowBehaviour);
							}
							else
							if(tBehaviourName == "dealdamage") {
								var tDealDamageBehaviour:DealDamageBehaviour = new DealDamageBehaviour(int(tBehaviourXML.@value))
								tState.behaviours.push(tDealDamageBehaviour);
							}else
							if(tBehaviourName == "health") {
								var tHealthBehaviour:HealthBehaviour = new HealthBehaviour(int(tBehaviourXML.@value))
								tState.behaviours.push(tHealthBehaviour);
							} else
							if(tBehaviourName == "log") {
								var tLogBehaviour:LogBehaviour = new LogBehaviour(String(tBehaviourXML.@text))
								tState.behaviours.push(tLogBehaviour);
							}
						}
					}
					
					
					for each(var tRuleXML:XML in tStateXML.rules.rule) {
						var tRule:Rule = new Rule(tRuleXML.@state);
							
						var tChecks:Vector.<ICheck> = new Vector.<ICheck>	
						var tCheckXMLList:XMLList = tRuleXML.children()
						
						for(var j:int = 0; j<tCheckXMLList.length(); ++j) {
							var tCheckXML:XML = tCheckXMLList[j] as XML
							var tCheckName:String = tCheckXML.name().toString()
							var tCheckValue:String = tCheckXML.@value
							var tCheck:ICheck = new Check(tCheckName, tCheckValue)
							tRule.checks.push(tCheck)
									
						}
					
						tState.rules.push(tRule)
						
					}
					
					tStateMachine.states.push(tState)
					
				}
				
				_stateMachinesDictionary[tStateMachine.id] = tStateMachine
				
			}
			trace("Done and done")
		}
		
		/** initializes conversations */
		public function initializeConversations(tAllConversationsConfig:XML):void {
			for each(var tConversationXML:XML in tAllConversationsConfig.conversation) {
				var tConversation:Conversation = new Conversation(tConversationXML.@id);
				
				// speeches
				for each(var tSpeechXML:XML in tConversationXML.speeches.speech) {
					var tSpeech:Speech = new Speech(tSpeechXML.@who, tSpeechXML.@says);
					tConversation.addSpeech(tSpeech)
				}
				
				// responses
				for each(var tResponseXML:XML in tConversationXML.responses.response) {
					var tResponse:Response= new Response(tResponseXML.@ask, tResponseXML.@targetconversation);
					tConversation.addResponse(tResponse)
				}
				
				_conversations[tConversation.id] = tConversation
				
			}
		}
		
		public function getState(tStateMachineType:int, tStateId:int):State {
			var tStateMachine:StateMachine = _stateMachinesDictionary[tStateMachineType];
			if(tStateMachine)
				return tStateMachine.getStateById(tStateId)
			else
				return null
		}
		
		public function getConversation(tConversationId:String):Conversation {
			return _conversations[tConversationId]
		}
		
	}
}