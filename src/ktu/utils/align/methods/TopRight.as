package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class TopRight extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				targets[i].x = tcsRightEdge - targets[i].width;
				targets[i].y = tcsTopEdge;
			}
		}
		
	}

}