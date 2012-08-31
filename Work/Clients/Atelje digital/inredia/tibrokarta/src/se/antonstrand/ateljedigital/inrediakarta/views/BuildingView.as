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
	import se.antonstrand.ateljedigital.inrediakarta.models.data.BuildingData;
	
	public class BuildingView extends Sprite
	{
		
		private var _data			:BuildingData;
		private var _header			:BuildingHeaderGfx;
		
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
			x = _data.xpos;
			y = _data.ypos;

			_header = new BuildingHeaderGfx();
			_header.mouseChildren = false;
			_header.name_tf.autoSize = TextFieldAutoSize.LEFT;
			_header.name_tf.text = _data.name;
			_header.backgroundStandard.width = _header.name_tf.width + 90;
			_header.backgroundDown.width = _header.name_tf.width + 90;

			trace( _header.backgroundStandard.width );
			
			addChild( _header );
			
			_info = new BuildingInfoView( _data );
			_info.x = 30;
			_info.y = -25;
	
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
			_header.gotoAndStop( 'down' );
			_header.backgroundStandard.visible = false;
		}

		public function released(): void
		{
			_header.gotoAndStop( 'standard' );
			_header.backgroundStandard.visible = true;
		}
		
		public function addInfo(): void
		{
			if( x + _info.width > Settings.STAGE_W )
			{
				_info.positionleft();
				_info.x = -30
			}
			
			if( y + _info.height > Settings.STAGE_H )
			{
				_info.pos_up()
				_info.y = -85;
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