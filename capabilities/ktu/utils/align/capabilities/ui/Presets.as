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
		private var header:Label;
		private var list:List;
		
		public function Presets() {
			initialize();
			addPresets();
		}
		
		private function initialize():void {
			header = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "presets:";
			
			list = new List(this, 0, header.height + 20);
			list.width += 40;
			list.height += 20
			
			header.x = 30;
		}
		
		private function addPresets():void {
			var item:Object = { };
			item.label = "left ";
			list.addItem(item);
			
			item = { };
			item.label = "scaleToFit & center";
			list.addItem(item);
			
			item = { };
			item.label = "adjacentBottom";
			list.addItem(item);
			
			item = { };
			item.label = "adjacentBottomRight";
			list.addItem(item);
			
			item = { };
			item.label = "spaceVertical";
			list.addItem(item);
			
			item = { };
			item.label = "stackHorizontal";
			list.addItem(item);
			
			item = { };
			item.label = "stackHorizontal & vertical";
			list.addItem(item);
			
		}
		
		
	}
}