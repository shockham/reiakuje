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

class PlayState extends FlxState{
    
    private var player:Player;

    private var tilemap:FlxTilemap;

    private var cactus:FlxGroup;

    private var exit:FlxSprite;

    var bar:FlxSprite;

    public static var TILE_HEIGHT:Int = 48;
    public static var TILE_WIDTH:Int = 48;

    override public function create():Void{
        // Set a background color
        FlxG.bgColor = 0xffede7b2;
        // Show the mouse (in case it hasn't been disabled)
        #if !FLX_NO_MOUSE
        // FlxG.mouse.show();
        #end
        
        FlxG.worldBounds = new FlxRect(TILE_HEIGHT*48, TILE_WIDTH*48);

        Reg.level = 1;
        Reg.score = 0;

        player = new Player(FlxG.width/2, FlxG.height/2);
        add(player);

        var tiles:Array<Int> = new Array<Int>();

        for(i in 0...2304){
            if(i % 48 == 0){
                tiles[i] = 1; 
                tiles[i-1] = 1;
            }else if(i < 48 || i > 2256) tiles[i] = 1;
            else if(FlxG.random() < 0.05) tiles[i] = 1;
            else tiles[i] = 0;
        }

        tilemap = new FlxTilemap();
        tilemap.loadMap(FlxTilemap.arrayToCSV(tiles, 48), 'assets/tiles.png', TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
        add(tilemap);

        cactus = new FlxGroup();

        for (i in 0...50) {
            cactus.add(new Cactus(FlxG.random()*(48*48), FlxG.random()*(48*48), player));
        }

        add(cactus);

        var frame:FlxSprite = new FlxSprite(4,4);
        frame.makeGraphic(50,10); //White frame for the health bar
        frame.scrollFactor.x = frame.scrollFactor.y = 0;
        add(frame);
         
        var inside:FlxSprite = new FlxSprite(5,5);
        inside.makeGraphic(48,8,0xff000000); //Black interior, 48 pixels wide
        inside.scrollFactor.x = inside.scrollFactor.y = 0;
        add(inside);
         
        bar = new FlxSprite(5,5);
        bar.makeGraphic(1,8,0xff64c7eb); //The red bar itself
        bar.scrollFactor.x = bar.scrollFactor.y = 0;
        bar.origin.x = bar.origin.y = 0; //Zero out the origin
        bar.scale.x = 48; //Fill up the health bar all the way
        add(bar);

        exit = new FlxSprite(FlxG.random()*(48*48), FlxG.random()*(48*48));
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

        bar.scale.x = (player.water/500)*48;

        if(FlxG.collide(player, exit)){
            Reg.level += 1;
            FlxG.resetState();
        }

        FlxG.collide();

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
