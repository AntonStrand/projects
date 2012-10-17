package se.antonstrand.ateljedigital.inrediakarta
{
	import flash.filters.DropShadowFilter;

	public class Settings
	{
		public static const STAGE_W		:uint = 1920; 
		public static const STAGE_H		:uint = 1080; 

		public static const INFO_BORDER		:uint = 20; 
		public static const INFO_DISTANCE	:uint = 10; 

		public static const RESTART_DELAY	:Number = 5; 

		public static const INFO_URL		:String = '/xmls/info.xml'; 
	
		
		private static var _shadow			:DropShadowFilter;
		private static var _isShadowInit	:Boolean;
		
		
		public static function get DROP_SHADOW_FILTER(): DropShadowFilter
		{
			initShadow();
			return _shadow;
		}
		
		private static function initShadow(): void
		{
			if( !_isShadowInit )
			{
				_shadow = new DropShadowFilter(5, 45, 0, 0.5);
				_isShadowInit = true;
			}
		}
	}
}