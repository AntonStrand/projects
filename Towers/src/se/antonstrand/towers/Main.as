package se.antonstrand.towers
{
	import flash.geom.Point;
	
	import nape.callbacks.CbType;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	
	import se.antonstrand.towers.gameobjects.Bear;
	import se.antonstrand.towers.gameobjects.GameObject;
	import se.antonstrand.towers.gameobjects.boxes.SmallBox;
	import se.antonstrand.towers.gameobjects.stones.MediumStone;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Main extends Sprite
	{
		
		private var _space			:Space;
		
		private var _gameObjects	:Vector.<GameObject>
		
		private var _collision		:CbType;
		
		
		public function Main()
		{
			if( stage ) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event = null ): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			_gameObjects = new Vector.<GameObject>();
			
			_space = new Space( new Vec2(0, 3000));
			
			
			var floor : Body = new Body( BodyType.STATIC );
			floor.shapes.add( new Polygon( Polygon.rect(0, Settings.STAGE_H - 20, Settings.STAGE_W, 20 )));
			floor.space = _space;
			
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.ENTER_FRAME, onLoop);
			
		}
		
		private function onTouch( e:TouchEvent ):void
		{
			var t:Touch = e.getTouch( stage );
			var pos:Point = t.getLocation( stage );
			
			var mouse:Vec2 = new Vec2(pos.x, pos.y);
			var bodies:BodyList = _space.bodiesUnderPoint( mouse );
			
			var target:Body;
			
			var i:int;
			
			for ( i = 0; i < bodies.length; i++ ) 
			{
				if( !bodies.at(i).isDynamic() ) continue;	
				if( target == null ) target = bodies.at(i);
			}
			
			if( target == null ) return;
			
			for ( i = 0; i < _gameObjects.length; i++) 
			{  
				if( _gameObjects[i].body == target)
				{
					//För att ta bort ett object.
					removeChild(_gameObjects[i]);
					_space.bodies.remove( target );
				}
			}
		}
		
		private function onLoop( e:Event ):void
		{
			_space.step( 1/60 );
			
			if( Math.random() < 0.03 ) addBody();
			
		}
		
		private function addBody(): void
		{
			var object : GameObject;
			
			if( Math.random() > .5 )
			{
				object = new SmallBox( _space, new Vec2( Math.random()* Settings.STAGE_W, stage.stageHeight*.5 )); 		
			}
			else if( Math.random() < .5 )
			{
				object = new MediumStone( _space, MediumStone.LAYING, new Vec2( Math.random()* Settings.STAGE_W, stage.stageHeight*.5 )); 
			}
			else
				object = new Bear( _space, new Vec2( Math.random()* Settings.STAGE_W, stage.stageHeight*.5 ));
			
			addChild( object );
			
			_gameObjects.push( object );
		}
	}
}