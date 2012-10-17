package se.antonstrand.ateljedigital.inrediakarta.controllers
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import se.antonstrand.ateljedigital.inrediakarta.Settings;
	import se.antonstrand.ateljedigital.inrediakarta.events.MenuEvent;
	import se.antonstrand.ateljedigital.inrediakarta.events.ModelEvent;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.MapName;
	import se.antonstrand.ateljedigital.inrediakarta.models.ModelDatabase;
	import se.antonstrand.ateljedigital.inrediakarta.views.MapView;
	import se.antonstrand.ateljedigital.inrediakarta.views.Menu;
	import se.antonstrand.ateljedigital.inrediakarta.views.PatternGenerator;

	public class MainController extends Sprite
	{
		private var _restartTimer	:Timer;
		
		private var _model		:ModelDatabase;
		
		private var _menu		:Menu;
		
		private var _maps		:Vector.<MapController>;
		private var _cur_map	:uint;
		private var _prev_map	:uint;
		
		public function MainController( model:ModelDatabase )
		{
			_model = model;
			
			setupTimer();
			createMenu();
			
			if( _model.isLoaded ) addContent();
			else _model.addEventListener(ModelEvent.LOADED, onModelsLoaded_addContent);
		}
		
		private function setupTimer(): void
		{
			_restartTimer = new Timer(60000 * Settings.RESTART_DELAY);
			_restartTimer.addEventListener(TimerEvent.TIMER, onRestartTimer_restart);
			_restartTimer.start();
			
			addEventListener(MouseEvent.CLICK, onClick_resetTimer);
		}
		
		
		private function createMenu(): void
		{
			_menu = new Menu();
			_menu.y = Settings.STAGE_H - 50;
			addChild( _menu );
			
			_menu.toggleButton.addEventListener(MouseEvent.CLICK, onToggleButtonClick_changeVisibleState);
		}
		
		
		private function addContent(): void
		{
			_maps = new Vector.<MapController>();
			
			for (var i:int = 0; i < _model.numOfMaps; i++) 
			{
				_maps.push( new MapController( _model.maps[i] ));
				_menu.addButton( _model.maps[i].name, i );
			}
			
			_menu.updateMapNameTo( _maps[ _cur_map ].mapName );
			addChildAt( _maps[ _cur_map ], 0 ); 
	
			_menu.addEventListener(MenuEvent.PRESSED, onMenuButtonPressed_gotoMap);
			
		}
		
		private function nextMap(): void
		{
			changeMap( 1 );
		}

		private function prevMap(): void
		{
			changeMap( -1 );
		}
		
		private function changeMap( idx:int ): void
		{	
			if( idx != _cur_map )
			{
				_prev_map = _cur_map;
				_cur_map = idx;
				
				_menu.updateMapNameTo( _maps[ _cur_map ].mapName );
				
				addChildAt( _maps[ _cur_map ], 0 ); 
				_maps[ _cur_map ].alpha = 0;
				if( contains( _maps[ _cur_map ])) TweenLite.to( _maps[ _cur_map ], .3, { alpha: 1, onComplete: removePrevMap});
	
				_maps[ _cur_map ].tweenAddBuildings();
				
				_menu.toggleButton.open();
			}
		}
		
		private function removePrevMap(): void
		{
			if( _prev_map != _cur_map )
			{
				if( contains( _maps[ _prev_map ] )) removeChild( _maps[ _prev_map ] );
				_maps[ _prev_map ].closeInfo();							
			}
		}
		
		/* EVENTS */
		private function onToggleButtonClick_changeVisibleState(e:MouseEvent):void
		{
			if( _menu.toggleButton.isVisible )
			{
				_menu.toggleButton.close();
				_maps[ _cur_map ].tweenRemoveBuildings();
			}
			else
			{
				_menu.toggleButton.open();
				_maps[ _cur_map ].tweenAddBuildings();				
			}
		}
		
		private function onModelsLoaded_addContent( e:Event ): void
		{
			_model.removeEventListener(ModelEvent.LOADED, onModelsLoaded_addContent);
			addContent();
		}
		
		private function onRestartTimer_restart( e:TimerEvent ): void
		{
			trace( 'is it playing?', _maps[ _cur_map ].isPlayingSound);
			if( !_maps[ _cur_map ].isPlayingSound )
			{
				_maps[ _cur_map ].closeInfo();	
				changeMap( 0 );
			}
			else
			{
				_restartTimer.reset();
				_restartTimer.start();
			}
			
		}

		private function onClick_resetTimer( e:MouseEvent ): void
		{
			_restartTimer.reset();
			_restartTimer.start();
		}
		
		private function onMenuButtonPressed_gotoMap( e:MenuEvent ): void
		{
			changeMap( e.index );
		}
	}
}