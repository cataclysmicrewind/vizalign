package ktu.utils.align.capabilities {
	import flash.display.Sprite;
	import ktu.utils.align.capabilities.ui.Target;
	
	/**
	 * 	This class is the Document class for the Capabilities SWF.
	 *
	 * 	This swf is designed to show off what VizAlign can do
	 *
	 *
	 *
	 *
	 * Coding Concept:
	 *
	 * 		This class will put a TargetArena in the stage,
	 * 		then a ControlPanel. The control panel is told about
	 * 		all possible Targets and TCSs in the TargetArena
	 * 		The ControlPanel has some TCSs of its own (STAGE, inputs?)
	 *
	 * 		That is all that this class has to do.
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