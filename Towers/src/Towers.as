package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import net.hires.debug.Stats;
	
	import se.antonstrand.towers.Main;
	import se.antonstrand.towers.Settings;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", backgroundColor="0x555555")]
	public class Towers extends Sprite
	{
		public function Towers()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			if( stage ) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init( e:Event = null ): void
		{
			addChild( new Stats() );
			
			Settings.setStageSize( stage.stageWidth, stage.stageHeight );
			
			trace( Settings.STAGE_W, Settings.STAGE_H );
			
			Starling.handleLostContext = true;
			
			var star:Starling = new Starling(Main, stage);
			star.start();
		}
	}
}