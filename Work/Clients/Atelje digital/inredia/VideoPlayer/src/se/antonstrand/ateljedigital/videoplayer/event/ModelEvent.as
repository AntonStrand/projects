package se.antonstrand.ateljedigital.videoplayer.event
{
	import flash.events.Event;
	
	public class ModelEvent extends Event
	{
		public static const COMPLETE 	:String = 'complete';
		public static const ERROR	 	:String = 'error';
		
		
		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}