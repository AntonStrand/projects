package se.antonstrand.zombierumble
{
	import se.antonstrand.zombierumble.screens.Game;
	import se.antonstrand.zombierumble.screens.WelcomeScreen;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addChild( new Game() );
		}
	}
}