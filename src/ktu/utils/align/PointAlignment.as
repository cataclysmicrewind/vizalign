

package ktu.utils.align {
	
	import flash.geom.Point;
	
	/**
	 * encapsulates the rectangle aspect of the core aligning code and replaces it with a point
	 * @author ktu
	 */
	public class PointAlignment {
		
		
		public var pointAligner	:IPointAligner;
		public var tcs:Point;
		
		
		
		public function PointAlignment(pointAligner:IPointAligner, targetCoordinateSpace:Point){
			this.pointAligner = pointAligner;
			this.tcs = targetCoordinateSpace;
		}
		
		
		public function align (targetBounds:Array/*Point*/):void {
			pointAligner.alignPoints(tcs, targetBounds);
		}
		
		
		/** @private **/
		public function toString ():String {
			var str:String = "{type: " + pointAligner;
			str += ", tcs:" + tcs + "}";
			return str;
		}
	}
}