package ktu.utils.align.capabilities.gfx {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * 
	 * 	Displays Last Selected target information
	 * 
	 * 	TODO:
	 * 		Needs beautification!!!
	 * 
	 * ...
	 * @author Ktu
	 */
	public class TargetInfo extends Sprite {

		public var currentTarget:Target;
		
		private var output:TextField = new TextField();
		private var bg:Shape = new Shape();
		
		public function TargetInfo() {
			addChild(bg);
			addChild(output);
			drawBG();
			setupTextField ();
		}
		
		private function drawBG():void {
			bg.graphics.lineStyle(1, 0x666666, 1, true, "none", "none", "none");
			bg.graphics.beginFill(0x66FFFF, .2);
			bg.graphics.drawRect (0, 0, 150, 200);
			bg.graphics.endFill();
		}
		
		private function setupTextField():void {
			output.width = 150;
			output.height = 200;
		}
		
		public function onTargetSelected (e:MouseEvent = null):void {
			currentTarget = Target(e.target);
			rewrite();
			// setup a timer to have it check again because of double click shit
		}
		
		private function rewrite ():void {
			var str:String = "Target:";
			str += "\n";
			str += "name: " + currentTarget.name;
			str += "\n";
			str += "x: " + currentTarget.x;
			str += "\n";
			str += "y: " + currentTarget.y;
			str += "\n";
			str += "width: " + currentTarget.width;
			str += "\n";
			str += "height: " + currentTarget.height;
			str += "\n";
			str += "x offset: " + currentTarget.originX;
			str += "\n";
			str += "y offset: " + currentTarget.originY;
			str += "\n";
			str += "bounds.x: " + currentTarget.getBounds(stage).left;
			str += "\n";
			str += "bounds.y: " + currentTarget.getBounds(stage).top;
			
			output.text = str;
		}
	}

}