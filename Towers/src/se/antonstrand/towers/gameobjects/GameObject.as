package se.antonstrand.towers.gameobjects
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.space.Space;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameObject extends Sprite
	{
		protected var _body		:Body;
		protected var _gfx		:Sprite;
		
		protected var _space	:Space;
		protected var _position	:Vec2;
		
		public function GameObject(space:Space, position:Vec2=null)
		{
			_space = space;
			_position = position;
			
			if( stage ) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init( e:Event = null ): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_gfx = new Sprite();
		}
		
		protected function updateGraphics( b:Body ): void
		{
			this.x = b.position.x;
			this.y = b.position.y;
			this.rotation = b.rotation;
		}
		
		public function get body(): Body
		{
			return _body;
		}
	}
}