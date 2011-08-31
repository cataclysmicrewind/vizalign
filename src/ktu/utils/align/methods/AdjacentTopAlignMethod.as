package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class AdjacentTopAlignMethod implements IAlignMethod {
		
		public function alignTargetsToTCS(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var length:int = targets.length;													// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = tcsTopEdge - targets[i].height;
		}
		
	}

}