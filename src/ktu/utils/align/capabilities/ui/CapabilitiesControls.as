package ktu.utils.align.capabilities.ui {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
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
		
		
		
		public function CapabilitiesControls() {
			
		}
		
		
		public function addTarget(target:DisplayObject):void {
			targets.push(target);
		}
		public function addTCS(tcs:DisplayObject):void {
			targetCoordinateSpaces.push(tcs);
		}
	}

}