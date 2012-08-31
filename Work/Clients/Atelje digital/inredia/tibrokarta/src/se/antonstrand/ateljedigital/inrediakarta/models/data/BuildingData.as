package se.antonstrand.ateljedigital.inrediakarta.models.data
{
	public class BuildingData
	{
		private var _xpos		:int;
		private var _ypos		:int;

		private var _name		:String;
		private var _desc		:String;
		private var _image_src	:String;
		private var _sound_src	:String;
		private var _qr_src		:String;
		
		public function BuildingData( p_name:String, p_desc:String, p_image:String, p_sound:String, p_qr:String, p_xpos:uint, p_ypos:uint )
		{
			_xpos = p_xpos;
			_ypos = p_ypos;

			_name = p_name;
			_desc = p_desc;
			_image_src = p_image;
			_sound_src = p_sound;
			_qr_src = p_qr;
			
		}
		
		public function get xpos(): int
		{
			return _xpos;
		}

		public function get ypos(): int
		{
			return _ypos;
		}

		public function get name(): String
		{
			return _name;
		}

		public function get description(): String
		{
			return _desc;
		}

		public function get image_source(): String
		{
			return _image_src;
		}

		public function get sound_source(): String
		{
			return _sound_src;
		}

		public function get qr_code_source(): String
		{
			return _qr_src;
		}
	}
}