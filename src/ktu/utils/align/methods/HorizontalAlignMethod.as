package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class HorizontalAlignMethod implements IAlignMethod {
		
		public function alignTargetsToTCS(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var mid:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);	// get center x value of target coordinate space object
			var length:int = targets.length;													// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )												// loop through all targets
				targets[i].x = mid - (targets[i].width / 2);									// 		grab current target as item
		}
		
	}

}