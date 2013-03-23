package haxe.ui.test;

import haxe.ui.containers.ListView;
import haxe.ui.core.Component;
import haxe.ui.core.ComponentParser;
import haxe.ui.core.Controller;
import haxe.ui.core.Globals;
import haxe.ui.core.Root;
import haxe.ui.style.StyleManager;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

class Main extends Sprite {
	public static var WINDOWS_SKIN:String = "windowsTheme";
	public static var ANDROID_SKIN:String = "androidTheme";
	public static var GRADIENT_SKIN:String = "gradientTheme";
	
	public function new() {
		super();
		#if iphone
			Lib.current.stage.addEventListener(Event.RESIZE, initialize);
		#else
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		#end
	}

	private function initialize(e) {
		#if iphone
			Lib.current.stage.removeEventListener(Event.RESIZE, initialize);
		#else
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
		#end
		
		startApp(WINDOWS_SKIN);
	}

	public static function startApp(skinId:String):Void {
		
		Globals.reset();
		Globals.add(skinId);
		
		StyleManager.clear();
		if (skinId == WINDOWS_SKIN) {
			//StyleManager.styles = new WindowsStyles();
			StyleManager.loadFromResource("skins/windows/windows.css");
			StyleManager.loadFromResource("skins/windows/buttons.css");
			StyleManager.loadFromResource("skins/windows/tabs.css");
			StyleManager.loadFromResource("skins/windows/listview.css");
			StyleManager.loadFromResource("skins/windows/scrolls.css");
			StyleManager.loadFromResource("skins/windows/popups.css");
		} else if (skinId == ANDROID_SKIN) {
			StyleManager.loadFromResource("skins/android/android.css");
			StyleManager.loadFromResource("skins/android/buttons.css");
			StyleManager.loadFromResource("skins/android/tabs.css");
			StyleManager.loadFromResource("skins/android/listview.css");
			StyleManager.loadFromResource("skins/android/scrolls.css");
			StyleManager.loadFromResource("skins/android/popups.css");
		} else if (skinId == GRADIENT_SKIN) {
			StyleManager.loadFromResource("skins/gradient/gradient.css");
		}
		
		
		
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;

		Root.destroyAll();
		
		//var root:Root = openPopup();
		var root:Root = openFullscreen();
		
		//var controller:Controller = new Controller(ComponentParser.fromXMLAsset("ui/test01.xml"));
		//root.addChild(controller.view);

		root.addChild(new ControlDemoController().view);
	}
	
	private static function openFullscreen():Root {
		var root:Root = Root.createRoot();
		return root;
	}
	
	private static function openPopup():Root {
		var stage = Lib.current.stage;
		//var background:Bitmap = new Bitmap(Assets.getBitmapData("img/slinky_large.jpg"));
		var background:BackgroundTest = new BackgroundTest(); // just a more interactive background
		stage.addChild(background);
		
		var root:Root = Root.createRoot( { x:50, y:50, width: 500, height: 400, additionalStyles: "popup", useShadow: true } );
		return root;
	}
	
	private static function openTest():Root {
		var root:Root = Root.createRoot();
		return root;
	}
	
	static public function main() {
		new Main().initialize(new Event(""));		
	}
	
}
