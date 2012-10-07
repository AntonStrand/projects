package se.antonstrand.zombierumbelcontroller.objects
{

	
	import flash.geom.Point;
	
	import se.antonstrand.zombierumbelcontroller.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Joystick extends Sprite
	{
		private var _thumb		:JoystickKnob;
		private var _pad		:Image;
		
		private var _radius		:uint;
		
		private var _degrees	:Number;
		
		private var _isAiming	:Boolean;
		private var _isShooting	:Boolean;
		
		public function Joystick()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage( e:Event ): void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createGraphics();
		}
		
		private function createGraphics(): void
		{
			_pad = new Image( Assets.getAtlas().getTexture( 'shoot_plate' ));
			_pad.pivotX = _pad.texture.width *.5;
			_pad.pivotY = _pad.texture.height *.5;
			addChild( _pad );

			_thumb = new JoystickKnob();
			_thumb.origin_x = 0;
			_thumb.origin_y = 0;
			addChild( _thumb );
			
			_radius = _pad.texture.width * .3;
			
			_thumb.addEventListener(TouchEvent.TOUCH, onTouchThumb);
		}
		
		public function get degrees(): Number
		{
			return _degrees;
		}

		public function get isShooting(): Boolean
		{
			return _isShooting;
		}
		
		public function update(): void
		{
			if( !_isAiming )
			{
				if( _thumb.x != _thumb.origin_x ) _thumb.x += (_thumb.origin_x - _thumb.x) *.3;
				if( _thumb.y != _thumb.origin_y ) _thumb.y += (_thumb.origin_y - _thumb.y) *.3;
				if( _degrees!= 0 ) _degrees += (0 - _degrees);
				_isShooting = false;
			}
			
			trace( _degrees, _isShooting );
		}
		
		
		private function onTouchThumb( e:TouchEvent ): void
		{
			var touch : Touch = e.getTouch( this );
			//trace( touch );
			
			switch( touch.phase )
			{
				case TouchPhase.BEGAN:
				case TouchPhase.MOVED:
				case TouchPhase.STATIONARY:
					
					_isAiming = true;
					_thumb.x = touch.globalX - x;
					_thumb.y = touch.globalY - y;
					
					// Store the current x/y of the knob
					var _currentX		:Number = _thumb.x;
					var _currentY		:Number = _thumb.y;
					
					// Store the registration point of the surrounding 'joystick holder'
					var _registrationX	:Number = _pad.x;
					var _registrationY	:Number = _pad.y;
					
					// Subtract the two from each other to get the actual x/y
					var _actualX	:Number = _currentX - _registrationX;
					var _actualY	:Number =  _currentY - _registrationY;
					
					// Calculate the degrees for use when creating the zones.
					_degrees = Math.round(Math.atan2(_actualY, _actualX) * 180/Math.PI);
					
					// Calculate the radian value of the knobs current position
					var _angle 		:Number = _degrees * (Math.PI / 180);
					
					// As we want to lock the orbit of the knob we need to calculate x/y at the maximum distance
					var _maxX		:Number = Math.round((_radius * Math.cos(_angle)) + _registrationX);
					var _maxY		:Number = Math.round((_radius * Math.sin(_angle)) + _registrationY);
					
					_isShooting = false;						
					// Check to make sure that the value is positive or negative 
					if(_currentX > 0 && _currentX > _maxX || _currentX < 0 && _currentX < _maxX)
					{
						_thumb.x = _maxX;
					}
					
					if(_currentY > 0 && _currentY > _maxY || _currentY < 0 && _currentY < _maxY)
					{
						_thumb.y = _maxY;					
					}
					
					if( _thumb.x == _maxX || _thumb.y == _maxY ) _isShooting = true; 
					
					break;
				
				case TouchPhase.ENDED:
					_isAiming = false;
					break;
			}
		}
	}
}