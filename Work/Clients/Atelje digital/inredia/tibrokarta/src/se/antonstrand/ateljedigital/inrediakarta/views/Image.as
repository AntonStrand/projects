package se.antonstrand.ateljedigital.inrediakarta.views
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class Image extends Sprite
	{
		public static const LOADED	:String = 'loaded';
		private var _imageLoader	:Loader;
		private var _source			:String;
		
		public function Image( source:String )
		{
			_source = source;
			loadImage();
		}
		
		private function loadImage(): void
		{
			_imageLoader = new Loader();
			_imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete_displayImage);
			_imageLoader.load( new URLRequest( _source ));
		}
		
		private function onComplete_displayImage( e:Event ):void
		{
			_imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete_displayImage);
			
			addChild( _imageLoader );
			trace('inside:', width );
			dispatchEvent( new Event( LOADED ));

		}
	}
}