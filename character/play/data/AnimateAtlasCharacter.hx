package objects.character;

// ============================================
// PICO ENGINE - AnimateAtlasCharacter
// Carrega o personagem usando FlxAnimate
// (formato Adobe Animate exportado).
//
// Estrutura de pasta esperada:
//   images/<imagePath>/
//     Animation.json     ← dados das animações
//     spritemap1.json    ← atlas do spritesheet
//     spritemap1.png     ← imagem do spritesheet
//
// Suporta múltiplos spritemaps:
//   spritemap1.json, spritemap2.json, etc.
// ============================================

#if flxanimate
import flxanimate.FlxAnimate;
#end

class AnimateAtlasCharacter
{
	/**
	 * Carrega o FlxAnimate atlas para o personagem.
	 * Procura pelos arquivos Animation.json e spritemap*.json
	 * dentro da pasta do personagem.
	 */
	public static function load(character:objects.Character):Void
	{
		#if flxanimate
		character.isAnimateAtlas = true;

		if(character.atlas == null)
		{
			character.atlas = new FlxAnimate();
			character.atlas.showPivot = false;
		}

		try
		{
			Paths.loadAnimateAtlas(character.atlas, character.imageFile);
			character.copyAtlasValues();
		}
		catch(e:haxe.Exception)
		{
			FlxG.log.warn('[AnimateAtlasCharacter] Could not load atlas "${character.imageFile}": ${e.message}');
			trace(e.stack);
			// Fallback para Sparrow se o AnimateAtlas falhar
			character.isAnimateAtlas = false;
			character.frames = Paths.getSparrowAtlas(character.imageFile);
		}
		#else
		FlxG.log.warn('[AnimateAtlasCharacter] flxanimate not available, falling back to Sparrow.');
		character.frames = Paths.getSparrowAtlas(character.imageFile);
		#end
	}

	/**
	 * Verifica se a pasta do personagem contém os arquivos
	 * necessários para o AnimateAtlas (Animation.json + spritemap1.*).
	 */
	public static function exists(imagePath:String):Bool
	{
		var animJson:String = Paths.getPath('images/$imagePath/Animation.json', TEXT);
		#if MODS_ALLOWED
		if(sys.FileSystem.exists(animJson)) return true;
		#end
		return openfl.utils.Assets.exists(animJson);
	}

	/**
	 * Retorna o caminho do Animation.json do personagem.
	 */
	public static function getAnimationJsonPath(imagePath:String):String
	{
		return Paths.getPath('images/$imagePath/Animation.json', TEXT);
	}

	/**
	 * Retorna o caminho do spritemap principal.
	 * Procura de spritemap1 até spritemap9.
	 */
	public static function getSpritemapPath(imagePath:String, ?index:Int = 1):String
	{
		return Paths.getPath('images/$imagePath/spritemap$index.json', TEXT);
	}
}
