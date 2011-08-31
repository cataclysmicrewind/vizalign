package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class AdjacentLeftAlignMethod implements IAlignMethod {
		
		public function alignTargetsToTCS(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].x = tcsLeftEdge - targets[i].width;
		}
		
	}

}