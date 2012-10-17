package se.antonstrand.ateljedigital.inrediakarta.views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quart;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	
	import se.antonstrand.ateljedigital.inrediakarta.Settings;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.BuildingHeaderGfx;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.BuildingHeaderInvertedGfx;
	import se.antonstrand.ateljedigital.inrediakarta.models.data.BuildingData;
	
	public class BuildingView extends Sprite
	{
		
		private var _data			:BuildingData;
		private var _header			:BuildingHeader;
		
		private var _imgLoader		:Loader;
		private var _info			:BuildingInfoView;
		
		private var _showingInfo	:Boolean;
		
		public function BuildingView( p_data:BuildingData )
		{
			_data = p_data;
			init();
		}
		
		private function init(): void
		{	
			filters = [ Settings.DROP_SHADOW_FILTER ]; 
			

			_header = new BuildingHeader( _data.name, data.arrowDir );
			
			x = _data.xpos;
			y = _data.ypos;

			addChild( _header );
			
			_info = new BuildingInfoView( _data );
			_info.x = 30;
			_info.y = -25;
			
			if ( data.arrowDir == BuildingHeader.UP || data.arrowDir == BuildingHeader.INVERTED_UP)
			{
				_info.x = 30;
				_info.y	= 65;
			}
	
		}

		public function get isPlayingSound(): Boolean
		{
			return _info.isPlayingSound;
		}
		
		public function get isShowingInfo(): Boolean
		{
			return _showingInfo;
		}
		
		public function get data(): BuildingData
		{
			return _data;
		}
		
		public function pressedDown(): void
		{
			_header.pressedDown();
		}

		public function released(): void
		{
			_header.released();
		}
		
		public function addInfo(): void
		{
			if( x + _info.width > Settings.STAGE_W )
			{
				_info.positionleft();
				_info.x = -30
				
			}
			
			if( y + _info.height > Settings.STAGE_H - 50)
			{
				_info.pos_up()
				_info.y = -85;
				
				if ( data.arrowDir == BuildingHeader.UP || data.arrowDir == BuildingHeader.INVERTED_UP)
				{
					_info.y	= 25;
				}
			}			

			_showingInfo = true;
			_info.alpha = 0;
			_info.scaleX = _info.scaleY = 0;
			addChild( _info );
			_header.icon.gotoAndPlay('open');
			TweenLite.to( _info, .5, {scaleX:1, scaleY:1, alpha:1, ease:Quart.easeInOut});
		}

		public function removeInfo(): void
		{
			_showingInfo = false;
			_header.icon.gotoAndPlay('close');
			TweenLite.to( _info, .5, {scaleX:0, scaleY:0, alpha:0, ease:Quart.easeInOut, onComplete:removeInfoGfx});
		}
		
		private function removeInfoGfx(): void
		{
			_info.deactivate();
			if( contains( _info )) removeChild( _info );			
		}
	}
}