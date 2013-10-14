package;

import org.flixel.FlxTilemap;
import org.flixel.FlxG;
import org.flixel.util.FlxPoint;

class LevelGenerator extends FlxTilemap{
    
    public function new(){
        super();

        var tiles:Array<Int> = new Array<Int>();

        for(i in 0...(PlayState.MAP_HEIGHT*PlayState.MAP_WIDTH)){ tiles[i] = 1; }

        loadMap(FlxTilemap.arrayToCSV(tiles, PlayState.MAP_WIDTH), 'assets/tiles.png', PlayState.TILE_WIDTH, PlayState.TILE_HEIGHT, FlxTilemap.AUTO);


        var start_point:FlxPoint =  new FlxPoint(Std.int(PlayState.MAP_WIDTH/2), Std.int(PlayState.MAP_WIDTH/2));

        setTile(Std.int(start_point.x), Std.int(start_point.y), 0);

        for (i in 0...10) {
            start_point = create_corridor(start_point);
        
            start_point = create_room(start_point);
        }

    }

    private function create_corridor(start_point:FlxPoint):FlxPoint{
        var corr_length:Int = Std.int(FlxG.random()*20);

        var horizontal:Bool = (FlxG.random() > 0.5);
        var positive:Bool = (FlxG.random() > 0.5);

        if(horizontal){
            if(positive){            
                for (i in 0...corr_length){ setTile(Std.int(start_point.x) + i, Std.int(start_point.y) , 0); }
                start_point.x += corr_length;
            }else{
                for (i in 0...corr_length){ setTile(Std.int(start_point.x) - i, Std.int(start_point.y) , 0); }
                start_point.x -= corr_length;
            }
        }else{
            if(positive){
                for (i in 0...corr_length){ setTile(Std.int(start_point.x), Std.int(start_point.y) + i , 0); }
                start_point.y += corr_length;
            }else{
                for (i in 0...corr_length){ setTile(Std.int(start_point.x), Std.int(start_point.y) - i , 0); }
                start_point.y -= corr_length;
            }
        }

        return start_point;
    }

    private function create_room(start_point:FlxPoint):FlxPoint{
        var room_size:Int = 2 + Std.int(FlxG.random()*5)*2;

        var room_start_x:Int = Std.int(start_point.x - (room_size/2));

        for (i in Std.int(start_point.y)...Std.int(start_point.y)+room_size){
            for (j in room_start_x...(room_start_x+room_size)) {
                setTile(j, i , 0);
            }
        }

        start_point.y += room_size;
        start_point.x = room_start_x + (FlxG.random()*room_size);

        return start_point;
    }
}
