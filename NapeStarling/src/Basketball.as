package
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Basketball extends Sprite
	{
		[Embed(source="basketball.png")]
		private var basketball:Class;
		
		public function Basketball()
		{
			addChild( Image.fromBitmap( new basketball ));
			
			pivotX = width >> 1;
			pivotY = height >> 1;
		}
	}
}