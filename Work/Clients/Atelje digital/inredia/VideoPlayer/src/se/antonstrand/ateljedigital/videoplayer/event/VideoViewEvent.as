package se.antonstrand.ateljedigital.videoplayer.event
{
	import flash.events.Event;
	
	public class VideoViewEvent extends Event
	{
		public static const LOADED			:String = 'loaded';
		public static const NOT_LOADED		:String = 'notLoaded';
		public static const ERROR			:String = 'error';
		
		public function VideoViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}