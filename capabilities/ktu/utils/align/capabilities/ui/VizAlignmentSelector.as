package ktu.utils.align.capabilities.ui {
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.Panel;
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
			list.width += 90;
			
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
			
			
			
			// adder pop up
			
			var panel:Panel = new Panel(this);
			//panel.visible = false;
			panel.setSize(460, 190);
			panel.x = -125;
			panel.y = -15;
			
			var methodLabel:Label = new Label(panel, 20, 10, "choose method:");
			
			var methodList:List = new List(panel, methodLabel.x + 10, methodLabel.y + methodLabel.height + 10);
			methodList.width = 180;
			var tcsLabel:Label = new Label(panel, methodList.x + methodList.width + 40, 10, "choose tcs:");
			var tcsList:List = new List(panel, tcsLabel.x + 10, tcsLabel.y + tcsLabel.height + 10);
			tcsList.width = 180;
			
			var cancel:PushButton = new PushButton(panel, 0, panel.height - 30 - 10, "cancel");
			cancel.width = 60;
			cancel.height = 30;
			cancel.x = tcsList.x + tcsList.width - cancel.width;
			var ok:PushButton = new PushButton(panel, 0, panel.height - 30 - 10, "ok");
			ok.width = 60;
			ok.height = 30;
			ok.x = cancel.x - ok.width - 10;
			
			
			
		}
		
		private function onUpClicked():void {
			
		}
		
		
		
		private function onAddClick():void {
			
		}
		
		private function onRemoveClick():void {
			
		}
	}

}