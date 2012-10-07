package multicamera
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class MultiCamera extends Sprite
	{
		private var _world			:DisplayObject;
		private var _focusPoints	:Vector.<Point>;
		
		private var _stageBounderies	:Rectangle;
		private var _innerBounderies	:Rectangle;
		
		private var _minPos			:Point;
		private var _maxPos			:Point;
		private var _prevPos		:Point;
		
		private var _prevScale		:Number = 1;
		
		public function MultiCamera(world:DisplayObject, stageBounderies:Rectangle, innerBounderies:Rectangle = null)
		{
 			_world = world;
			_stageBounderies = stageBounderies;
			( innerBounderies ) ? _innerBounderies = innerBounderies : _innerBounderies = new Rectangle( _stageBounderies.width *.25, _stageBounderies.height*.25, _stageBounderies.width*.5, _stageBounderies.height*.5 );
			
			_minPos = new Point();
			_maxPos = new Point();
			_prevPos = new Point();
		}
		
		public function setFocusPoints( vec:Vector.<Point> ): void
		{
			_focusPoints = vec;
		}
		
		public function render( focusPoints:Vector.<Point> = null ): void
		{
			if( focusPoints ) _focusPoints = focusPoints; 
			
			if( _focusPoints )
			{
				var scaleOffset:Number;
				var offsetX:Number = (getMidpointX() - _world.width*.5) -_prevPos.x;
				var offsetY:Number = (getMidpointY() - _world.height*.5) -_prevPos.y;

				//trace(_maxPos.x - _minPos.x, _innerBounderies.width);
				
				if( _maxPos.x - _minPos.x > _innerBounderies.width ) 
				{
					scaleOffset = ((_maxPos.x - _minPos.x) / _world.width) - _prevScale;
					_world.scaleX = _world.scaleY += scaleOffset *.1;
				}
				else if( _maxPos.y - _minPos.y > _innerBounderies.height ) 
				{
					scaleOffset = ((_maxPos.y - _minPos.y) / _world.height) - _prevScale;
					_world.scaleX = _world.scaleY += scaleOffset *.1;
				}
				
				_world.x += offsetX *.5;
				_world.y += offsetY *.5;
				
				if( _world.x > _stageBounderies.x ) _world.x = _stageBounderies.x;
				if( _world.x + _world.width < _stageBounderies.right ) _world.x = _stageBounderies.right - _world.width;

				if( _world.y > _stageBounderies.y ) _world.y = _stageBounderies.y;
				if( _world.y + _world.height < _stageBounderies.bottom ) _world.y = _stageBounderies.bottom - _world.height;
				
				_prevPos.x = getMidpointX() - _world.width*.5;
				_prevPos.y = getMidpointY() - _world.height*.5;
				
				_prevScale = _world.scaleX;
			}
		}
		
		
		private function getMidpointX(): Number		{
			var positions : Array = [];
			
			for (var i:int = 0; i < _focusPoints.length; i++) 
			{
				positions[i] = _focusPoints[i].x;
			}
			
			_minPos.x = Math.min.apply(null, positions);
			_maxPos.x = Math.max.apply(null, positions);
				
			return (_minPos.x + _maxPos.x)/2 +.5;
		}
		
		private function getMidpointY(): Number
		{
			var positions : Array = [];
			
			for (var i:int = 0; i < _focusPoints.length; i++) 
			{
				positions[i] = _focusPoints[i].y;
			}
			
			_minPos.y = Math.min.apply(null, positions);
			_maxPos.y = Math.max.apply(null, positions);
			
			return (_minPos.y + _maxPos.y)/2 + .5;
		}
		
	}
}