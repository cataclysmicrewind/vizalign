package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	/**
	 * ...
	 * @author ...
	 */
	public class BottomAligner implements IRectangleAligner {
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom; 
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = tcsBottomEdge - targets[i].height;
		}
		
	}

}