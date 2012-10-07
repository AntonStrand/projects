package
{
	import flash.display.DisplayObject;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.space.Space;
	
	import starling.display.Sprite;
	
	public class PhysicBall extends Sprite
	{
		private var _body:Body;
		
		public function PhysicBall(space:Space = null, position:Vec2=null)
		{
			
			_body = new Body(BodyType.DYNAMIC, position);	
			_body.shapes.add( new Circle(51.5, null, new Material(2)));
			_body.graphic = new Basketball;
			addChild(_body.graphic);
			_body.space = space;
			
			_body.graphicUpdate = updateGraphics;
			
		}
		
		public function get body(): Body
		{
			return _body;
		}
		
		private function updateGraphics(b:Body):void
		{
			x = b.position.x;
			y = b.position.y;
			rotation  = b.rotation;
		}
	}
}