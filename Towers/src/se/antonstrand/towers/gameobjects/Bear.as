package se.antonstrand.towers.gameobjects
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import se.antonstrand.towers.utils.Assets;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class Bear extends GameObject
	{
		private var _sad		:Image;
		private var _happy		:Image;
		
		public function Bear(space:Space, position:Vec2=null)
		{
			super(space, position);
		}
		
		override protected function init(e:Event=null):void
		{
			super.init();
			
			_sad = new Image( Assets.getAtlas().getTexture('bear_sad'))
			
			_gfx.addChild(  _sad );
			// sätter regpunkten i mitten
			_gfx.pivotX = _gfx.width >> 1;
			_gfx.pivotY = _gfx.height >> 1;
			
			
			_body = new Body( BodyType.DYNAMIC, _position );
			_body.shapes.add( new Polygon( Polygon.rect( -_gfx.width >> 1,-_gfx.height >> 1, _gfx.width, _gfx.height ), new Material(0.1)));
			_body.graphic = _gfx;
			_body.graphicUpdate = updateGraphics;
			_body.space = _space;
			
			addChild( _body.graphic );
		}
	}
}