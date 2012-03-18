package org.bemupengine.robotlegs.mvc.view
{
	import org.bemupengine.robotlegs.events.ClearResponsesEvent;
	import org.bemupengine.robotlegs.events.ClearSubtitleEvent;
	import org.bemupengine.robotlegs.events.DebugEvent;
	import org.bemupengine.robotlegs.events.ResponseEvent;
	import org.bemupengine.robotlegs.events.SpeechEvent;
	import org.bemupengine.robotlegs.mvc.model.components.statemachine.dialog.Response;
	import org.bemupengine.robotlegs.mvc.view.components.DialogView;
	import org.robotlegs.mvcs.Mediator;

	public class DialogMediator extends Mediator
	{
		[Inject]
		public var view : DialogView;

		public function DialogMediator()
		{
			super();
		}

		override public function onRegister() : void
		{
			addContextListener( SpeechEvent.SPEECH, handleSpeech, SpeechEvent );
			addContextListener( ResponseEvent.ASK, handleResponses, ResponseEvent );
			addContextListener( ClearSubtitleEvent.CLEAR, clearSubtitle, ClearSubtitleEvent );
			addContextListener( ClearResponsesEvent.CLEAR, clearResponses, ClearResponsesEvent );
		}

		private function clearResponses( evt : ClearResponsesEvent ) : void
		{
			view.clearResponses();
		}

		private function clearSubtitle( evt : ClearSubtitleEvent = null ) : void
		{
			// TODO Auto Generated method stub
			view.setSubtitle( "" );
		}

		private function handleResponses( evt : ResponseEvent ) : void
		{
			var tIndex : int = 1;
			clearSubtitle();

			for each (var tResponse:Response in evt.responses)
			{
				var tText : String = tIndex + " > " + tResponse.ask;
				tIndex++ ;
				dispatch( new DebugEvent( DebugEvent.APPEND, tText ) );
				view.addResponse( "<b><font size=\"24\" >" + tText + "</font></b>" );
			}
		}

		private function handleSpeech( evt : SpeechEvent ) : void
		{
			var tSpeechText : String = evt.who + " says " + evt.says;
			dispatch( new DebugEvent( DebugEvent.APPEND, tSpeechText ) );

			view.setSubtitle( "<font size=\"24\" ><b>" + evt.who + ":</b>  " + evt.says + "</font>" );
		}
	}
}