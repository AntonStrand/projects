package se.antonstrand.ateljedigital.inrediakarta.events
{
	import flash.events.Event;
	
	public class ModelEvent extends Event
	{
		public static const LOADED		:String = 'loaded';
		
		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}