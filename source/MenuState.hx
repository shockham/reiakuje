package;

import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.util.FlxMath;

class MenuState extends FlxState{
    
    override public function create():Void{
        // Set a background color
        FlxG.bgColor = 0xfffbf7e8;
        // Show the mouse (in case it hasn't been disabled)
        #if !FLX_NO_MOUSE
        // FlxG.mouse.show();
        #end
        
        var instruction:FlxText = new FlxText(0,90,FlxG.width,"press x to start.");
        instruction.size = 30;
        instruction.color = 0xff414141;
        instruction.font = "assets/Comfortaa-Regular.ttf";
        add(instruction);

        var title:FlxText =  new FlxText(0,0,FlxG.width,"reiakuje.");
        title.size = 100;
        title.color = 0xff000000;
        title.font = "assets/Comfortaa-Regular.ttf";
        add(title);

        super.create();
    }
    
    override public function destroy():Void{
        super.destroy();
    }

    override public function update():Void{
        super.update();
        if (FlxG.keys.X) FlxG.switchState(new PlayState());
    }   
}
