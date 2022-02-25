package;

import sys.FileSystem;
import haxe.io.Path;

function main() {
	trace("start generation");
	if (!FileSystem.exists("./docs")) Sys.command("git clone https://github.com/PXshadow/OpenLife-Docs docs");
	// docs
	var exclude:Array<String> = [
		// haxe
		"haxe",
		"Array",
		"ArrayAccess",
		"Bool",
		"Class",
		"Date",
		"Dynamic",
		"EReg",
		"Enum",
		"EnumValue",
		"Float",
		"Int",
		"IntIterator",
		"Iterable",
		"Iterator",
		"KeyValueIterable",
		"KeyValueIterator",
		"Lambda",
		"Map",
		"Math",
		"Null",
		"Reflect",
		"Std",
		"String",
		"StringBuf",
		"StringTools",
		"Sys",
		"Type",
		"Void",
		"Single",
		"Any",
		"List",
		"Xml",
		// main
		"Main",
		// "Static",
		"std",
		"shaders",
		// "ApplicationMain",
		// "DocumentClass",
		// "DefaultAssetLibrary",
		// target
		"neko",
		"sys",
		"cpp",
		"flash",
		"eval",
		"format",
	];
	trace("exclude gen");
	var excludeString = '"(';
	for (name in exclude)
		excludeString += name + "|";
	excludeString = excludeString.substring(0, excludeString.length - 1);
	excludeString += ')"';
	trace("generate html api");
	Sys.command('haxelib run dox -i xml -o docs/api -D version "0.0.8 alpha" -D logo "https://raw.githubusercontent.com/PXshadow/OpenLife/master/logo.png" -D title "API Reference" -D source-path "https://github.com/PXshadow/openlife/tree/master/src/" --exclude '
		+ excludeString);
}
