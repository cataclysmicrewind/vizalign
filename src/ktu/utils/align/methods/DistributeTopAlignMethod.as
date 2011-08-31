package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.sorting.sort_rectangle_top;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeTopAlignMethod implements IAlignMethod {
		
		public function alignTargetsToTCS(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			//var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets = targets.concat();
			targets = targets.sort ( sort_rectangle_top ) ;
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top;
			var spread:Number = ( targetCoordinateSpace.bottom - targets[length - 1].height - first ) / ( length - 1 ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first + ( spread * i ) ;
			
			//reorderArray(targets, origOrderedDic);
		}
		
	}

}