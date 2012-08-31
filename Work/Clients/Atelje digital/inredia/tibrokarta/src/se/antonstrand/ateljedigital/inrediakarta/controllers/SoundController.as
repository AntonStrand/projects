package se.antonstrand.ateljedigital.inrediakarta.controllers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	public class SoundController extends EventDispatcher
	{
		private var _sound		:Sound;
		private var _channel	:SoundChannel;
		
		private var _isPlaying	:Boolean;
		private var _source		:String;
		private var _stopPos	:uint;
		
		public function SoundController( source:String )
		{
			_source = source;
			loadSound();
		}
		
		public function playSound(): void
		{
			_channel = _sound.play( _stopPos );
			_isPlaying = true;
		}

		public function pauseSound(): void
		{
			_stopPos = _channel.position;
			_channel.stop();
			_isPlaying = false;
		}
		
		public function stopSound(): void
		{
			if( _channel ) _channel.stop();
			_stopPos = 0;
			_isPlaying = false;
		}
		
		public function get progress(): Number
		{
			if( _channel && _sound ) return _channel.position / _sound.length;
			else return 0;
		}
		
		public function get isPlaying(): Boolean
		{
			return _isPlaying;
		}
		
		private function loadSound(): void
		{
			_sound = new Sound();
			_sound.addEventListener(Event.COMPLETE, onComplete_dispatch);
			_sound.load( new URLRequest( _source ) );
		}
		
		private function onComplete_dispatch( e:Event ):void
		{
			dispatchEvent( new Event( Event.COMPLETE )); 
		}
	}
}