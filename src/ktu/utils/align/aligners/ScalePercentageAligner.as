package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	
	/**
	 * scale the targets to be a certain percentage of the targetCoordinateSpace
	 * @author ktu
	 */
	public class ScalePercentageAligner implements IRectangleAligner {
        
        public var x:Number;
        public var y:Number;
        public var w:Number;
        public var h:Number;
        public var ignorePos:Boolean;
		
		public function ScalePercentageAligner(x:Number = 1, y:Number = 1, w:Number = 1, h:Number = 1, ignorePos:Boolean = false ) {
            this.x = x;
            this.y = y;
            this.w = w;
            this.h = h;
            this.ignorePos = ignorePos;
		}
		
		/* INTERFACE ktu.utils.align.IRectangleAligner */
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array /*Rectangle*/):void {
            var tcsWidth:Number = targetCoordinateSpace.width;				    // get width of target coordinate space object
            var tcsHeight:Number = targetCoordinateSpace.height;				// get height of target coordinate space object
			var length:int = targets.length;									// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) { 							// loop through all targets
                var target:Rectangle = targets[i];                              // reference to current target
				target.x = tcsWidth * x; 
                if (!ignorePos) target.x += targetCoordinateSpace.x;
                target.y = tcsHeight * y;
                if (!ignorePos) target.y += targetCoordinateSpace.y;
                if (w != -1 ) target.width = tcsWidth * w;
                if (h != -1 ) target.height = tcsHeight * h;
            }
		}
	
	}

}