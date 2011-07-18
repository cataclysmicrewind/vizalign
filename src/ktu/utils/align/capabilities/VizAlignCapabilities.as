package ktu.utils.align.capabilities {
	import flash.display.Sprite;
	import ktu.utils.align.capabilities.ui.Target;
	
	/**
	 * 	This class is the Document class for the Capabilities SWF.
	 *
	 * 	This swf is designed to show off what VizAlign can do
	 *
	 *
	 * ...
	 * @author Keelan
	 */
	public class VizAlignCapabilities extends Sprite{
		
		public function VizAlignCapabilities() {
			var t:Target = new Target();
			t.setOriginOffset(-50, -50);
			addChild(t);
		}
		
	}

}