package;

import sys.io.File;
import sys.FileSystem;

using StringTools;

class ProtocolTagCheck {
	public static function main() {
		new ProtocolTagCheck();
	}

	var startString = "Possible types include:";
	var endString = "Client can expect to receive these at any time, and in any order.";
	var clientTagPath = "./openlife/client/ClientTag.hx";
	// more tags
	var enumTags:Array<String> = [];
	var names:Array<String> = [];
	var switchTags:Array<String> = [];
	var string:String;
	var headerContent:String;
	var gameContent:String;
	var errors:Int = 0;

	public function new() {
		string = haxe.Http.requestUrl("https://raw.githubusercontent.com/jasonrohrer/OneLife/master/server/protocol.txt");
		if (string != File.getContent("./protocol.txt")) {
			trace("protocol is not the same, update");
			File.saveContent("./protocol.txt", string);
		}
		headerContent = File.getContent("./openlife/engine/engineHeader.hx");
		gameContent = File.getContent("./openlife/engine/Engine.hx");
		run();
	}

	private function run() {
		trace("start protocol tag check");
		var index = string.indexOf(startString) + startString.length;
		if (index <= startString.length) {
			trace('failed to find start string, index: $index');
			return;
		}
		string = string.substring(index, string.indexOf(endString, index));
		var tags:Array<String> = [];
		// data = data.replace("\n","");
		for (obj in string.split("\n")) {
			index = obj.indexOf("(");
			if (index == -1) continue;
			names.push(StringTools.rtrim(obj.substring(0, index)));
			tags.push(obj.substring(index + 1, obj.indexOf(")", index)));
		}
		// check clientTag
		string = File.getContent(clientTagPath);
		index = string.indexOf("{");
		var sub = string.substring(index, index = string.indexOf("@:from", index));
		string = string.substring(index = string.indexOf("case", index), string.indexOf("}", index));

		generate(sub.split("\n"), enumTags);
		generate(string.split("\n"), switchTags, true);

		var error:Array<String> = [];
		for (i in 0...tags.length) {
			error = [];
			if (enumTags.indexOf(tags[i]) == -1) error.push("enum");
			if (switchTags.indexOf(tags[i]) == -1) error.push("switch");
			if (error.length > 0) {
				if (error.length > 1) {
					trace(names[i] + " " + tags[i] + " | " + error[0] + " and " + error[1] + " not found");
					errors++;
				} else {
					trace(names[i] + " " + tags[i] + " | " + error[0] + " not found");
					errors++;
				}
			}
			// header content
			if (headerContent.indexOf("//" + names[i]) == -1) {
				trace("EngineHeader.hx could not find: " + names[i]);
				errors++;
			}
			if (gameContent.indexOf("case " + names[i]) == -1) {
				trace("Engine.hx could not find: " + names[i]);
				errors++;
			}
		}
		trace('finished with $error errors');
	}

	private function generate(input:Array<String>, output:Array<String>, name:Bool = false) {
		var index:Int = 0;
		for (obj in input) {
			index = obj.indexOf('"') + 1;
			if (index == 0) continue;
			index = output.push(obj.substring(index, obj.indexOf('"', index)));
		}
	}
}
