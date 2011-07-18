package ktu.utils.align.capabilities.ui {
	import com.bit101.components.CheckBox;
	import com.bit101.components.Label;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Keelan
	 */
	public class VizAlignTargetSelector extends Sprite {
		
		public function VizAlignTargetSelector() {
			var spacer:int = 10;
			
			var header:Label = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "align the:";
			
			var t1:CheckBox = new CheckBox(this, 10, header.height + spacer*2, "green");
			var t2:CheckBox = new CheckBox(this, 10, t1.y + t1.height + spacer, "red");
			var t3:CheckBox = new CheckBox(this, 10, t2.y + t2.height + spacer, "blue");
			var t4:CheckBox = new CheckBox(this, 10, t3.y + t3.height + spacer, "cyan");
			var t5:CheckBox = new CheckBox(this, 10, t4.y + t4.height + spacer, "yellow");
		}
		
	}

}