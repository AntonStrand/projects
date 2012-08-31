package se.antonstrand.ateljedigital.inrediakarta.views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import se.antonstrand.ateljedigital.inrediakarta.controllers.SoundController;
	import se.antonstrand.ateljedigital.inrediakarta.gfx.SoundPlayerGfx;
	
	public class SoundPlayer extends SoundPlayerGfx
	{
		private var _sc		:SoundController;
		
		public function SoundPlayer( sc:SoundController )
		{
			_sc = sc;
			_sc.addEventListener(Event.COMPLETE, onComplete_addListeners);
		}
		
		public function get isPlayingSound(): Boolean
		{
			return _sc.isPlaying;
		}
		
		public function stopSound(): void
		{
			_sc.stopSound();
		}
		
		private function onComplete_addListeners( e:Event ): void
		{
			_sc.removeEventListener(Event.COMPLETE, onComplete_addListeners);
			
			playButton.addEventListener(MouseEvent.MOUSE_DOWN, onPlayButtonDown_playSound);
			playButton.addEventListener(MouseEvent.MOUSE_UP, onPlayButtonUp);

			stopButton.addEventListener(MouseEvent.MOUSE_DOWN, onStopButtonDown_stopSound);
			stopButton.addEventListener(MouseEvent.MOUSE_UP, onStopButtonUp);
			
			addEventListener(Event.ENTER_FRAME, onLoop);
		}
		
		private function onStopButtonDown_stopSound( e:MouseEvent ):void
		{
			if( stopButton.currentFrameLabel == 'standard' )
			{
				stopButton.gotoAndStop( 'down' );
				playButton.gotoAndStop( 'playStandard' );
				if( _sc.isPlaying ) _sc.stopSound();
			}
		}		

		private function onStopButtonUp( e:MouseEvent ):void
		{
			if( stopButton.currentFrameLabel == 'down' )
			{
				stopButton.gotoAndStop( 'standard' );
			}
		}		
		
		private function onPlayButtonDown_playSound( e:Event ): void
		{
			if( playButton.currentFrameLabel == 'playStandard' )
			{
				playButton.gotoAndStop( 'playDown' );
				if( !_sc.isPlaying ) _sc.playSound();
			}

			if( playButton.currentFrameLabel == 'pauseStandard' )
			{
				playButton.gotoAndStop( 'pauseDown' );
				if( _sc.isPlaying ) _sc.pauseSound();
			}
		}
		

		private function onPlayButtonUp( e:MouseEvent ):void
		{
			if( playButton.currentFrameLabel == 'playDown' )
			{
				playButton.gotoAndStop( 'pauseStandard' );
			}

			if( playButton.currentFrameLabel == 'pauseDown' )
			{
				playButton.gotoAndStop( 'playStandard' );
			}			
		}
		
		
		private function onLoop( e:Event ): void
		{
			if( _sc ) thumb.scaleX = _sc.progress;
		}
	}
}