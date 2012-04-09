package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	
	/**
	 * ConstriantAligner allows you to specify a rectangle that the targets must stay within.
     * 
     * if ignoreSize = true, then it will only make sure the x and y are within it,
     * if ignoreSize = false, then it will make sure the entire target is within it
     * 
	 * @author ktu
	 */
	public class ConstraintAligner implements IRectangleAligner {
		
        public var includeSize:Boolean;
        
		public function ConstraintAligner(includeSize:Boolean = false){
            this.includeSize = includeSize;
		}
		
		/* INTERFACE ktu.utils.align.IRectangleAligner */
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array /*Rectangle*/):void {
            var tcsX:Number = targetCoordinateSpace.x;
            var tcsY:Number = targetCoordinateSpace.y;
            var tcsW:Number = targetCoordinateSpace.width;
            var tcsH:Number = targetCoordinateSpace.height;
			var length:int = targets.length;
			for ( var i:int = 0; i < length; i++ ) {
                var target:Rectangle = targets[i];
				if (target.x < tcsX) target.x = tcsX;
                if (target.y < tcsY) target.y = targetCoordinateSpace.y;
                
                if (includeSize) {
                    if (target.right > tcsW) target.x = tcsW - target.width;
                    if (target.bottom > tcsH) target.y = tcsH - target.height;
                } else {
                    if (target.x > tcsW) target.x = tcsW;
                    if (target.y > tcsH) target.y = tcsH;
                }
            }
		}
	}
}