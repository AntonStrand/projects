package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import net.hires.debug.Stats;
	
	import se.antonstrand.zombierumble.Main;
	import se.antonstrand.zombierumble.Settings;
	import se.antonstrand.zombierumble.events.ConnectionEvent;
	import se.antonstrand.zombierumble.utils.ConnectionManager;
	
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
			ConnectionManager.connect( Settings.GROUP_NAME, {} );
		}
		
		private function onConnected_initGame( e:ConnectionEvent ): void
		{
			var star:Starling = new Starling( Main, stage );
			star.antiAliasing = 1;
			star.start();
			
			trace( Settings.GROUP_NAME );
		}
	}
}