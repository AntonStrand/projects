package se.antonstrand.ateljedigital.inrediakarta
{
	import flash.display.Sprite;
	
	public class RectGfx extends Sprite
	{
		public function RectGfx( w:uint, h:uint, color:uint = 0xFFcc00 )
		{
			graphics.beginFill( color );
			graphics.drawRect( 0, 0, w, h );
			graphics.endFill();
		}
	}
}