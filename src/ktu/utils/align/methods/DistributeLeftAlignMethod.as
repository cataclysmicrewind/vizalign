package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.sorting.sort_rectangle_left;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeLeftAlignMethod implements IAlignMethod {
		
		public function alignTargetsToTCS(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			//var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets = targets.concat();
			targets = targets.sort ( sort_rectangle_left ) ;
			
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var spread:Number = (targetCoordinateSpace.width - targets[targets.length - 1].width) / (targets.length - 1);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].x = tcsLeftEdge + (spread * i) ;
				
			//reorderArray(targets, origOrderedDic);
		}
		
	}

}