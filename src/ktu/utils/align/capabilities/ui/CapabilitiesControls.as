package ktu.utils.align.capabilities.ui {
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import flash.display.DisplayObject;
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
			Style.embedFonts = false;
			Style.fontName = "Consolas"
			Style.fontSize = 14;
			
			presets = new Presets();
			presets.x = 20;
			presets.y = 20;
			addChild(presets);
			
			targetSelector = new VizAlignTargetSelector();
			targetSelector.x = 180;
			targetSelector.y = 20;
			addChild(targetSelector);
			
			var alignmentSelector:VizAlignmentSelector = new VizAlignmentSelector();
			alignmentSelector.x = 290;
			alignmentSelector.y = 20;
			addChild(alignmentSelector);
			
			options = new VizAlignOptions();
			options.x = 520;
			options.y = 20;
			addChild(options);
			
			alignButton = new PushButton(this, 680, 80, "align", onAlignButtonClick);
			alignButton.width = 50;
			var fmt:TextFormat = alignButton.label.textField.getTextFormat();
			fmt.bold = true;
			alignButton.label.textField.defaultTextFormat = fmt;
			alignButton.label.text = "align";	
			
			resetButton = new PushButton(this, 680, 130, "reset", onResetButtonClicked);
			resetButton.width = 50;
			fmt = resetButton.label.textField.getTextFormat();
			fmt.bold = true;
			resetButton.label.textField.defaultTextFormat = fmt;
			resetButton.label.text = "reset";
		}
		
		
		
		private function onResetButtonClicked(e:MouseEvent):void {
			
		}
		
		private function onAlignButtonClick(e:MouseEvent):void {
			
		}
	}
}