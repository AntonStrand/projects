package se.antonstrand.ateljedigital.inrediakarta.views
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import se.antonstrand.ateljedigital.inrediakarta.gfx.BuildingHeaderGfx;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.BuildingHeaderInvertedGfx;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.BuildingHeaderUpGfx;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.BuildingHeaderUpInvertedGfx;
	
	public class BuildingHeader extends Sprite
	{
		/* -- Const -- */
		public static const NORMAL		:String = 'normal';
		public static const INVERTED	:String = 'inverted';
		public static const UP			:String = 'up';
		public static const INVERTED_UP	:String = 'invertedUp';
		
		private var _arrow			:MovieClip;
		
		private var _label			:String;
		private var _direction		:String;
		
		private var _isInit			:Boolean;	
		
		public function BuildingHeader( label:String ,direction:String = NORMAL )
		{
			_label = label;
			_direction = direction;
			
			trace( _direction, direction )
			
			if( direction == NORMAL ) init( BuildingHeaderGfx );
			else if( direction == INVERTED ) init( BuildingHeaderInvertedGfx );
			else if( direction == UP ) init( BuildingHeaderUpGfx );
			else if( direction == INVERTED_UP ) init( BuildingHeaderUpInvertedGfx );
		}
		
		
		public function pressedDown(): void
		{
			if( _isInit )
			{
				_arrow.gotoAndStop( 'down' );
				_arrow.backgroundStandard.visible = false;			
			}
		}
		
		public function released(): void
		{
			if( _isInit )
			{
				_arrow.gotoAndStop( 'standard' );
				_arrow.backgroundStandard.visible = true;			
			}
		}
		
		public function get icon(): MovieClip
		{
			return _arrow.icon;
		}
		
		private function init( type:Class ): void
		{
			_arrow = new type();
			_arrow.mouseChildren = false;
			addChild( _arrow );
			_isInit = true;
			
			_arrow.name_tf.autoSize = TextFieldAutoSize.LEFT;
			_arrow.name_tf.text = _label;
			
			if( _direction == INVERTED || _direction == INVERTED_UP )
			{
				_arrow.name_tf.x = -(_arrow.name_tf.width + 30);
			}
			
			_arrow.backgroundStandard.width = _arrow.name_tf.width + 60;
			_arrow.backgroundDown.width = _arrow.name_tf.width + 60;
			
		}
	}
}