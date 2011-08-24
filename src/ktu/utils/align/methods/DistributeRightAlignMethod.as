package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.sorting.sort_rectangle_right;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeRightAlignMethod extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets.sort ( sort_rectangle_right ) ;
			
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var first:Number = tcsLeftEdge + targets[0].width;
			var spread:Number = ( ( targetCoordinateSpace.right - first ) / ( targets.length - 1 ) ) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = first - targets[i].width + ( spread * i ) ;
			
			reorderArray(targets, origOrderedDic);
		}
		
	}

}