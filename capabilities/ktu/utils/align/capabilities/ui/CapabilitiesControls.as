package ktu.utils.align.capabilities.ui {
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.flashdynamix.motion.Tweensy;
	import flash.display.DisplayObject;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import ktu.utils.align.capabilities.gfx.Target;
	import ktu.utils.align.capabilities.gfx.TargetInfo;
	import ktu.utils.align.VizAlign;
	import ktu.utils.align.VizAlignGroup;
	import ktu.utils.align.VizAlignTarget;
	
	
	/**
	*
	* 	This is the main control panel
	*
	* 	I will have a preset selector
	* 				a target selector
	* 				a vizAlingment selector
	* 				a options selector
	* 				a align button
	* 				a reset button
	* ...
	* @author Keelan
	*/
	public class CapabilitiesControls extends Sprite {
		
		private var _targets:Array = [];
		
		public function get targets():Array {
			return _targets;
		}
		public function set targets(value:Array):void {
			_targets = value;
			targetSelector.targets = value;
		}
		private var _targetCoordinateSpaces:Array = [];
		public function get targetCoordinateSpaces():Array {
			return _targetCoordinateSpaces;
		}
		
		public function set targetCoordinateSpaces(value:Array):void {
			_targetCoordinateSpaces = value;
			alignmentSelector.targetCoordinateSpaces = value;
		}
		
		private var presets:Presets;
		
		private var vrule:Sprite;
		
		private var targetSelector:VizAlignTargetSelector;
		private var alignmentSelector:VizAlignmentSelector;
		private var options:VizAlignOptions;
		
		private var vrule2:Sprite;
		
		private var alignButton:PushButton;
		private var resetButton:PushButton;
		
		
		private static const BG_COLOR:uint = Style.BOTTOM;
		private static const VRULE_COLOR:uint = Style.LIST_ROLLOVER;
		
		public function CapabilitiesControls(){
			drawBorder();
			
			// presets
			presets = new Presets();
			presets.x = 20;
			presets.y = 20;
			addChild(presets);
			presets.addEventListener(Event.SELECT, onPresetSelect);
			
			// vrule
			vrule = new Sprite();
			vrule.graphics.lineStyle(1, VRULE_COLOR, 1, true, "none", "none", "none");
			vrule.graphics.lineTo(0, 180);
			vrule.x = 180;
			vrule.y = 10;
			addChild(vrule);
			
			// target selection
			targetSelector = new VizAlignTargetSelector();
			targetSelector.x = 200;
			targetSelector.y = 20;
			addChild(targetSelector);
			
			// vizalignment selection
			alignmentSelector = new VizAlignmentSelector();
			alignmentSelector.x = 310;
			alignmentSelector.y = 20;
			addChild(alignmentSelector);
			
			// options
			options = new VizAlignOptions();
			options.x = 550;
			options.y = 20;
			addChild(options);
			
			// vrule
			vrule2 = new Sprite();
			vrule2.graphics.lineStyle(1, VRULE_COLOR, 1, true, "none", "none", "none");
			vrule2.graphics.lineTo(0, 180);
			vrule2.x = 650;
			vrule2.y = 10;
			addChild(vrule2);
			
			// align button
			alignButton = new PushButton(this, 670, 40, "align", onAlignButtonClick);
			alignButton.width = 60;
			alignButton.height = 50;
			alignButton.label.autoSize = true;
			var fmt:TextFormat = alignButton.label.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			alignButton.label.textField.defaultTextFormat = fmt;
			alignButton.label.text = "align";
			
			// reset button
			resetButton = new PushButton(this, 670, 110, "reset", onResetButtonClicked);
			resetButton.width = 60;
			resetButton.height = 50;
			resetButton.label.autoSize = true;
			fmt = resetButton.label.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			resetButton.label.textField.defaultTextFormat = fmt;
			resetButton.label.text = "reset";
		}
		
		private function drawBorder():void {
			var w:int = 750;
			var h:int = 200;
			graphics.clear();
			graphics.beginFill(0, .9);
			graphics.lineStyle(1, 0, 1, true, "none", "none", "none");
			graphics.moveTo(.5, -.5);
			graphics.lineTo(w - 1, -.5);
			graphics.lineTo(w - 1, h - 1);
			graphics.lineTo(.5, h - 1);
			graphics.lineTo(.5, -.5);
			graphics.endFill();
		}
		
		private function onResetButtonClicked(e:MouseEvent):void {
			for each (var t:Target in targets) {
				t.reset(options.animate.selected);
			}
		}
		
		private function onAlignButtonClick(e:MouseEvent):void {
			var targets:Array = targetSelector.chosenTargets;
			var groups:Array = createGroups(targets);
			var vizAlignments:Array = alignmentSelector.chosenAlignments;
			var ignoreOrigins:Boolean = options.ignoreOrigins.selected;
			var pixelHinting:Boolean = options.pixelHinting.selected;
			var applyResults:Boolean = !options.animate.selected;
			// call VizAlign
			var results:Array = VizAlign.align (groups, vizAlignments, ignoreOrigins, applyResults, pixelHinting);
			if (!applyResults) {
				animateTargets(results);
			}
		}
		
		private function animateTargets(array:Array):void {
			for each (var t:VizAlignTarget in array) {
				if (t is VizAlignGroup) {
					var tg:VizAlignGroup = t as VizAlignGroup;
					animateTargets(tg.targets);
				} else {
					var prop:Object = { };
					var e:Rectangle = t.end;
					prop.x = e.x;
					prop.y = e.y;
					prop.width = e.width;
					prop.height = e.height;
					Tweensy.to(t.target, prop, .6);
				}
			}
		}
		
		private function drawRectangle(rect:Rectangle, color:uint, alpha:Number):void {
			var sp:Sprite = new Sprite ();
			sp.graphics.lineStyle(2, color, alpha);
			sp.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			stage.addChild(sp);
		}
		
		private function createGroups(targets:Array):Array {
			var groups:Array = [[], [], [], [], []];
			var nongroups:Array = [];
			for each (var t:Target in targets) {
				if (t.group > 0) {
					groups[t.group].push(t);
				} else {
					nongroups.push(t);
				}
			}
			var finalGroups:Array = [];
			for (var i:int = 0; i < groups.length; i++) {
				if (groups[i].length > 0) {
					finalGroups.push(groups[i]);
				}
			}
			finalGroups = finalGroups.concat(nongroups);
			if (finalGroups.length == 0) return targets;
			else return finalGroups;
		}
		
		private function onPresetSelect(e:Event):void {
			// spread the info out to the approrpiate controls
			var item:Object = Presets(e.target).list.selectedItem;
			targetSelector.setTargets(item.targets);
			alignmentSelector.setAlignments(item.vizAlignments);
			options.setOptions(item.options);
		}
		
	}
}