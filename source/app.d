import std.stdio;
import std.algorithm.iteration : filter, joiner, map, uniq;
import std.algorithm.searching : canFind, startsWith;
import std.algorithm.sorting : sort;
import std.traits;
import std.conv : to;
import std.uni : toLower;
import std.format;
import std.typecons;

struct Thing2 {
	size_t id;
	string value;
	Nullable!string additionalValue;
}

struct Thing1 {
	long a;
	string b;
	Nullable!Thing2 c;
	Thing2 d;

	string toString() { return ""; }
}

string generateImports(T)() {
	string[] mems;
	static foreach(mem; [__traits(allMembers, T)]
			.filter!(it => !it.startsWith("op"))
			.filter!(it => !it.startsWith("__"))
			.filter!(it => !canFind(["toString", "toHash"], it))
			) 
	{{
		static if(is(T : Nullable!F, F)) {
			alias UnpackNullable = F;
		} else {
			alias UnpackNullable = T;
		}

		static if(!isBasicType!UnpackNullable) {
			mems ~= UnpackNullable.stringof;
		}
	}}

	return mems
		.sort
		.uniq
		.map!(m => format("import { %s } from '%s'", m, m.toLower()))
		.joiner("\n")
		.to!string();
}

string toTypeScriptFile(T)() {
	string ret = generateImports!(T);
	return ret;
}

void main() {
	writeln(toTypeScriptFile!(Thing1)());
}
