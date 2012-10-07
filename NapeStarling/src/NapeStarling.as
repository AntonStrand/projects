package
{
	import flash.display.Sprite;
	
	import nape.geom.Vec2;
	import nape.space.Space;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;

	[SWF(frameRate="60", width=800, height="600")]
	public class NapeStarling extends Sprite
	{
		
		public function NapeStarling()
		{
			var star:Starling = new Starling(Main, stage);
			star.start();
		}
		
		
	}
}