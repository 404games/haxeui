package haxe.ui.toolkit.style;

import haxe.ds.StringMap;

class Styles {
	private var _styles:StringMap<Dynamic>;
	private var _styleRules:Array<String>;
	
	public var rules(get, null):Iterator<String>;
	
	public function new() {
		_styles = new StringMap<Dynamic>();
		_styleRules = new Array<String>();
	}

	public function addStyle(rule:String, style:Dynamic):Dynamic {
		if (rule.indexOf(",") != -1) {
			var rules:Array<String> = rule.split(",");
			for (r in rules) {
				r = StringTools.trim(r);
				addStyle(r, style);
			}
			return null;
		}
		
		var currentStyle:Dynamic = getStyle(rule);
		if (currentStyle != null) {
			style = StyleManager.instance.mergeStyle(currentStyle, style);
		} else {
			_styleRules.push(rule);
		}
		
		_styles.set(rule, style);
		return style;
	}
	
	public function getStyle(rule:String):Dynamic {
		return _styles.get(rule);
	}
	
	private function get_rules():Iterator<String> {
		return _styleRules.iterator();
	}
	
	public function dump():Void {
		for (rule in _styleRules) {
			trace(rule + ":" + _styles.get(rule));
		}
	}
}