package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.sorting.sort_rectangle_top;
	/**
	 * ...
	 * @author ...
	 */
	public class SpaceVerticalAlignMethod extends SortedAlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets = targets.sort ( sort_rectangle_top ) ;
			
			var objsHeight:Number = 0;
			var totalHeight:Number = targetCoordinateSpace.height;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				objsHeight += targets[i].height;
			
			var spread:Number = ( totalHeight - objsHeight ) / ( length - 1 ) ;
			var bottom:Number = targetCoordinateSpace.top + targets[0].height;
			targets[0].y = targetCoordinateSpace.top;
			for ( var j:int = 1; j < length; j++ ) {
				targets[j].y = bottom + spread ;
				bottom += targets[j].height + spread ;
			}
			reorderArray(targets, origOrderedDic);
		}
		
	}

}