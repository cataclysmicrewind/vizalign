package ktu.utils.align.capabilities.ui {
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Keelan
	 */
	public class VizAlignmentSelector extends Sprite{
		
		public function VizAlignmentSelector() {
			var header:Label = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "to:";
			
			var list:List = new List(this, 10, header.height + 20);
			list.width += 70;
			
			var up:PushButton = new PushButton(this, list.x + list.width, list.y, "△", onUpClicked);
			up.width = 20,
			up.height = 20;
			var down:PushButton = new PushButton(this, list.x + list.width, list.y + list.height, "▽", onUpClicked);
			down.width = 20;
			down.height = 20;
			down.y -= down.height;
			
			
			var add:PushButton = new PushButton(this, 10, list.y + list.height, "add", onAddClick);
			add.width = 40;
			add.height = 20;
			
			var remove:PushButton = new PushButton(this, list.width, list.y + list.height, "remove", onRemoveClick);
			remove.width = 60;
			remove.height = 20;
			remove.x = list.width - remove.width;
			
		}
		
		private function onUpClicked():void {
			
		}
		
		
		
		private function onAddClick():void {
			
		}
		
		private function onRemoveClick():void {
			
		}
	}

}