package openlife.data.map;

import haxe.ds.Vector;

@:expose
class SceneData {
	public var width:Int = 0;
	public var height:Int = 0;
	public var cells:Vector<SceneCell>;

	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		cells = new Vector(width * height);
	}
}
