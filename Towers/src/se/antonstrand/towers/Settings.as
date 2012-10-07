package se.antonstrand.towers
{
	import flash.display.Stage;

	public class Settings
	{
		public static var STAGE_W		:uint;
		public static var STAGE_H		:uint;
		
		public static function setStageSize( w:uint, h:uint ): void
		{
			STAGE_W = Math.min( w, h );
			STAGE_H = Math.max( w, h );
		}
	}
}