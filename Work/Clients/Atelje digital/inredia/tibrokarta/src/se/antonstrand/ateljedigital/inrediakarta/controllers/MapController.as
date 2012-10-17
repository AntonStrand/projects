package se.antonstrand.ateljedigital.inrediakarta.controllers
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import se.antonstrand.ateljedigital.inrediakarta.RectGfx;
	import se.antonstrand.ateljedigital.inrediakarta.Settings;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.BuildingHeaderGfx;
	import se.antonstrand.ateljedigital.inrediakarta.models.data.BuildingData;
	import se.antonstrand.ateljedigital.inrediakarta.models.data.MapData;
	import se.antonstrand.ateljedigital.inrediakarta.views.BuildingView;
	import se.antonstrand.ateljedigital.inrediakarta.views.MapView;
	import se.antonstrand.ateljedigital.inrediakarta.views.PatternGenerator;

	public class MapController extends Sprite
	{
		private var _data				:MapData;
		
		private var _buildings			:Array;
		private var _map				:MapView;
		
		private var _mouse_target		:BuildingView;
		
		private var _cur_target_idx		:int;
		
		
		
		public function MapController( p_data:MapData )
		{
			_data = p_data;

			init();
		}
		
		private function init(): void
		{
			_map = new MapView( _data );
			addChild( _map );
			
			
			addBuildings();
		}
		

		public function get isPlayingSound(): Boolean
		{
			if( _cur_target_idx >= 0 ) return BuildingView(_buildings[ _cur_target_idx ]).isPlayingSound;
			else return false;
		}
		
		
		public function get mapName(): String
		{
			return _data.name;
		}

		
		public function closeInfo( target:Sprite = null ): void
		{
			for (var i:int = 0; i < _buildings.length; i++) 
			{
				if( _buildings[i].isShowingInfo && _buildings[i] != target )
				{
					_buildings[i].removeInfo();
				}
			}
			_cur_target_idx = -1;
		}
		
		public function tweenAddBuildings(): void
		{
			// Gör om _buildings till array
			for (var i:int = 0; i < _buildings.length; i++) 
			{
				_buildings[i].scaleX = 0;
				_buildings[i].scaleY = 0;
				_buildings[i].alpha = 0;
			}
			
			TweenMax.allTo(_buildings, 1, {scaleX:1, scaleY:1, alpha:1, ease:Elastic.easeInOut}, .2); 
		}
		
		public function tweenRemoveBuildings(): void
		{
			TweenMax.allTo(_buildings, 1, {scaleX:0, scaleY:0, alpha:0, ease:Elastic.easeInOut}, .2); 	
			closeInfo();
		}
		
		
		private function addBuildings(): void
		{
			_buildings = [];
			
			for (var i:uint = 0; i < _data.buildings.length; ++i) 
			{
				_buildings.push( new BuildingView( _data.buildings[i] ));
				_buildings[i].addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown_pressDown);
				addChild( _buildings[i] );
			}
			
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp_showData);
			tweenAddBuildings();
		}
		
		private function onMouseDown_pressDown( e:Event ): void
		{
			trace( e.currentTarget);
			if( e.currentTarget is BuildingView )
			{
				_mouse_target = BuildingView( e.currentTarget );
				// För att den ska lägga sig överst
				addChild( _mouse_target );
				_mouse_target.pressedDown();
			}
		}
		
		private function onMouseUp_showData( e:Event ): void
		{

			if( _mouse_target )
			{
				closeInfo( _mouse_target );
				_mouse_target.released();

				_cur_target_idx = _buildings.indexOf( _mouse_target );
					
				if( !_mouse_target.isShowingInfo ) _mouse_target.addInfo();			
				else _mouse_target.removeInfo();
			}
			_mouse_target = null;
					
		}
		
	}
}