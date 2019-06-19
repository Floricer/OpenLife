import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.Tile;
import openfl.display.DisplayObjectContainer;
import openfl.display.Shape;
class PlayerData
{
    public var key:Map<Int,PlayerType> = new Map<Int,PlayerType>();
    public var array:Array<PlayerType> = [];
    public var primary:Int = -1;
    public var update:Void->Void;
    public function new()
    {

    }
}
class PlayerType 
{
    public var p_id:Int = 0;
    public var po_id:Int = 0;
    public var facing_action:Int = 0;
    public var action_target_x:Int = 0;
    public var action_target_y:Int = 0;
    public var o_id:Int = 0;
    public var o_origin_valid:Int = 0;
    public var o_origin_x:Int = 0;
    public var o_origin_y:Int = 0;
    public var o_transition_source_id:Int = 0;
    public var heat:Int = 0;
    public var done_moving_seqNum:Int = 0;
    public var forceX:Int = 0;
    public var forceY:Int = 0;
    public var age:Int = 0;
    public var age_r:Int = 0;
    public var move_speed:Float = 0;
    public var clothing_set:String = "";
    public var just_ate:Int = 0;
    public var last_ate_id:Int = 0;
    public var responsible_id:Int = 0;
    public var held_yum:Int = 0;
    public function new()
    {

    }
    public function toString():String
    {
        var string:String = "";
        for(field in Reflect.fields(this))
        {
            string += field + ": " + Reflect.getProperty(this,field) + "\n";
        }
        return string;
    }
}
class PlayerInstance extends PlayerType
{
    public function new(a:Array<String>)
    {
        super();
        var index:Int = 0;
        for(value in a)
        {
            //index
            switch(index++)
            {
                case 0:
                p_id = Std.parseInt(value);
                case 1:
                po_id = Std.parseInt(value);
                case 2:
                facing_action = Std.parseInt(value);
                case 3:
                action_target_x = Std.parseInt(value);
                case 4:
                action_target_y = Std.parseInt(value);
                case 5:
                o_id = Std.parseInt(value);
                case 6:
                o_origin_valid = Std.parseInt(value);
                case 7:
                o_origin_x = Std.parseInt(value);
                case 8:
                o_origin_y = Std.parseInt(value);
                case 9:
                o_transition_source_id = Std.parseInt(value);
                case 10:
                heat = Std.parseInt(value);
                case 11:
                done_moving_seqNum = Std.parseInt(value);
                case 12:
                forceX = Std.parseInt(value);
                case 13:
                forceY = Std.parseInt(value);
                case 14:
                trace("age value " + value);
                age = Std.parseInt(value);
                case 15:
                trace("age r " + value);
                age_r = Std.parseInt(value);
                case 16:
                move_speed = Std.parseInt(value);
                case 17:
                clothing_set = value;
                case 18:
                just_ate = Std.parseInt(value);
                case 19:
                responsible_id = Std.parseInt(value);
                case 20:
                held_yum = Std.parseInt(value);
            }
            //add primary player
            if(Main.client.player.primary == -1) Main.client.player.primary = p_id;
            //push into array to update
            Main.client.player.array.push(this);
            //set new or existing key
            Main.client.player.key.set(p_id,this);
            //update 
            if (Main.client.player != null) Main.client.player.update();
        }

    }
}   