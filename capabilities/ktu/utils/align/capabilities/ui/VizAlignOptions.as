package ktu.utils.align.capabilities.ui {
	import com.bit101.components.CheckBox;
	import com.bit101.components.Label;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Keelan
	 */
	public class VizAlignOptions extends Sprite {
		
		public var header:Label;
		public var ignoreOrigins:CheckBox;
		public var pixelHinting:CheckBox;
		public var animate:CheckBox;
		
		private var oList:Array = [];
		
		public function VizAlignOptions() {
			var spacer:int = 10;
			header = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "and:";
			
			ignoreOrigins = new CheckBox(this, 10, header.height + 30, "ignore origins");
			pixelHinting = new CheckBox(this, 10, ignoreOrigins.y + ignoreOrigins.height + spacer, "round results");
			animate = new CheckBox(this, 10, pixelHinting.y + pixelHinting.height + spacer, "animate");
			
			oList = [ignoreOrigins, pixelHinting, animate];
		}
		
		
		public function setOptions (options:Array):void {
			for each (var c:CheckBox in oList) {
				c.selected = false;
			}
			for (var i:int = 0; i < options.length; i++) {
				this[options[i]].selected = true;
			}
			
		}
	}

}