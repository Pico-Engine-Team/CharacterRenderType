package objects.character;

// ============================================
// PICO ENGINE - MultiSparrowCharacter
// Carrega o personagem usando múltiplos
// Sparrow Atlas combinados em um só.
// Imagens separadas por vírgula no campo
// "image" do JSON: "bf,bf-dead,bf-extra"
// ============================================

import flixel.graphics.frames.FlxAtlasFrames;

class MultiSparrowCharacter
{
	/**
	 * Carrega múltiplos spritesheets Sparrow e os combina.
	 * Útil para personagens com muitas animações que não cabem
	 * em um único spritesheet.
	 */
	public static function load(character:objects.Character):Void
	{
		var imagePath:String = character.imageFile;
		var parts:Array<String> = imagePath.split(',').map(s -> s.trim()).filter(s -> s.length > 0);

		if(parts.length < 1)
		{
			FlxG.log.warn('[MultiSparrowCharacter] Empty image path!');
			return;
		}

		character.frames = Paths.getMultiAtlas(parts);

		if(character.frames == null)
			FlxG.log.warn('[MultiSparrowCharacter] Could not load multi-atlas: $imagePath');
	}

	/**
	 * Verifica se é um MultiAtlas (mais de uma imagem separada por vírgula).
	 */
	public static function isMulti(imagePath:String):Bool
	{
		return imagePath.contains(',');
	}

	/**
	 * Verifica se todos os spritesheets existem.
	 */
	public static function exists(imagePath:String):Bool
	{
		var parts:Array<String> = imagePath.split(',').map(s -> s.trim());
		for(part in parts)
			if(!Paths.fileExists('images/$part.xml', TEXT) && !Paths.fileExists('images/$part.png', IMAGE))
				return false;
		return parts.length > 0;
	}
}
