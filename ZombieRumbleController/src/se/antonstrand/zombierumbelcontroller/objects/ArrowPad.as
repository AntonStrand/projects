package se.antonstrand.zombierumbelcontroller.objects
{
	import se.antonstrand.zombierumbelcontroller.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ArrowPad extends Sprite
	{
		private var _pad			:Image;
		
		private var _leftButton		:PadButton;
		private var _rightButton	:PadButton;
		private var _upButton		:PadButton;
		private var _downButton		:PadButton;
		
		public function ArrowPad()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createGraphics();
		}
		
		private function createGraphics(): void
		{
			_pad = new Image( Assets.getAtlas().getTexture( 'move_plate' ));
			_pad.pivotX = _pad.texture.width * .5;
			_pad.pivotY = _pad.texture.height * .5;
			addChild( _pad );
		}
		
		private function createButtons(): void
		{
			_leftButton = new PadButton( PadButton.LEFT );
			//_leftButton.x = 
		}
	}
}