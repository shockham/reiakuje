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
import org.flixel.FlxTilemap;
import org.flixel.util.FlxMath;
import org.flixel.util.FlxRect;
import org.flixel.FlxGroup;
import org.flixel.util.FlxPoint;

class PlayState extends FlxState{
    
    private var player:Player;

    private var level:LevelGenerator;

    private var cactus:FlxGroup;

    private var exit:FlxSprite;

    var bar:FlxSprite;

    public static var TILE_HEIGHT:Int = 48;
    public static var TILE_WIDTH:Int = 48;

    public static var MAP_HEIGHT:Int = 200;
    public static var MAP_WIDTH:Int = 200;

    override public function create():Void{
        // Set a background color
        FlxG.bgColor = 0xfffbf7e8;
        // Show the mouse (in case it hasn't been disabled)
        #if !FLX_NO_MOUSE
        // FlxG.mouse.show();
        #end
        
        FlxG.worldBounds = new FlxRect(TILE_HEIGHT*MAP_HEIGHT, TILE_WIDTH*MAP_WIDTH);

        Reg.level = 1;
        Reg.score = 0;

        player = new Player((MAP_WIDTH/2) * TILE_WIDTH, (MAP_HEIGHT/2)*TILE_HEIGHT, this);
        add(player);


        level = new LevelGenerator();
        add(level);


        exit = new FlxSprite(FlxG.random()*(TILE_WIDTH*MAP_WIDTH), FlxG.random()*(TILE_HEIGHT*MAP_HEIGHT));
        exit.loadGraphic("assets/hurricane.png" ,false, true);
        exit.immovable = true;
        add(exit);

        FlxG.camera.follow(player);

        super.create();
    }
    
    override public function destroy():Void{
        super.destroy();
    }

    override public function update():Void{
        super.update();

        if(FlxG.collide(player, exit)){
            Reg.level += 1;
            FlxG.resetState();
        }

        FlxG.collide(level, player);

        if (!player.alive){
            var dead_text = new FlxText(6, (FlxG.height/2) - 27, 400, "Polar Bearbeque'd!");
            dead_text.size = 27;
            dead_text.scrollFactor.x = dead_text.scrollFactor.y = 0;
            add(dead_text);

            var dead_level = new FlxText(6, (FlxG.height/2), 400, "Level " + Std.string(Reg.level));
            dead_level.size = 20;
            dead_level.scrollFactor.x = dead_level.scrollFactor.y = 0;
            add(dead_level);

            var dead_score = new FlxText(6, (FlxG.height/2) + 20, 400, "Score " + Std.string(Reg.score));
            dead_score.size = 20;
            dead_score.scrollFactor.x = dead_score.scrollFactor.y = 0;
            add(dead_score);
        }

        if(FlxG.keys.R) FlxG.resetState();
    }   
}
