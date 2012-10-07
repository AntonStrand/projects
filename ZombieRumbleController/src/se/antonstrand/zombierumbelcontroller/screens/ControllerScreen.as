package se.antonstrand.zombierumbelcontroller.screens
{
	import se.antonstrand.connection.utils.ConnectionManager;
	import se.antonstrand.zombierumbelcontroller.Settings;
	import se.antonstrand.zombierumbelcontroller.objects.Joystick;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ControllerScreen extends Sprite
	{
		private var _joystick		:Joystick;
		
		public function ControllerScreen()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createGraphics();	
			
			this.addEventListener(Event.ENTER_FRAME, onLoop);
		}		
		
		
		private function createGraphics(): void
		{
			_joystick = new Joystick();
			addChild( _joystick );
			_joystick.x = (Settings.STAGE_W - _joystick.width);
			_joystick.y = (Settings.STAGE_H - _joystick.height);
		
			trace( _joystick.width );
		}
		
		private function onLoop( e:Event ): void
		{
			_joystick.update();
			
			ConnectionManager.sendData( {degrees: _joystick.degrees, isShooting: _joystick.isShooting} );
		}
		
	}
}