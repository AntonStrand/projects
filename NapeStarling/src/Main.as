package
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Main extends Sprite
	{
		[Embed(source="back.png")]
		private var back:Class;
		
		private var _space		:Space;
		
		private var _hand	:PivotJoint;
		
		private var _balls	:Array;
		
		
		public function Main()
		{
			if( stage ) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event = null ): void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_balls = [];
			
			addChild( Image.fromBitmap( new back ));
			
			_space = new Space( new Vec2( 0, 3000 ));
			
			var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add( new Polygon(Polygon.rect(0, 600, 800, 20)));
			floor.space = _space;
			
			
			_hand = new PivotJoint(_space.world, _space.world, new Vec2(), new Vec2());
			_hand.active = false;
			_hand.space = _space;
			_hand.stiff = false;
			_hand.frequency = 4;
			_hand.maxForce = 60000;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var t:Touch = e.getTouch(stage);
			var pos:Point = t.getLocation(stage);
			
			if( t.phase == TouchPhase.BEGAN )
			{
				trace( 'click', e.currentTarget );
				
				var mouse:Vec2 = new Vec2(pos.x, pos.y);
				var bodies:BodyList = _space.bodiesUnderPoint( mouse );
				
				var grab:Body;
				
				for (var i:int = 0; i < bodies.length; i++) 
				{
					trace('loop', bodies.at(i));
					if( !bodies.at(i).isDynamic() ) continue;
					
	
						
					
					if( grab == null )grab = bodies.at(i);
					
					
				}
				
				if( grab == null ) return;
				
				/*_hand.body2 = grab;
				_hand.anchor2 = grab.worldToLocal( mouse );
				_hand.active = true;
				
				trace( 'obj:',grab );*/
				
				// Loopar igenom alla bollar för att se vilken boll som ska tas bort
				for (var j:int = 0; j < _balls.length; j++) 
				{  
					if( _balls[j].body == grab)
					{
						//För att ta bort en boll.
						removeChild(_balls[j]);
						_space.bodies.remove( grab );
					}
				}
				
				
				
				
			}
			
			if( t.phase == TouchPhase.ENDED ) _hand.active = false;
			
			
			_hand.anchor1.setxy( pos.x, pos.y );
			
			
		}
		
		private function loop(e:Event):void
		{
			_space.step(1/60);
			
			if(Math.random() < .03)
				addBall();
			
		}
		
		private function addBall():void
		{
			var ball:PhysicBall = new PhysicBall( _space, new Vec2(Math.random()* 750, 100 ));	
			addChild( ball );
			_balls.push( ball );
		}
		
	}
}