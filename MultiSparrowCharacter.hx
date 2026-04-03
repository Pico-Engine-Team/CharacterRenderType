package objects.character;

import flixel.graphics.frames.FlxAtlasFrames;

class MultiSparrowCharacter
{
	/**
	* Loads multiple Sparrow spritesheets and combines them.
	* Useful for characters with many animations that don't fit
	* in a single spritesheet.
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
	* Checks if it is a MultiAtlas (more than one image separated by commas).
	*/
	public static function isMulti(imagePath:String):Bool
	{
		return imagePath.contains(',');
	}

	/**
	* Checks if all spritesheets exist.
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
