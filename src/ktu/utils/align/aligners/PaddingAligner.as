package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	
	/**
	 * PaddingAligner pads the target by the values of the targetCoordinateSpace.
     * 
	 * @author ktu
	 */
	public class PaddingAligner implements IRectangleAligner {
		
		public function PaddingAligner(){
		
		}
		
		/* INTERFACE ktu.utils.align.IRectangleAligner */
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array /*Rectangle*/):void {
            var tcsX:Number = targetCoordinateSpace.x;
            var tcsY:Number = targetCoordinateSpace.y;
            var tcsW:Number = targetCoordinateSpace.width;
            var tcsH:Number = targetCoordinateSpace.height;
            var length:int = targets.length;									// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) { 							// loop through all targets
                var target:Rectangle = targets[i];                              // reference to current target
				target.x += tcsX;
                target.y += tcsY;
                target.width -= tcsW + tcsX;
                target.height -= tcsH + tcsY;
            }
		}
	
	}

}