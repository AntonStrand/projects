package se.antonstrand.zombierumbelcontroller.objects
{
	import se.antonstrand.zombierumbelcontroller.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class JoystickKnob extends Sprite
	{
		private var _thumb	:Image;
		
		public var origin_x	:int;
		public var origin_y	:int;
		
		public function JoystickKnob()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ): void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_thumb = new Image( Assets.getAtlas().getTexture( 'thumb' ));
			_thumb.pivotX = int(_thumb.texture.width *.5);
			_thumb.pivotY = int(_thumb.texture.height *.5);
			addChild( _thumb );
		}
	}
}