package ktu.utils.align.capabilities.ui {
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	/**
	 * Presets represents the controls for selecting a preset.
	 * 
	 * all presets are hard coded into the application.
	 * 
	 * The presets are here to show you some common / interesting combonations using VizAlign.
	 * 
	 * 
	 * @author Ktu
	 */
	public class Presets extends Sprite {
		
		// the label at the top saying 'presets:'
		private var header:Label;
		
		// ui control list for showing the presets
		public var list:List;
		
		/**
		 * constructor
		 * 
		 * initializes, then sets the presets
		 */
		public function Presets() {
			initialize();
			addPresets();
		}
		/**
		 * create the ui and place them in the display list
		 */
		private function initialize():void {
			header = new Label(this, 0, 0);
			var fmt:TextFormat = header.textField.getTextFormat();
			fmt.bold = true;
			fmt.size = 18;
			header.textField.defaultTextFormat = fmt;
			header.text = "presets:";
			
			list = new List(this, 0, header.height + 30);
			list.width += 40;
			list.height += 20
			list.addEventListener(Event.SELECT, onPresetSelect);
			
			header.x = 30;
		}
		/**
		 * adds all of the hard coded presets into the list control
		 */
		private function addPresets():void {
			var item:Object = { };
			item.label = "left ";
			item.targets = ["green", "purple"];
			item.vizAlignments = [ { type:"left", tcs:"grid" } ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
			
			item = { };
			item.label = "scaleToFit & center";
			item.targets = ["yellow", "cyan"];
			item.vizAlignments = [ { type:"scaleToFit", tcs:"grid" }, {type:"center", tcs:"grid"} ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
			
			item = { };
			item.label = "adjacentBottom";
			item.targets = ["red", "yellow"];
			item.vizAlignments = [ { type:"adjacentBottom", tcs:"grid" } ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
			
			item = { };
			item.label = "adjacentBottomRight";
			item.targets = ["cyan", "purple"];
			item.vizAlignments = [ { type:"adjacentBottomRight", tcs:"vizalign logo" } ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
			
			item = { };
			item.label = "spaceVertical";
			item.targets = ["green", "purple", "red", "cyan", "yellow"];
			item.vizAlignments = [ { type:"spaceVertical", tcs:"arena" } ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
			
			item = { };
			item.label = "stackHorizontal";
			item.targets = ["green", "purple", "cyan", "yellow"];
			item.vizAlignments = [ { type:"stackHorizontal", tcs:"red" } ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
			
			item = { };
			item.label = "stackHorizontal & vertical";
			item.targets = ["green", "purple", "cyan", "yellow"];
			item.vizAlignments = [ { type:"vertical", tcs:"red" }, { type:"stackHorizontal", tcs:"red" } ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
			
			item = { };
			item.label = "adjacentHorizontalLeft & spaceVertical";
			item.targets = ["cyan", "red", "purple"];
			item.vizAlignments = [ { type:"adjacentHorizontalLeft", tcs:"grid" }, { type:"spaceVertical", tcs:"grid" } ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
			
			item = { };
			item.label = "scaleToFill & center";
			item.targets = ["cyan"];
			item.vizAlignments = [ { type:"scaleToFill", tcs:"grid" }, { type:"center", tcs:"grid" } ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
			
			item = { };
			item.label = "distributeTop & left";
			item.targets = ["cyan", "red", "purple", "yellow", "green"];
			item.vizAlignments = [ { type:"distributeTop", tcs:"grid" }, { type:"left", tcs:"grid" } ];
			item.options = ["ignoreOrigins", "animate"];
			list.addItem(item);
		}
		
		/**
		 * when a preset has been selected, i dispatch an event so someone can know (in this case the CapabilitiesControls object)
		 * @param	e
		 */
		private function onPresetSelect(e:Event):void {
			dispatchEvent(e);
		}
		
		
	}
}