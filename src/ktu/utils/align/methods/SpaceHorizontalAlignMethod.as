package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.sorting.sort_rectangle_left;
	/**
	 * ...
	 * @author ...
	 */
	public class SpaceHorizontalAlignMethod extends SortedAlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets = targets.sort ( sort_rectangle_left ) ;
			
			var objsWidth:Number = 0;
			var totalWidth:Number = targetCoordinateSpace.width;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				objsWidth += targets[i].width ;
			
			var spread:Number = ( totalWidth - objsWidth ) / ( length - 1 ) ;
			var right:Number = targetCoordinateSpace.left + targets[0].width;
			targets[0].x = targetCoordinateSpace.left;
			for ( var j:int = 1; j < length; j++ ) {
				targets[j].x = right + spread;
				right += targets[j].width + spread;
			}
			reorderArray(targets, origOrderedDic);
		}
		
	}

}