package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class AdjacentTopLeftAlignMethod extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsTopEdge:Number = targetCoordinateSpace.top;
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var target:Rectangle = targets[i];
				target.x = tcsLeftEdge - target.width;
				target.y = tcsTopEdge - target.height;
			}
		}
		
	}

}