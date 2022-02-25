package openlife.data.map;

/**
 * Map chunk
 */
@:expose("MapInstance")
class MapInstance {
	/**
	 * Tile X
	 */
	public var x:Int = 0;

	/**
	 * Tile Y
	 */
	public var y:Int = 0;

	/**
	 * Tile Width
	 */
	public var width:Int = 0;

	/**
	 * Tile Height
	 */
	public var height:Int = 0;

	/**
	 * New map chunk created
	 */
	public function new() {}

	/**
	 * String for debug "pos(x,y) size(width,height) raw: rawSizeInt compress: compressSizeInt"
	 * @return String
	 */
	public function toString():String {
		return "pos(" + x + "," + y + ") size(" + width + "," + height + ")";
	}
}
