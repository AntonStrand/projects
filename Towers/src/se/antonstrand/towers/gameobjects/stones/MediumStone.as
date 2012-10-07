package se.antonstrand.towers.gameobjects.stones
{
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import se.antonstrand.towers.gameobjects.GameObject;
	import se.antonstrand.towers.utils.Assets;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class MediumStone extends GameObject
	{
		public static const LAYING	:String = 'laying';
		public static const STANDING:String = 'standing';
		
		private var _type 	:String;
		
		public function MediumStone(space:Space, type:String = LAYING, position:Vec2=null)
		{
			_type = type;
			
			super(space, position);
		}
		
		override protected function init( e:Event = null ): void
		{
			super.init();
			
			_gfx.addChild( new Image( Assets.getAtlas().getTexture('medium_' + _type)) );
			// sätter regpunkten i mitten
			_gfx.pivotX = _gfx.width >> 1;
			_gfx.pivotY = _gfx.height >> 1;
			
			
			_body = new Body( BodyType.DYNAMIC, _position );
			_body.shapes.add( new Polygon( Polygon.rect( -_gfx.width >> 1,-_gfx.height >> 1, _gfx.width, _gfx.height ), new Material(-2, 2, 2, 2 )));
			_body.graphic = _gfx;
			_body.graphicUpdate = updateGraphics;
			_body.space = _space;
			
			addChild( _body.graphic );
			
		}
	}
}