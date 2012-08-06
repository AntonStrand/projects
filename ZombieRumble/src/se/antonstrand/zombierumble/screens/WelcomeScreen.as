package se.antonstrand.zombierumble.screens
{
	import se.antonstrand.zombierumble.Assets;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class WelcomeScreen extends Sprite
	{
		private var _playButton		:Button;
		private var _addButton		:Button;
		
		public function WelcomeScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createButtons();	
		}
		
		private function createButtons(): void
		{
			_playButton = new Button( Assets.getAtlas().getTexture( 'playButton' ), 'Play' );
			_playButton.x = stage.stageWidth *.5 - _playButton.width *.5;
			_playButton.y = stage.stageHeight *.3;
			addChild( _playButton );
			
			_addButton = new Button( Assets.getAtlas().getTexture( 'playButton' ), 'Connect more controllers' );
			_addButton.x = stage.stageWidth *.5 - _addButton.width *.5;
			_addButton.y = _playButton.y + _playButton.height + 10;
			addChild( _addButton );
		}
	}
}