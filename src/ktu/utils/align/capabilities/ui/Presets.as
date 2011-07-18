package ktu.utils.align.capabilities.ui {
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Ktu
	 */
	public class Presets extends Sprite {
		
		public function Presets() {
			var header:Label = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "presets:";
			
			var list:List = new List(this, 10, header.height + 20);
			list.width += 20;
		}
	}
}