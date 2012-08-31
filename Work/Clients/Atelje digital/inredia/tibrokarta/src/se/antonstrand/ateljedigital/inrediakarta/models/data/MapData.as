package se.antonstrand.ateljedigital.inrediakarta.models.data
{
	public class MapData
	{
		private var _name	:String;
		private var _source	:String;
		private var _index	:uint;
		private var _buildings	:Vector.<BuildingData>;
		
		public function MapData( p_name:String, p_source:String, p_index:uint, p_buildings:Vector.<BuildingData> )
		{
			_name = p_name;
			_source = p_source;
			_index = p_index;
			_buildings = p_buildings;
		}
		
		/**
		 * get the map name
		 **/
		public function get name(): String
		{
			return _name;
		}

		/**
		 * get the source to the map
		 **/
		public function get source(): String
		{
			return _source;
		}

		/**
		 * get the map index
		 **/
		public function get index(): uint
		{
			return _index;
		}
		
		public function get buildings(): Vector.<BuildingData>
		{
			return _buildings;
		}
	}
}