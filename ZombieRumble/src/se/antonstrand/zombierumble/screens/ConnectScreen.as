package se.antonstrand.zombierumble.screens
{
	import se.antonstrand.zombierumble.Assets;
	import se.antonstrand.zombierumble.events.ConnectionEvent;
	import se.antonstrand.zombierumble.utils.ConnectionManager;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ConnectScreen extends Sprite
	{
		private var _connectButton	:Button;
		
		public function ConnectScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function onAddedToStage( e:Event ): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
			createLayout();
		}
		
		private function createLayout(): void
		{
			_connectButton = new Button( Assets.getAtlas().getTexture( 'playButton' ), 'Connect' );
			_connectButton.x = stage.stageWidth *.5 - _connectButton.width *.5;
			_connectButton.y = stage.stageHeight *.4;
			addChild( _connectButton );
			
			_connectButton.addEventListener(Event.TRIGGERED, onConnectBtn_connect);
		}
		
		private function onConnectBtn_connect( e:Event ): void
		{
			
		}
		
		private function onConnected_dispatch( e:ConnectionEvent ): void
		{
			
		}
	}
}