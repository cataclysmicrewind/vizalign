package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class AdjacentRight extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = tcsRightEdge;
		}
		
	}

}