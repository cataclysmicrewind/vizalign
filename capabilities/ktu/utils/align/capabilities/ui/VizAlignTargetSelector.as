package ktu.utils.align.capabilities.ui {
	import com.bit101.components.CheckBox;
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.flashdynamix.motion.Tweensy;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import ktu.utils.align.capabilities.gfx.Chain;
	import ktu.utils.align.capabilities.gfx.Target;
	/**
	 * ...
	 * @author Keelan
	 */
	public class VizAlignTargetSelector extends Sprite {
		
		public var targets:Array;
		
		private var tList:Array = [];;
		private var t1:CheckBox;
		private var t2:CheckBox;
		private var t3:CheckBox;
		private var t4:CheckBox;
		private var t5:CheckBox;
		private var settings:PushButton;
		private var settingsPanel:Panel;
		private var targetModeLabel:Label;
		private var targetModeRectangle:RadioButton;
		private var targetModeShape:RadioButton;
		private var groupsMode:CheckBox;
		private var settingsClose:PushButton;
		private var g1:Chain;
		private var g2:Chain;
		private var g3:Chain;
		private var g4:Chain;
		private var g5:Chain;
		
		public function VizAlignTargetSelector() {
			var spacer:int = 10;
			
			var header:Label = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "align the:";
			
			// create target selectors
			t1 = new CheckBox(this, 10, header.height + 10 + spacer*2, "green");
			t2 = new CheckBox(this, 10, t1.y + t1.height + spacer, "red");
			t3 = new CheckBox(this, 10, t2.y + t2.height + spacer, "purple");
			t4 = new CheckBox(this, 10, t3.y + t3.height + spacer, "cyan");
			t5 = new CheckBox(this, 10, t4.y + t4.height + spacer, "yellow");
			tList = [t1, t2, t3, t4, t5];
			
			settings = new PushButton(this, 10, t5.y + t5.height + spacer, "settings", onSettingsClick);
			settings.width -= 30;
			
			// create group ui...
			g1 = new Chain();
			g1.x = settings.x + settings.width - g1.width + 5;
			g1.y = t1.y;
			g1.visible = false;
			g1.target = "green";
			addChild(g1);
			g2 = new Chain();
			g2.x = settings.x + settings.width - g1.width + 5;
			g2.y = t2.y;
			g2.visible = false;
			g2.target = "red";
			addChild(g2);
			g3 = new Chain();
			g3.x = settings.x + settings.width - g1.width + 5;
			g3.y = t3.y;
			g3.visible = false;
			g3.target = "purple";
			addChild(g3);
			g4 = new Chain();
			g4.x = settings.x + settings.width - g1.width + 5;
			g4.y = t4.y;
			g4.visible = false;
			g4.target = "cyan";
			addChild(g4);
			g5 = new Chain();
			g5.x = settings.x + settings.width - g1.width + 5;
			g5.y = t5.y;
			g5.visible = false;
			g5.target = "yellow";
			addChild(g5);
			
			// create settings ui
			
			settingsPanel = new Panel(this, 0, 0);
			settingsPanel.setSize(100, 160);
			
			targetModeLabel = new Label(settingsPanel, 5, 5, "target mode:");
			targetModeRectangle = new RadioButton(settingsPanel, 15, targetModeLabel.y + targetModeLabel.height + 10, "rectangles", true, onRectangleMode);
			targetModeShape = new RadioButton(settingsPanel, 15, targetModeRectangle.y + targetModeRectangle.height + 10, "shapes", false, onShapeMode);
			
			groupsMode = new CheckBox(settingsPanel, 5, 100, "allow groups", onGroupModeClick);
			
			settingsClose = new PushButton(settingsPanel, 5, 0, "close", onSettingsCloseClick);
			settingsClose.y = settingsPanel.height - settingsClose.height - 5;
			settingsClose.width = settingsPanel.width - 10;
			
			settingsPanel.y = settingsPanel.height + 50;
		}
		
		
		
		private function getTargetByName(label:String):* {
			for each (var target:Target in targets) {
				if (target.name == label) return target;
			}
		}
		
		
		public function get chosenTargets():Array {
			var t:Array = [];
			for each (var tchk:CheckBox in tList) {
				if (tchk.selected) t.push(getTargetByName(tchk.label));
			}
			return t;
		}
		
		public function setTargets(targets:Array):void {
			for each (var c:CheckBox in tList) {
				c.selected = false;
			}
			for (var i:int = 0; i < targets.length; i++) {
				var tn:String = targets[i];
				for (var j:int = 0; j < tList.length; j++) {
					var chk:CheckBox = tList[j];
					if (chk.label == tn) {
						chk.selected = true;
						break;
					}
				}
			}
		}
		
		
		private function onSettingsClick(e:Event):void {
			// show a panel with some settings...
			Tweensy.to (settingsPanel, { y:0 } );
		}
		
		private function onSettingsCloseClick(e:Event):void {
			// close the panel
			Tweensy.to (settingsPanel, { y:settingsPanel.height + 50 } );
		}
		
		
		
		private function onShapeMode(e:Event):void {
			for each (var t:Target in targets) {
				t.renderShape = true;
			}
		}
		
		private function onRectangleMode(e:Event):void {
			for each (var t:Target in targets) {
				t.renderShape = false;
			}
		}
		
		
		
		private function onGroupModeClick(e:Event):void {
			var mode:Boolean = groupsMode.selected;
			
			var gs:Array = [g1, g2, g3, g4, g5];
			for each (var g:Chain in gs) {
				g.visible = mode;
				if (mode) {
					g.addEventListener(MouseEvent.CLICK, onChainClick);
				} else {
					g.removeEventListener(MouseEvent.CLICK, onChainClick);
					g.reset();
				}
			}
			for each (var t:Target in targets) {
				t.group = 0;
			}
		}
		
		private function onChainClick(e:MouseEvent):void {
			var group:Chain = Chain(e.currentTarget);
			group.plusOne();
			var target:Target = getTargetByName(group.target);
			target.group = group.id;
		}
	}
}