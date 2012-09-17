package se.antonstrand.ateljedigital.videoplayer.model
{
	public class VideoData
	{
		private var _title		:String;
		private var _source		:String;
		private var _thumb		:String;
		private var _desc		:String;
		
		public function VideoData( p_title:String, p_source:String, p_thumb:String, p_desc:String )
		{
			_title	 = p_title;
			_source	 = p_source;
			_thumb 	 = p_thumb;
			_desc 	 = p_desc;
		}
		
		public function get title(): String
		{
			return _title;
		}

		public function get source(): String
		{
			return _source;
		}

		public function get thumb(): String
		{
			return _thumb;
		}

		public function get desc(): String
		{
			return _desc;
		}
	}
}