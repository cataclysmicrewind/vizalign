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
		
		public var targets:Array;
		
		private var t1:CheckBox;
		private var t2:CheckBox;
		private var t3:CheckBox;
		private var t4:CheckBox;
		private var t5:CheckBox;
		
		public function VizAlignTargetSelector() {
			var spacer:int = 10;
			
			var header:Label = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "align the:";
			
			t1 = new CheckBox(this, 10, header.height + spacer*2, "green");
			t2 = new CheckBox(this, 10, t1.y + t1.height + spacer, "red");
			t3 = new CheckBox(this, 10, t2.y + t2.height + spacer, "blue");
			t4 = new CheckBox(this, 10, t3.y + t3.height + spacer, "cyan");
			t5 = new CheckBox(this, 10, t4.y + t4.height + spacer, "yellow");
		}
		
		private function getTargetByName(label:String):* {
			for each (var target in targets) {
				if (target.name == label) return target;
			}
		}
		
		
		public function get chosenTargets():Array {
			var t:Array = [];
			if (t1.selected) t.push (getTargetByName(t1.label));
			if (t2.selected) t.push (getTargetByName(t2.label));
			if (t3.selected) t.push (getTargetByName(t3.label));
			if (t4.selected) t.push (getTargetByName(t4.label));
			if (t5.selected) t.push (getTargetByName(t5.label));
			return t;
		}
	}

}