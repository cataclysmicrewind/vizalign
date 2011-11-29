package ktu.utils.align.capabilities.gfx {
	import com.bit101.components.CheckBox;
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.Style;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * 
	 * 	Displays Last Selected target information
	 * 
	 * 	simply, it is told which target to track, and onEnterFrame, it updates the values it cares about
	 * 
	 * ...
	 * @author Ktu
	 */
	public class TargetInfo extends Sprite {

		public var currentTarget:Target;
		
		private var panel:Panel;
		private var header:Label;
		private var targetDetails:Label;
		private var targetName:Label;
		private var targetProps:Label;
		private var vrule:Sprite;
		
		private static const VRULE_COLOR:uint = Style.LIST_ROLLOVER
		
		private var showOrigin:CheckBox;
		private var tab:Panel;
		private var _open:Boolean = false;
		private var tabLabel:Label;
		
		
		public function TargetInfo() {
			build();
			open = false;
		}
		
		
		public function onTargetSelected (e:MouseEvent = null):void {
			if (currentTarget) currentTarget.removeEventListener(Event.ENTER_FRAME, update);
			
			currentTarget = Target(e.target);
			currentTarget.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void {
			rewrite();
		}
		
		private function rewrite ():void {
			
			var fmt:TextFormat = new TextFormat(null, null, currentTarget.color, true);
			fmt.align = "center";
			fmt.size = 18;
			targetName.textField.defaultTextFormat = fmt;
			
			var name:String = currentTarget.name;
			targetName.text = name;
			
			
			var props:String = "";
			props += "x";
			props += "\n";
			props += "y";
			props += "\n";
			props += "width";
			props += "\n";
			props += "height";
			props += "\n";
			props += "x offset";
			props += "\n";
			props += "y offset";
			props += "\n";
			props += "getBounds().x";
			props += "\n";
			props += "getBounds().y";
			
			fmt = targetProps.textField.getTextFormat();
			fmt.align = "right";
			targetProps.textField.defaultTextFormat = fmt;
			
			targetProps.text = props;
			
			
			
			
			var str:String = "";
			str += currentTarget.x;
			str += "\n";
			str += currentTarget.y;
			str += "\n";
			str += currentTarget.width;
			str += "\n";
			str += currentTarget.height;
			str += "\n";
			str += currentTarget.originX;
			str += "\n";
			str += currentTarget.originY;
			str += "\n";
			str += currentTarget.getBounds(stage).left;
			str += "\n";
			str += currentTarget.getBounds(stage).top;
			
			targetDetails.text = str;
			
			
			
			if (currentTarget) {
				showOrigin.visible = true;
				showOrigin.selected = currentTarget.showOrigin;
			}
			
			
			if (vrule && vrule.parent) return; 
			
			vrule = new Sprite();
			vrule.graphics.lineStyle(1, VRULE_COLOR, 1, true, "none", "none", "none");
			vrule.graphics.lineTo(0, 120);
			vrule.x = 100;//targetProps.x + targetProps.width + 3;
			vrule.y = targetProps.y;
			addChild(vrule);
			
		}
		
		private function build():void {
			
			// tab
			tab = new Panel(this, 0, 0);
			tabLabel = new Label(this, 0, 0, "target info");
			tabLabel.textField.selectable = true;
			tab.height = tabLabel.height
			tabLabel.width = tabLabel.textField.textWidth + 4
			tabLabel.x = 150/2 - tabLabel.width / 2 - 25;
			tab.addChild(tabLabel);
			tab.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				open = !open;
			});
			
			
			
			// main panel
			panel = new Panel(this);
			panel.width = 150;
			panel.height = 220;
			panel.color = Style.BOTTOM;
			panel.draw();
			
			
			header = new Label(panel, 5, 5, "Target Info:");
			header.autoSize = false;
			header.width = panel.width - 10;
			
			var infoPanel:Panel = new Panel(panel, 5, header.y + header.height + 10);
			infoPanel.width = panel.width - 10;
			infoPanel.height = panel.height - infoPanel.y - 5 - 20;
			
			
			
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			fmt.align = "center";
			header.textField.defaultTextFormat = fmt;
			header.text = "target info:";
			
			
			targetName = new Label(panel, 5, header.y + header.height + 15);
			targetName.autoSize = false;
			targetName.width = panel.width - 10;
			
			targetProps = new Label(panel, 0, header.y + header.height + 5 + 40);
			targetProps.textField.multiline = true;
			targetProps.x = 20;
			
			targetDetails = new Label(panel, 110, header.y + header.height + 5 + 40);
			targetDetails.width = panel.width - 110;
			targetDetails.height = panel.height - targetDetails.y - 5;
			targetDetails.textField.multiline = true;
			
			showOrigin = new CheckBox(panel, 10, 0, "show origin", onShowOrigin);
			showOrigin.y = panel.height - showOrigin.height - 10;
			showOrigin.width = panel.width - 20;
			showOrigin.visible = false;
		}
		
		private function onShowOrigin(e:Event):void {
			currentTarget.showOrigin = !currentTarget.showOrigin;
			currentTarget.redraw();
		}
		
		public function get open():Boolean {
			return _open;
		}
		
		public function set open(value:Boolean):void {
			_open = value;
			if (_open) {
				// open position
				tab.rotation = 0;
				tab.x = 150 / 2 - tab.width / 2;
				tab.y = 0 - tab.height;
			} else {
				// closed position
				tab.rotation = -90;
				tab.x = -tab.height
				tab.y = panel.height / 2 + tab.width / 2;
			}
			dispatchEvent(new StatusEvent("open"));
		}
		
	}

}