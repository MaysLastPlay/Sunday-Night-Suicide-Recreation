package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;

using StringTools;

class ShakingWarningSubState extends MusicBeatSubstate
{
    public static var somethingPressed:Bool = false;
	public static var warningtext:FlxText;
	public static var warningtext2:FlxText;
	override public function create() { // STATE DON'T HAVE FUCKING X AND Y YOU'RE AN IDIOT, THE ONE WHO MADE THIS
		warningtext = new FlxText(0 + 300, 0 + 300, 0, "", 32);
		warningtext2 = new FlxText(0 + 130, 0 + 350, 0, "Press A to Procceed, Press B to turn shaking off", 32);
		if(PlayState.isStoryMode) {
			warningtext.text = "This song and the next one contain shaking, procced?";
			warningtext.x -= 131; //60 + 71 == 131
		}
		warningtext.scrollFactor.set();
		warningtext.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.RED);
		warningtext.updateHitbox();
		warningtext2.scrollFactor.set();
		warningtext2.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.RED);
		warningtext2.updateHitbox();
		add(warningtext);
		add(warningtext2);

    #if android
		addVirtualPad(NONE, A_B);
		addPadCamera();
		#end
                // VPAD MUST BE IN CREATE YOU'RE *******
                super.create();
	}

    override public function update(elapsed:Float):Void // YOU'RE FUCKING GENIOUS, NAME THE UPDATE FUNCTION WITH CREATE, FUCK YOUR MOTHER BITCH
    {
		if (FlxG.keys.justPressed.CONTROL #if android || _virtualpad.buttonB.justPressed #end)
		{
      ClientPrefs.shaking = false;
      somethingPressed = true;
		  ClientPrefs.saveSettings();
      FlxG.resetState();
		}

		if (FlxG.keys.justPressed.ENTER #if android || _virtualpad.buttonA.justPressed #end)
		{
     ClientPrefs.shaking = true;
     somethingPressed = true;
		 ClientPrefs.saveSettings();
		 FlxG.resetState();
		}

		super.update(elapsed);
   }
}