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
		public var ignoreOrigin:CheckBox;
		public var pixelHinting:CheckBox;
		public var animate:CheckBox;
		
		public function VizAlignOptions() {
			var spacer:int = 20;
			header = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "and:";
			
			ignoreOrigin = new CheckBox(this, 10, header.height + 30, "ignore origins");
			pixelHinting = new CheckBox(this, 10, ignoreOrigin.y + ignoreOrigin.height + spacer, "pixel hinting");
			animate = new CheckBox(this, 10, pixelHinting.y + pixelHinting.height + spacer, "animate");
		}
		
	}

}