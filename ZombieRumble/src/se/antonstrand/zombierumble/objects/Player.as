package se.antonstrand.zombierumble.objects
{
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	public class Player extends Sprite
	{
		/* graphics properties */
		private var _animations		:Vector.<MovieClip>;
		
		// Body animations
		private var _idle_body_mc			:MovieClip;
		private var _run_body_mc			:MovieClip;
		private var	_runBackward_body_mc	:MovieClip;
		private var _jump_body_mc			:MovieClip;
		
		// Head animations
		
		/* properties */
		private var	_type			:uint;
		private var _speed			:uint;
		private var _health			:uint;
		private var _killCount		:uint;
		private var _deathCount		:uint;

		public function Player()
		{
			super();
		}
		
		private function hideAnimations(): void
		{
			for (var i:int = 0; i < _animations.length; i++) 
			{
				_animations[i].visible = false;
			}
		}
	}
}