package openlife.data;

// multi platform to read input
import haxe.io.Input;
import haxe.ds.Vector;

class LineReader {
	@:doxHide(false)
	/**
	 * line vector of data
	 */
	var line:Vector<String>;
	@:doxHide(false)
	/**
	 * next 
	 */
	var next:Int = 0;
	@:doxHide(false)
	var input:Input;

	public static inline var EOL:String = "\n";

	public function new() {}

	/**
	 * Read lines and put into line vector
	 * @param string text split into lines
	 */
	public function readLines(string:String):Bool {
		if (string.length == 0)
			return false;
		next = 0;
		line = Vector.fromArrayCopy(string.split(EOL));
		return true;
	}

	/**
	 * Float Array value from line
	 * @return Array<Float>
	 */
	public function getFloatArray():Array<Float> {
		var array:Array<Float> = [];
		for (o in getStringArray()) {
			array.push(Std.parseFloat(o));
		}
		return array;
	}

	/**
	 * Int Array value from line
	 * @return Array<Int>
	 */
	public function getIntArray():Array<Int> {
		var array:Array<Int> = [];
		for (o in getStringArray()) {
			array.push(Std.parseInt(o));
		}
		return array;
	}

	/**
	 * String Array value from line
	 * @return Array<String>
	 */
	public function getStringArray():Array<String> {
		return getString().split(",");
	}

	/**
	 * Point (x,y) from line
	 * @return Point
	 */
	public function getPoint():Point {
		var string = getString();
		var comma:Int = string.indexOf(",");
		return new Point(Std.parseInt(string.substring(0, comma)), Std.parseInt(string.substring(comma + 1, string.length)));
	}

	/**
	 * Boolean value from line
	 * @return Bool
	 */
	public function getBool():Bool {
		return getString().substr(0, 1) == "1";
	}

	/**
	 * Int from string
	 * @return Int
	 */
	public function getInt():Int {
		return Std.parseInt(getString());
	}

	var i:Int = 0;
	var j:Int = 0;
	var string:String;

	/**
	 * Multi property array int value from line
	 * @return Array<Int>
	 */
	public function getArrayInt():Array<Int> {
		var array:Array<Int> = [];
		var bool:Bool = true;
		string = "=" + line[next++];
		i = 0;
		j = 0;
		while (bool) {
			i = string.indexOf("=", i + 0) + 1;
			j = string.indexOf(",", i);
			j = j < 0 ? string.length : j;
			array.push(Std.parseInt(string.substring(i, j)));
			if (j >= string.length - 1)
				bool = false;
		}
		array.shift(); // FIX THIS
		return array;
	}

	/**
	 * Float value from line
	 * @return Float
	 */
	public function getFloat():Float {
		return Std.parseFloat(getString());
	}

	/**
	 * String value from line
	 * @return String
	 */
	public function getString():String {
		if (next + 1 > line.length)
			throw 'max $line';
		string = line[next++];
		if (string == null || string == "")
			return "";
		var equals = string.indexOf("=");
		return string.substr(equals + 1);
	}

	/**
	 * Name from line
	 * @param name 
	 * @return Bool
	 */
	public function readName(name:String):Bool {
		string = line[next];
		if (name == string.substring(0, name.length))
			return true;
		return false;
	}

	public function getName():String {
		string = line[next];
		return string.substring(0, string.indexOf("="));
	}
}
