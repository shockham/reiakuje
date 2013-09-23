package;

import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

class Player extends FlxSprite{

    public var water:Int;

    public function new(x:Float, y:Float){
        super(x, y);
        
        loadGraphic('assets/bear.png',false, true);

        water = 500;

        maxVelocity.x = 500;
        maxVelocity.y = 500;
        acceleration.y = 400;
        drag.x = maxVelocity.x*2;
        drag.y = maxVelocity.y*2;
    }

    override public function destroy():Void{
        super.destroy();
    }

    override public function update():Void{
        acceleration.x = 0;
        acceleration.y = 0;

        if(FlxG.keys.LEFT){ 
            acceleration.x -= 400;
            facing = FlxObject.LEFT;
        }
        if(FlxG.keys.RIGHT){
            acceleration.x += 400;
            facing = FlxObject.RIGHT;
        }
        if(FlxG.keys.UP){
            acceleration.y -= 400;
            facing = FlxObject.UP;
        }
        if(FlxG.keys.DOWN){
            acceleration.y += 400;
            facing = FlxObject.DOWN;
        }

        if(water > 0){
            water--;
        }else{
            kill();
        }
        
        super.update();
    }
}
