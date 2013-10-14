package;

import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

class Player extends FlxSprite{

    var up_shield:FlxSprite;
    var down_shield:FlxSprite;
    var left_shield:FlxSprite;
    var right_shield:FlxSprite;

    var shield_distance:Int = 2;

    public function new(x:Float, y:Float, state:PlayState){
        super(x, y);
        
        loadGraphic('assets/player_cleaner.png',true, false, 25, 40);
        addAnimation('walk_down', [0]);
        addAnimation('walk_up', [1]);
        addAnimation('walk_right', [2]);
        addAnimation('walk_left', [3]);

        health = 100;

        maxVelocity.x = 500;
        maxVelocity.y = 500;
        acceleration.y = 400;
        acceleration.x = 400;
        drag.x = maxVelocity.x*3;
        drag.y = maxVelocity.y*3;

        //create the shield sprites

        up_shield = new FlxSprite(x, y - shield_distance);
        up_shield.makeGraphic(Std.int(width) + (shield_distance*2), 4, 0xff66dae1);
        up_shield.visible = false;
        state.add(up_shield);

        down_shield = new FlxSprite(x, y + height + shield_distance);
        down_shield.makeGraphic(Std.int(width) + (shield_distance*2), 4, 0xff66dae1);
        down_shield.visible = false;
        state.add(down_shield);

        left_shield = new FlxSprite(x - shield_distance, y);
        left_shield.makeGraphic(4, Std.int(height) + (shield_distance*2), 0xff66dae1);
        left_shield.visible = false;
        state.add(left_shield);

        right_shield = new FlxSprite(x + width + shield_distance, y);
        right_shield.makeGraphic(4, Std.int(height) + (shield_distance*2), 0xff66dae1);
        right_shield.visible = false;
        state.add(right_shield);
    }

    override public function destroy():Void{
        super.destroy();
    }

    override public function update():Void{
        acceleration.x = 0;
        acceleration.y = 0;

        if(FlxG.keys.A){ 
            acceleration.x -= 400;
            facing = FlxObject.LEFT;
            play('walk_left');
        }
        if(FlxG.keys.D){
            acceleration.x += 400;
            facing = FlxObject.RIGHT;
            play('walk_right');
        }
        if(FlxG.keys.W){
            acceleration.y -= 400;
            facing = FlxObject.UP;
            play('walk_up');
        }
        if(FlxG.keys.S){
            acceleration.y += 400;
            facing = FlxObject.DOWN;
            play('walk_down');
        }

        if(FlxG.keys.I) up_shield.visible = true;
        else up_shield.visible = false;
        up_shield.x = x;
        up_shield.y = y - shield_distance;

        if(FlxG.keys.K) down_shield.visible = true;
        else down_shield.visible = false;
        down_shield.x = x;
        down_shield.y = y + height + shield_distance;

        if(FlxG.keys.J) left_shield.visible = true;
        else left_shield.visible = false;
        left_shield.x = x - shield_distance;
        left_shield.y = y;

        if(FlxG.keys.L) right_shield.visible = true;
        else right_shield.visible = false;
        right_shield.x = x + width + shield_distance;
        right_shield.y = y;

        if(health < 0){
            kill();
        }
        
        super.update();
    }
}
