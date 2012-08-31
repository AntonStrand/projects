package se.antonstrand.ateljedigital.inrediakarta.views
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import se.antonstrand.ateljedigital.inrediakarta.RectGfx;
	
	public class PatternGenerator extends Sprite
	{
		private var _gfx		:Sprite;
		
		private var _width		:uint;
		private var _rowHeight 	:uint;
		private var _rows		:uint;
		
		private var _colors	:Vector.<uint>;
		
		
		public function PatternGenerator( w:uint = 0, rows:uint = 1, rowHeight:uint =10, bmd:BitmapData = null )
		{
			_width = w;
			_rows = rows;
			_rowHeight = rowHeight;
			
			_gfx = new Sprite();
			addChild( _gfx );
			
			if( !bmd )
			{
				addColors();
				generate();
			}
			else {
				setBitmapData( bmd );
			}
		}

		public function get bitmapData(): BitmapData
		{
			
			var bmd : BitmapData = new BitmapData( this.width, this.height );
			bmd.draw(_gfx);
			
			return bmd;
		}

		public function setBitmapData( bmd:BitmapData ): void
		{
			var bmp : Bitmap = new Bitmap(bmd);
			_gfx.addChild( bmp );
		}
		
		private function addColors(): void
		{
			_colors = new Vector.<uint>();
			//_colors.push( 0xffffff );
			_colors.push( 0x000000 );
			_colors.push( 0x5b4266 );
			_colors.push( 0x5b4266 );
			_colors.push( 0x5b4266 );
			_colors.push( 0x60b270 );
			_colors.push( 0xaa60b270 );
			_colors.push( 0x60b270 );
			_colors.push( 0xddc655 );
			_colors.push( 0xaaddc655 );
			_colors.push( 0xddc655 );
			_colors.push( 0xe17573 );
			_colors.push( 0xaae17573 );
			_colors.push( 0xe17573 );
		}
		
		private function generate(): void
		{
			for (var i:int = 0; i < _rows; i++) 
			{
				var row	: Sprite = new Sprite();
				while( row.width < _width )
				{
					var color : uint = Math.random()* _colors.length -1;
					var pattern : RectGfx = new RectGfx( Math.random()* 100 + 25, _rowHeight, _colors[ color ]);
					pattern.x = row.width;
					row.addChild( pattern );
				}
				var bmd:BitmapData = new BitmapData( _width, _rowHeight );
				bmd.draw( row );
				var bmp : Bitmap = new Bitmap( bmd );
				//row.width = _width;
				bmp.y = this.height;
				_gfx.addChild( bmp );
			}
			
		}
		
		
	}
}