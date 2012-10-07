package se.antonstrand.zombierumbelcontroller
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source="assets/graphics/spritesheet.png")]
		private static const AtlasTextureGame	:Class;
		
		[Embed(source='assets/graphics/spritesheet.xml', mimeType='application/octet-stream')]
		private static const AtlasXMLGame		:Class;
		
		
		private static var _gameTextures	  :Dictionary	= new Dictionary();
		private static var _gameTextureAtlas  :TextureAtlas;
		
		
		public static function getAtlas(): TextureAtlas
		{
			if( _gameTextureAtlas == null )
			{
				var texture:Texture = Texture.fromBitmap( new AtlasTextureGame() );
				var xml:XML = XML( new AtlasXMLGame() );
				
				_gameTextureAtlas = new TextureAtlas( texture, xml );
			}
			
			return _gameTextureAtlas;
		}
		
		public static function getTexture( name:String ): Texture
		{
			if( _gameTextures[name] == undefined )
			{
				var bitmap:Bitmap = new Assets[name]();
				_gameTextures[name] = Texture.fromBitmap( bitmap );
			}
			return _gameTextures[name];
		}
	}
}