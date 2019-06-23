import haxe.ds.Vector;
import openfl.Lib;
import openfl.display.Bitmap;
import haxe.io.Input;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
#if sys
import sys.io.FileInput;
import sys.io.File;
#end
class Static 
{
    public static inline var GRID:Int = 128;
    //player constants
    public static inline var babyHeadDownFactor:Float = 0.6;
    public static inline var babyBodyDownFactor:Float = 0.75;
    public static inline var oldHeadDownFactor:Float = 0.35;
    public static inline var oldHeadForwardFactor:Float = 2;

    //tga
    public static function tga(bitmap:Bitmap,path:String,x:Int=0,y:Int=0)
    {
        bitmap.bitmapData = tgaBitmapData(path,x,y);
    }
    public static function tgaBitmapData(path:String,x:Int=0,y:Int=0):BitmapData
    {
        var data = tgaBytes(path);
        var bitmapData = new BitmapData(data.header.width,data.header.height);
        bitmapData.setPixels(new Rectangle(x,y,data.header.width,data.header.height),ByteArray.fromBytes(data.bytes));
        return bitmapData;
    }
    public static function tgaBytes(path:String):{bytes:ByteArray,header:format.tga.Data.Header}
    {
        var data:format.tga.Data = null;
        try {
            var r = new format.tga.Reader(File.read(path));
            data = r.read();
        }catch(e:Dynamic)
        {
            return null;
        }
        return {bytes:ByteArray.fromBytes(format.tga.Tools.extract32(data,true)),header:data.header};
    }
}