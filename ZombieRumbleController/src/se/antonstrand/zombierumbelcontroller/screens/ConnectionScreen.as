package se.antonstrand.zombierumbelcontroller.screens
{
	import se.antonstrand.connection.events.ConnectionEvent;
	import se.antonstrand.connection.utils.ConnectionManager;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ConnectionScreen extends Sprite
	{
		public function ConnectionScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ): void
		{
			ConnectionManager.dispatcher.addEventListener(ConnectionEvent.CONNECTED, onCon);
			ConnectionManager.connect( '1234', {name: 'Controller' });
		}
		
		private function onCon( e:ConnectionEvent ): void
		{
			trace( e.user.details.name );
			var _controllerScreen:ControllerScreen = new ControllerScreen();
			addChild( _controllerScreen );
		}
	}
}