package se.antonstrand.zombierumble.screens
{
	import se.antonstrand.zombierumble.events.ConnectionEvent;
	import se.antonstrand.zombierumble.objects.Player;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var _players	:Vector.<Player>;
		
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function onAddedToStage( e:Event ): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
			createListeners();
		}
		
		private function createListeners(): void
		{
			addEventListener(ConnectionEvent.DATA_RECEIVED, onDataReceived_updatePlayer);
		}
		
		private function onDataReceived_updatePlayer( e:ConnectionEvent ):void
		{
			
		}
		
		private function onLoop( e:Event ): void
		{
			
		}
	}
}