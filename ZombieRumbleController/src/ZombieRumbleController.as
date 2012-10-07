package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import se.antonstrand.zombierumbelcontroller.Main;
	import se.antonstrand.zombierumbelcontroller.Settings;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", backgroundColor="0x222222")]
	public class ZombieRumbleController extends Sprite
	{
		public function ZombieRumbleController()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			
			trace( 'width:', stage.fullScreenWidth );
			trace( 'height:', stage.fullScreenHeight );
			stage.addEventListener(Event.RESIZE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ): void
		{
			stage.removeEventListener(Event.RESIZE, onAddedToStage);
			trace( 'resize' );
			
			var settings : Settings = new Settings( stage );
			
			
			var star : Starling = new Starling(Main, stage, new Rectangle( 0, 0, Settings.STAGE_W, Settings.STAGE_H ));
			star.antiAliasing = 1;
			star.start();
			
		}
	}
}