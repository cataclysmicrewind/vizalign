package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class BottomLeft extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				targets[i].x = tcsLeftEdge;
				targets[i].y = tcsBottomEdge - targets[i].height;
			}
		}
		
	}

}