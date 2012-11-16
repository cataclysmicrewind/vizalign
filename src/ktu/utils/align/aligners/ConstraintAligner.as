package ktu.utils.align.aligners {
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	
	/**
	 * ConstriantAligner allows you to specify a rectangle that the targets must stay within.
     * 
     * if outer = true, then it will make sure the target lies outisde of the tcs
     * if outer = false, then it will make sure the target lies inside of the tcs
     * 
     * if ignoreSize = true, then it will only make sure the x and y are within it
     * if ignoreSize = false, then it will make sure the entire target is within it
     * 
     * primaryAxis lets you choose the order in which this aligner checks the axis for making sure the 
     * targets are following the options of this aligner.
     * 
     * if you choose AXIS_X, it will first check the x axis to see if the target passes. if not it moves it
     * if then the y axis is ok, we do nothing and move on to the next target.
     * if the y axis does not pass, then we move it on this axis as well.
     * 
     * if you choose AXIS_Y it will first check the y axis to see if the target passes. if not it moves it
     * if then the x axis passes, we do nothing and move on to the next target
     * if the x axis does not pass, then we move it on this axis as well.
     * 
     * if you choose AXIS_XY it will always check both axis. x axis first, then y axis
     * 
     * if you choose AXIS_YX it will always check both axis. y axis first, then x axis
     * 
	 * @author ktu
	 */
	public class ConstraintAligner implements IRectangleAligner {
		
        public static const AXIS_X:String = "x";
        public static const AXIS_Y:String = "y";
        public static const AXIS_XY:String = "xy";
        public static const AXIS_YX:String = "yx";
        
        public var outer:Boolean;
        public var excludeSize:Boolean;
        public var primaryAxis:Boolean;
        
        /**
         * 
         * @param	includeSize include the size of the target in determining if it fits
         */
		public function ConstraintAligner(outer:Boolean = false, excludeSize:Boolean = false, primaryAxis:String = AXIS_X) {
            this.outer = outer;
            this.excludeSize = excludeSize;
            this.primaryAxis = primaryAxis;
		}
		
		/* INTERFACE ktu.utils.align.IRectangleAligner */
		
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array /*Rectangle*/):void {
            var tcsX:Number = targetCoordinateSpace.x;
            var tcsY:Number = targetCoordinateSpace.y;
            var tcsW:Number = targetCoordinateSpace.width;
            var tcsH:Number = targetCoordinateSpace.height;
            var tcsR:Number = tcsX + tcsW;
            var tcsB:Number = tcsY + tcsH;
			var length:int = targets.length;
			for ( var i:int = 0; i < length; i++ ) {
                var target:Rectangle = targets[i];
                
                var useBounds:Rectangle = target.clone();
                if (excludeSize) useBounds.width = useBounds.y = 0;
                
                // figure out which axis to check first
                // these functions will move the target on the apprpriate axis
                var axis:Array = [];
                switch(primaryAxis) {
                    case AXIS_X :
                        axis[0] = checkXAxis;
                           break;
                    case AXIS_Y :
                        axis[0] = checkYAxis;
                        break;
                    case AXIS_XY:
                        axis[0] = checkXAxis;
                        axis[1] = checkYAxis;
                        break;
                    case AXIS_YX :
                        axis[0] = checkYAxis;
                        axis[1] = checkXAxis;
                        break;
                }
                
                var pass:Boolean = excludeSize ? 
                    targetCoordinateSpace.contains(target.x, target.y) : 
                    (outer ? 
                        targetCoordinateSpace.intersection(target).equals(new Rectangle) :
                        targetCoordinateSpace.containsRect(target)
                    )
                
                if (!pass) {
                    for (var i:int = 0; i < axis.length; i++) {
                        axis[i](outer, excludeSize, targetCoordinateSpace, target);
                    }
                }
                
                
                //passTarget (outer, excludeSize, tcsB, useBounds);// outer ? passInner(tcs, useBounds) : passOuter(tcs, useBounds);
                
                if (outer) {
                    if (!excludeSize) {
                        // we need the whole thing to not intersect
                        var intersection:Rectangle = targetCoordinateSpace.intersection(target);
                        if (intersection.equals(new Rectangle)) {
                            // we good
                        } else {
                            // we move him outside
                            var tCX:Number = target.x + target.width / 2;
                            var tCY:Number = target.y + target.height / 2;
                            if (tCX < tcsX + tcsW / 2) target.x = tcsX - target.width - 1;
                            else target.x = tcsR + 1;
                            if (tCY < tcsY + tcsH / 2) target.y = tcsY - target.height - 1;
                            else target.y = tcsB + 1;
                        }
                    } else {
                        // we need just the x,y outside
                        if (targetCoordinateSpace.contains(target.x, target.y)) {
                            // push it out
                            if (target.x < tcsX + tcsW / 2) target.x = tcsX - 1;
                            else target.x = tcsR + 1;
                            if (target.y < tcsY + tcsH / 2) target.y = tcsY -1;
                            else target.y = tcsB + 1;
                        } else {
                            // we good
                        }
                    }
                } else {
                    // inner
                    if (!excludeSize) {
                        // we need target completely in tcs
                        if (targetCoordinateSpace.containsRect(target)) {
                            // we good
                        } else {
                            // we move him inside
                            if (target.x < tcsX) target.x = tcsX;
                            if (target.y < tcsY) target.y = targetCoordinateSpace.y;
                            if (target.right > tcsW) target.x = tcsW - target.width;
                            if (target.bottom > tcsH) target.y = tcsH - target.height;
                        }
                    } else {
                        // only x,y must be in it
                        if (targetCoordinateSpace.contains(target.x, target.y)) {
                            // we good
                        } else {
                            // move him inside 
                            if (target.x < tcsX) target.x = tcsX;
                            if (target.x > tcsR) target.x = tcsR;
                            if (target.y < tcsY) target.y = tcsY;
                            if (target.y > tcsB) target.y = tcsB;
                        }
                    }
                }
            }
		}
        private function checkXAxis (outer:Boolean, excludeSize:Boolean, tcs:Rectangle, target:Rectangle):void {
            if (outer) {
                if (excludeSize) {
                    if (target.x < tcs.x + tcs.width / 2) target.x = tcs.x - 1;
                    else target.x = tcs.right + 1;
                } else {
                    if ((target.x + target.width / 2) < tcs.x + tcs.width / 2) target.x = tcs.x - target.width - 1;
                    else target.x = tcs.right + 1;
                }
            } else {
                if (excludeSize) {
                    
                } else {
                    
                }
            }
            
        }
        
        private function passTarget(outer:Boolean, excludeSize:Boolean, tcs:Rectangle, target:Rectangle):Boolean {
            if (excludeSize) {
                return tcs.contains(target.x, target.y);
            } else {
                if (outer) {
                    return tcs.intersection(target).equals(new Rectangle);
                } else {
                    return targetCoordinateSpace.containsRect(target)
                }
            }
            
        }
        
	}
}