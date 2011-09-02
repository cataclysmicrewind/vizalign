package ktu.utils.align.capabilities.ui {
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.flashdynamix.motion.Tweensy;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.utils.describeType;
	import ktu.utils.align.aligners.AlignerManifest;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.align.RectangleAlignment;
	
	/**
	 * ...
	 * @author Keelan
	 */
	public class VizAlignmentSelector extends Sprite {
		
		private var _targetCoordinateSpaces:Array;
		
		public function get targetCoordinateSpaces():Array {
			return _targetCoordinateSpaces;
		}
		public function set targetCoordinateSpaces(value:Array):void {
			_targetCoordinateSpaces = value;
			updateTCSList();
		}
		
		
		private var header:Label;
		
		private var list:List;
		private var up:PushButton;
		private var down:PushButton;
		private var add:PushButton;
		private var remove:PushButton;
		
		private var panel:Panel;
		private var methodLabel:Label;
		private var methodList:List;
		private var tcsLabel:Label;
		private var tcsList:List;
		private var ok:PushButton;
		private var cancel:PushButton;
		
		public function VizAlignmentSelector() {
			
			header = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "to:";
			
			list = new List(this, 10, header.height + 30);
			list.width += 90;
			
			up = new PushButton(this, list.x + list.width, list.y, "△", onUpClicked);
			up.width = 20,
			up.height = 20;
			
			down = new PushButton(this, list.x + list.width, list.y + list.height, "▽", onDownClicked);
			down.width = 20;
			down.height = 20;
			down.y -= down.height;
			
			remove = new PushButton(this, list.width, list.y + list.height, "remove", onRemoveClick);
			remove.width = 60;
			remove.height = 20;
			remove.x = list.width - remove.width;
			
			add = new PushButton(this, 10, list.y + list.height, "add", onAddClick);
			add.width = 40;
			add.height = 20;
			
			
			
			
			// adder pop up
			
			panel = new Panel(this);
			panel.setSize(460, 190);
			panel.x = -125;
			panel.y = panel.height;
			panel.alpha = 0;
			
			methodLabel = new Label(panel, 20, 10, "choose method:");
			
			methodList = new List(panel, methodLabel.x + 10, methodLabel.y + methodLabel.height + 10);
			methodList.width = 180;
			methodList.height += 40;
			
			
			var alignMethodsDescription:XML = describeType(AlignerManifest);
			var ar:Array = [];
			for (var i:int = 0; i < alignMethodsDescription.accessor.length(); i++) {
				if (alignMethodsDescription.accessor[i].@name == "prototype") continue;
				ar.push(alignMethodsDescription.accessor[i].@name);
			}
			ar.sort();
			for each (var method:String in ar) {
				methodList.addItem(method);
			}
			
			
			tcsLabel = new Label(panel, methodList.x + methodList.width + 40, 10, "choose tcs:");
			
			tcsList = new List(panel, tcsLabel.x + 10, tcsLabel.y + tcsLabel.height + 10);
			tcsList.width = 180;
			
			tcsList.addItem("alignButton");
			tcsList.addItem("stage");
			tcsList.addItem("red");
			tcsList.addItem("green");
			tcsList.addItem("blue");
			
			
			cancel = new PushButton(panel, 0, panel.height - 30 - 10, "cancel", onCancelClick);
			cancel.width = 60;
			cancel.height = 30;
			cancel.x = tcsList.x + tcsList.width - cancel.width;
			
			ok = new PushButton(panel, 0, panel.height - 30 - 10, "ok", onOkClick);
			ok.width = 60;
			ok.height = 30;
			ok.x = tcsList.x;//cancel.x - ok.width - 10;
			
			
			
		}
		
		private function onUpClicked(e:Event):void {
			//move selected item in list up one
			if (list.selectedItem) {
				var items:Array = list.items;
				var index:int = list.selectedIndex;
				var toMove:* = items.splice(index, 1)[0];
				items.splice(index - 1, 0, toMove);
				list.items = items;
				list.selectedIndex = index - 1;
			}
		}
		
		private function onDownClicked(e:Event):void {
			//move selected item in list down one
			if (list.selectedItem) {
				var items:Array = list.items;
				var index:int = list.selectedIndex;
				var toMove:* = items.splice(index, 1)[0];
				items.splice(index + 1, 0, toMove);
				list.items = items;
				list.selectedIndex = index + 1;
			}
		}
		
		
		private function onAddClick(e:Event):void {
			//show the panel
			panelAnimate(true);
		}
		
		private function onRemoveClick(e:Event):void {
			// remove the selected item from the list
			if (list.selectedItem) {
				list.removeItemAt(list.selectedIndex);
			}
		}
		
		private function onCancelClick(e:Event):void {
			// close the panel, and reset the selections...
			panelAnimate(false);
		}
		
		private function onOkClick(e:Event):void {
			// add the selected method and tcs to list
			var selectedMethod:String = methodList.selectedItem as String;
			var selectedTCS:String = tcsList.selectedItem as String;
			
			var newItem:Object = { };
			newItem.label = selectedMethod + " : " + selectedTCS;
			list.addItem(newItem);
			panelAnimate(false);
		}
		
		private function updateTCSList():void {
			tcsList.items = [];
			tcsList.addItem("stage");
			tcsList.addItem("to targets");
			for each (var tcs:DisplayObject in _targetCoordinateSpaces) {
				tcsList.addItem(tcs.name);
			}
			
			// also add any other ones... 
			// or
			// have other controls add more
		}
		
		private function panelAnimate(animateIn:Boolean):void {
			if (animateIn) 
				Tweensy.to (panel, { y: -15, alpha:1 }, .4 );
			else
				Tweensy.to (panel, { y: panel.height, alpha:0 }, .4 );
		}
		
		
		public function get chosenAlignments():Array {
			// get them all and make VizAlingment into an array
			var ret:Array = [];
			var items:Array = list.items;
			for each (var item:Object in items) {
				var inst:Array = item.label.split(" : ");
				var method:IRectangleAligner = AlignerManifest[inst[0]];
				var tcsName:String = inst[1];
				var tcs:*;
				if (tcsName == "stage") {
					tcs = stage;
				} else if (tcsName == "to targets") {
					tcs = RectangleAlignment.TO_TARGETS;
				} else {
					for each (var atcs:DisplayObject in _targetCoordinateSpaces) {
						if (tcsName == "arena" && atcs.name == "arena") {
							tcs = atcs["bg"];
							break;
						}
						if (atcs.name == tcsName) {
							tcs = atcs;
							break;
						}
					}
				}
				ret.push(new RectangleAlignment(method, tcs));
			}
			return ret;
		}
		
		public function setAlignments(alignments:Array):void {
			list.removeAll();
			for (var i:int = 0; i < alignments.length; i++) {
				var item:Object = alignments[i];
				item.label = item.type + " : " + item.tcs;
				list.addItem(item);
			}
			
		}
	}
}