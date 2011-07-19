package ktu.utils.align.capabilities.ui {
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import flash.display.DisplayObject;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
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
	public class CapabilitiesControls extends Sprite{
		
		public var targets:Array = [];
		public var targetCoordinateSpaces:Array = [];
		
		private var options:VizAlignOptions;
		private var alignButton:PushButton;
		private var resetButton:PushButton;
		private var targetSelector:VizAlignTargetSelector;
		private var presets:Presets;
		
		public function CapabilitiesControls() {
			drawBorder();
			
			Style.embedFonts = false;
			//Style.fontName = "Consolas"
			//Style.fontName = "Calibri"
			Style.fontName = "Corbel"
			Style.fontSize = 12;
			
			presets = new Presets();
			presets.x = 20;
			presets.y = 20;
			addChild(presets);
			
			var vrule:Sprite = new Sprite ();
			vrule.graphics.lineStyle(1, 0, 1, true, "none", "none", "none");
			vrule.graphics.lineTo(0, 180);
			vrule.x = 180;
			vrule.y = 10;
			addChild(vrule);
			
			targetSelector = new VizAlignTargetSelector();
			targetSelector.x = 200;
			targetSelector.y = 20;
			addChild(targetSelector);
			
			var alignmentSelector:VizAlignmentSelector = new VizAlignmentSelector();
			alignmentSelector.x = 310;
			alignmentSelector.y = 20;
			
			
			options = new VizAlignOptions();
			options.x = 550;
			options.y = 20;
			addChild(options);
			
			addChild(alignmentSelector);
			
			var vrule2:Sprite = new Sprite ();
			vrule2.graphics.lineStyle(1, 0x000000, 1, true, "none", "none", "none");
			vrule2.graphics.lineTo(0, 180);
			vrule2.x = 650;
			vrule2.y = 10;
			addChild(vrule2);
			
			alignButton = new PushButton(this, 670, 40, "align", onAlignButtonClick);
			alignButton.width = 60;
			alignButton.height = 50;
			alignButton.label.autoSize = true;
			var fmt:TextFormat = alignButton.label.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			alignButton.label.textField.defaultTextFormat = fmt;
			alignButton.label.text = "align";	
			
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
			graphics.lineStyle(1, 0, 1, true, "none", "none", "none");
			graphics.moveTo(.5,-.5);
			graphics.lineTo(w-1, -.5);
			graphics.lineTo(w-1, h-1);
			graphics.lineTo(.5, h-1);
			graphics.lineTo(.5, -.5);
		}
		
		
		
		private function onResetButtonClicked(e:MouseEvent):void {
			
		}
		
		private function onAlignButtonClick(e:MouseEvent):void {
			
		}
	}
}