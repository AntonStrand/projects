package se.antonstrand.towers.utils
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source="assets/game_graphics.png")]
		public static const GAME_GRAPHIC_ATLAS:Class;

		[Embed(source="assets/game_graphics.xml", mimeType="application/octet-stream")]
		public static const GAME_GRAPHIC_ATLAS_XML:Class;
		
		private static var _gameTextures		:Dictionary = new Dictionary();
		private static var _gameTextureAtlas	:TextureAtlas;
		
		public static function getTexture( name:String ): Texture
		{
			if( _gameTextures[name] == null )
			{
				var bitmap:Bitmap = new Assets[name]();
				_gameTextures[name] = Texture.fromBitmap( bitmap );
			}
			return _gameTextures[name];
		}
		
		public static function getAtlas(): TextureAtlas
		{
			if( _gameTextureAtlas == null )
			{
				var texture:Texture = Texture.fromBitmap( new GAME_GRAPHIC_ATLAS() );
				var xml:XML = XML( new GAME_GRAPHIC_ATLAS_XML );
				
				_gameTextureAtlas = new TextureAtlas( texture, xml );
			}
			
			return _gameTextureAtlas;
		}
		
	}
}