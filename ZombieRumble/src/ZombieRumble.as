package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import net.hires.debug.Stats;
	
	import se.antonstrand.zombierumble.Assets;
	import se.antonstrand.zombierumble.Main;
	import se.antonstrand.zombierumble.Settings;
	import se.antonstrand.connection.events.ConnectionEvent;
	import se.antonstrand.connection.utils.ConnectionManager;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="1080", height="960", backgroundColor="0x444444")]
	public class ZombieRumble extends Sprite
	{
		public function ZombieRumble()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addChild( new Stats() );
			
			
			ConnectionManager.dispatcher.addEventListener(ConnectionEvent.CONNECTED, onConnected_initGame);
			ConnectionManager.connect( Settings.GROUP_NAME, {name: 'Computer'} );
		}
		
		private function onConnected_initGame( e:ConnectionEvent ): void
		{
			var star:Starling = new Starling( Main, stage );
			star.antiAliasing = 1;
			star.start();
			
			trace( Settings.GROUP_NAME );
			
			trace( e.user.details.name );
			ConnectionManager.dispatcher.addEventListener(ConnectionEvent.USER_ADDED, onUserAdded);
		}
		
		private function onUserAdded( e:ConnectionEvent ): void
		{
			trace( 'User added' );
			var s : Shape = new Shape();
			s.graphics.beginFill( 0xffffff );
			s.graphics.drawCircle( 100, 100, 100);
			addChild( s );
			
			trace( e.user.details.name );
		}
	}
}