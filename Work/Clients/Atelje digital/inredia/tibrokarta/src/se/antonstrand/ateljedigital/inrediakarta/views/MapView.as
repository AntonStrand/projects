package se.antonstrand.ateljedigital.inrediakarta.views
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import se.antonstrand.ateljedigital.inrediakarta.RectGfx;
	import se.antonstrand.ateljedigital.inrediakarta.Settings;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.Arrow;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.MapName;
	import se.antonstrand.ateljedigital.inrediakarta.models.data.MapData;
	
	public class MapView extends Sprite
	{
		
		
		private var _data			:MapData;

		private var _mapLoader		:Loader;
	
		
		private var _menuPattern	:Bitmap;
		
		public function MapView( data:MapData )
		{
			_data = data;	
			
			init();
		}
		
		private function init(): void
		{

			_mapLoader = new Loader();
			_mapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete_addMap);
			_mapLoader.load( new URLRequest( _data.source ));
			
		}
		
		private function onComplete_addMap( e:Event ): void
		{
			//_mapLoader.scaleX = _mapLoader.scaleY = (Settings.STAGE_H -50)/_mapLoader.height;
			addChild( _mapLoader );
			_mapLoader = null;

		}
		
	}
}