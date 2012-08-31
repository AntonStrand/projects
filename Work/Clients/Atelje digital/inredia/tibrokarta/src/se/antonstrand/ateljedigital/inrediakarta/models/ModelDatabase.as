package se.antonstrand.ateljedigital.inrediakarta.models
{
	import flash.events.EventDispatcher;
	
	import se.antonstrand.ateljedigital.inrediakarta.events.ModelEvent;
	import se.antonstrand.ateljedigital.inrediakarta.models.data.MapData;
	import se.antonstrand.ateljedigital.inrediakarta.views.MapView;

	public class ModelDatabase extends EventDispatcher
	{
		
		private var _mapLoader	:DataLoader;
		private var _isLoaded	:Boolean;
		
		public function ModelDatabase()
		{
			init();
		}
		
		public function get isLoaded(): Boolean
		{
			return _isLoaded;
		}
		
		public function get maps(): Vector.<MapData>
		{
			return _mapLoader.maps;
		}

		public function get numOfMaps(): uint
		{
			return _mapLoader.maps.length;
		}
	
		private function init(): void
		{
			_mapLoader = new DataLoader();
			_mapLoader.addEventListener(ModelEvent.LOADED, onContentLoaded_dispatch);
		}
		
		private function onContentLoaded_dispatch( e:ModelEvent ): void
		{
			_isLoaded = true;
			dispatchEvent( new ModelEvent( ModelEvent.LOADED ));
		}
	}
}