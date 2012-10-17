package se.antonstrand.ateljedigital.inrediakarta.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import se.antonstrand.ateljedigital.inrediakarta.Settings;
	import se.antonstrand.ateljedigital.inrediakarta.events.ModelEvent;
	import se.antonstrand.ateljedigital.inrediakarta.models.data.BuildingData;
	import se.antonstrand.ateljedigital.inrediakarta.models.data.MapData;

	/**
	 * Loads in all the mapdata
	 * 
	 * @author Apos28 (Anton Strand)
	 **/
	public class DataLoader extends EventDispatcher
	{
		private var _urlLoader	:URLLoader;
		private var _maps		:Vector.<MapData>;
		
		public function DataLoader()
		{
			init();
		}
		
		/**
		 * get mapdata
		 **/
		public function get maps(): Vector.<MapData>
		{
			return _maps;
		}
		
		private function init(): void
		{
			_maps = new Vector.<MapData>();
			
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, onMapsLoaded_parse);
			_urlLoader.load(new URLRequest( Settings.INFO_URL ));
		}
		
		private function onMapsLoaded_parse( e:Event ): void
		{
			_urlLoader.removeEventListener(Event.COMPLETE, onMapsLoaded_parse);
			var xml:XML = new XML( _urlLoader.data );
			var mapList:XMLList = new XMLList( xml.map );
			
			for each (var map:XML in mapList) 
			{
				var buildings : Vector.<BuildingData> = new Vector.<BuildingData>();
				var buildingList:XMLList = new XMLList( map.building );
				
				for each (var b:XML in buildingList)
				{
					buildings.push( new BuildingData( b.name, b.desc, b.image, b.sound, b.qr, b.arrowDir, b.xpos, b.ypos ));
				}
			
				_maps.push( new MapData( map.name, map.source, map.index, buildings ) ); 
			}
			
			dispatchEvent( new ModelEvent( ModelEvent.LOADED ));
		}
	}
}