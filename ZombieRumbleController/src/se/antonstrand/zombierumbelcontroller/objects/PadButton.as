package se.antonstrand.zombierumbelcontroller.objects
{
	import se.antonstrand.zombierumbelcontroller.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class PadButton extends Sprite
	{
		public static const	LEFT	:String = 'left';
		public static const	RIGHT	:String = 'right';
		public static const	UP		:String = 'up';
		public static const	DOWN	:String = 'down';
		
		private var _standard		:Image;
		private var _down			:Image;

		private var _type			:String;
		
		public function PadButton( type:String )
		{
			_type = type;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createGraphics();
		}
		
		private function createGraphics(): void
		{
			_down = new Image( Assets.getAtlas().getTexture( _type + '_down_button' ));
			_down.pivotX = int( _down.texture.width *.5 );
			_down.pivotY = int( _down.texture.height *.5 );
			addChild( _down );

			_standard = new Image( Assets.getAtlas().getTexture( _type + '_standard_button' ));
			_standard.pivotX = int( _standard.texture.width *.5 );
			_standard.pivotY = int( _standard.texture.height *.5 );
			addChild( _standard );
		}
		
		public function standardState(): void
		{
			_down.visible = false;
			_standard.visible = true;
		}

		public function downState(): void
		{
			_standard.visible = false;
			_down.visible = true;
		}
	}
}