package se.antonstrand.zombierumbelcontroller
{
	import se.antonstrand.zombierumbelcontroller.objects.Joystick;
	import se.antonstrand.zombierumbelcontroller.screens.ConnectionScreen;
	import se.antonstrand.zombierumbelcontroller.screens.ControllerScreen;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		private var _connectionScreen		:ConnectionScreen;
		private var _controllerScreen		:ControllerScreen;
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ): void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_connectionScreen = new ConnectionScreen();
			addChild( _connectionScreen );
			
			
		}
		
		
		
	}
}