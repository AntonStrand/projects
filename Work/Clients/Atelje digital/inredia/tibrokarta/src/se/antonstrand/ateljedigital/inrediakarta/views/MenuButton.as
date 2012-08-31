package se.antonstrand.ateljedigital.inrediakarta.views
{
	import flash.events.MouseEvent;
	
	import se.antonstrand.ateljedigital.inrediakarta.gfx.MenuButtonGfx;
	
	public class MenuButton extends MenuButtonGfx
	{
		private var _idx	:uint;
		
		public function MenuButton( p_label:String, p_idx:uint )
		{
			stop();
			mouseChildren = false;
			
			label.text = p_label;
			_idx = p_idx;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function get index(): uint
		{
			return _idx;
		}
		
		private function onMouseDown( e:MouseEvent ): void
		{
			gotoAndStop( 'down' );
		}

		private function onMouseUp( e:MouseEvent ): void
		{
			gotoAndStop( 'standard' );
		}
	}
}