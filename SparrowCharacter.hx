package objects.character;

// ============================================
// PICO ENGINE - SparrowCharacter
// Carrega o personagem usando Sparrow Atlas
// (.png + .xml) — formato padrão Psych Engine
// ============================================

import flixel.graphics.frames.FlxAtlasFrames;

class SparrowCharacter
{
	/**
	 * Carrega o atlas Sparrow (.png + .xml) para o personagem.
	 * Suporta múltiplos spritesheets separados por vírgula (MultiAtlas).
	 * Ex: "characters/bf,characters/bf2"
	 */
	public static function load(character:objects.Character):Void
	{
		var imagePath:String = character.imageFile;

		// Suporte a MultiAtlas (imagens separadas por vírgula)
		var parts:Array<String> = imagePath.split(',');
		if(parts.length > 1)
		{
			// MultiSparrow — vários spritesheets combinados
			character.frames = Paths.getMultiAtlas(parts);
		}
		else
		{
			// Sparrow simples — um único spritesheet
			character.frames = Paths.getSparrowAtlas(imagePath);
		}

		if(character.frames == null)
			FlxG.log.warn('[SparrowCharacter] Could not load atlas: $imagePath');
	}

	/**
	 * Verifica se o arquivo de atlas Sparrow existe.
	 */
	public static function exists(imagePath:String):Bool
	{
		var parts:Array<String> = imagePath.split(',');
		return Paths.fileExists('images/${parts[0]}.xml', TEXT)
			|| Paths.fileExists('images/${parts[0]}.png', IMAGE);
	}
}
