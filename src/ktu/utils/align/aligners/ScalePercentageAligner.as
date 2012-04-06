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
		
		public function ScalePercentageAligner(x:Number = 1, y:Number = 1, w:Number = 1, h:Number = 1){
            this.x = x;
            this.y = y;
            this.w = w;
            this.h = h;
		}
		
		/* INTERFACE ktu.utils.align.IRectangleAligner */
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array /*Rectangle*/):void {
            var tcsWidth:Number = targetCoordinateSpace.width;				    // get width of target coordinate space object
            var tcsHeight:Number = targetCoordinateSpace.height;				// get height of target coordinate space object
			var length:int = targets.length;									// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) { 							// loop through all targets
                var target:Rectangle = targets[i];                              // reference to current target
				target.x = tcsWidth * x + targetCoordinateSpace.x;
                target.y = tcsHeight * y + targetCoordinateSpace.y;
                target.width = tcsWidth * w;
                target.height = tcsHeight * h;
            }
		}
	
	}

}