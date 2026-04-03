package objects.character;

// ============================================
// PICO ENGINE - AnimateAtlasCharacter
// Loads the character using FlxAnimate
// (Adobe Animate format exported).

//
// Expected folder structure:
// images/<imagePath>/
// Animation.json ← animation data
// spritemap1.json ← spritesheet atlas
// spritemap1.png ← spritesheet image
//
// Supports multiple spritemaps:
// spritemap1.json, spritemap2.json, etc.

#if flxanimate
import flxanimate.FlxAnimate;
#end

class AnimateAtlasCharacter
{
	/**
	* Loads the FlxAnimate atlas for the character.
	* Searches for the Animation.json and spritemap*.json files
	* inside the character's folder.
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
	* Checks if the character folder contains the files
	* required for AnimateAtlas (Animation.json + spritemap1.*).
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
	* Returns the path to the character's Animation.json file.
	*/
	public static function getAnimationJsonPath(imagePath:String):String
	{
		return Paths.getPath('images/$imagePath/Animation.json', TEXT);
	}

	/**
	* Returns the path of the main spritemap.
	* Searches from spritemap1 to spritemap9.
	*/
	public static function getSpritemapPath(imagePath:String, ?index:Int = 1):String
	{
		return Paths.getPath('images/$imagePath/spritemap$index.json', TEXT);
	}
}
