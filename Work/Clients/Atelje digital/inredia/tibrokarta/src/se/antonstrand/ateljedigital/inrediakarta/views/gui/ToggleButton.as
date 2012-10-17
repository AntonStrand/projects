package se.antonstrand.ateljedigital.inrediakarta.views.gui
{
	import flash.events.MouseEvent;
	
	import se.antonstrand.ateljedigital.inrediakarta.gfx.ToggleButtonGfx;
	
	public class ToggleButton extends ToggleButtonGfx
	{
		private var _isVisible 		:Boolean;
		
		public function ToggleButton()
		{
			mouseChildren = false;
			
			_isVisible = true;
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function mouseDown(e:MouseEvent): void
		{
			gotoAndStop( 'down' );
			backgroundStandard.visible = false;
		}

		private function mouseUp(e:MouseEvent): void
		{
			gotoAndStop( 'standard' );	
			backgroundStandard.visible = true;
		}
		
		public function open(): void
		{
			icon.gotoAndPlay( 'open' );
			name_tf.text = 'Visar pilar';
			_isVisible = true;
		}

		public function close(): void
		{
			icon.gotoAndPlay( 'close' );
			name_tf.text = 'Döljer pilar';
			_isVisible = false;
		}
		
		public function get isVisible(): Boolean
		{
			return _isVisible;
		}
	}
}