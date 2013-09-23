package;

import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

class Cactus extends FlxSprite{

    private var player:Player;

    public function new(x:Float, y:Float, pl:Player){
        super(x, y);
        
        loadGraphic('assets/cactus.png',false, true);

        player = pl;
        health = 100;
        immovable = true;
    }

    override public function destroy():Void{
        super.destroy();
    }

    override public function update():Void{
        super.update();

        if(FlxG.collide(this, player) && FlxG.keys.Z  && player.water < 500){
            health -= 1;
            player.water += 2;
            Reg.score += 5;
        }

        if(health < 0){
            kill();
        }
    }
}
