package se.antonstrand.ateljedigital.videoplayer.model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import se.antonstrand.ateljedigital.videoplayer.Settings;
	import se.antonstrand.ateljedigital.videoplayer.event.ModelEvent;

	public class ModelDatabase extends EventDispatcher
	{
		private var _loader 	:URLLoader;
		
		private var _models		:Vector.<VideoData>;
		
		public function ModelDatabase()
		{
			load();
		}
		
		public function get models():Vector.<VideoData>
		{
			return _models;
		}
		
		private function load(): void
		{
			_loader = new URLLoader();
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(Event.COMPLETE, onComplete_parse);
			_loader.load( new URLRequest( Settings.XML_SOURCE ));
		}
		
		private function onComplete_parse( e:Event ): void
		{
			_models = new Vector.<VideoData>();
			
			var xml:XML = new XML( _loader.data );
			var list:XMLList = new XMLList( xml.video );
			
			for each (var video:XML in list) 
			{
				trace( video.title );
				_models.push( new VideoData( video.title, video.source, video.thumb, video.desc ));
			}
			
			dispatchEvent( new ModelEvent( ModelEvent.COMPLETE ));		
		}
		
		private function onIOError( e:IOErrorEvent ): void
		{
			trace('error');
			dispatchEvent( new ModelEvent( ModelEvent.ERROR ));
		}
	}
}