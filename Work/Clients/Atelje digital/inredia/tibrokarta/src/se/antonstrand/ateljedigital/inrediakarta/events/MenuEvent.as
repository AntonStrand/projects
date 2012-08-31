package se.antonstrand.ateljedigital.inrediakarta.events
{
	import flash.events.Event;
	
	public class MenuEvent extends Event
	{
		public static const PRESSED		:String = 'pressed';
		private var _index	:uint;
		
		public function MenuEvent(type:String, idx:uint)
		{
			super(type );
			_index =  idx;
		}
		
		public function get index(): uint
		{
			return _index;
		}
	}
}