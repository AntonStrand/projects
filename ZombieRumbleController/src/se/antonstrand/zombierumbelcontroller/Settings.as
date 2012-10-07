package se.antonstrand.zombierumbelcontroller
{
	import flash.display.Stage;

	public class Settings
	{
		public static var STAGE_W	:uint;
		public static var STAGE_H	:uint;
		
		public function Settings( stage:Stage )
		{
			if( stage.fullScreenWidth > stage.fullScreenHeight )
			{
				STAGE_W = stage.fullScreenWidth;
				STAGE_H = stage.fullScreenHeight;
			}
			else
			{
				STAGE_W = stage.fullScreenHeight;
				STAGE_H = stage.fullScreenWidth;
				
			}
		}
	}
}