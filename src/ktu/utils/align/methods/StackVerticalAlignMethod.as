package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.sorting.sort_rectangle_adjacentTop;
	import ktu.utils.sorting.sort_rectangle_adjacentBottom;
	/**
	 * ...
	 * @author ...
	 */
	public class StackVerticalAlignMethod extends SortedAlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			
			var above:Array = new Array ( ) ;
			var below:Array = new Array ( ) ;
			var tcsCenterY:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height / 2);
			for ( var i:int = 0; i < targets.length; i++ ) {
				var target:Rectangle = targets[i];
				var targetCenterY:Number = target.top + (target.height / 2);
				if ( targetCenterY < tcsCenterY )
					above.push (targets[i]) ;
				else
					below.push (targets[i]) ;
			}
			above.sort ( sort_rectangle_adjacentTop ) ;
			below.sort ( sort_rectangle_adjacentBottom ) ;
			above.reverse ( ) ;
			var top:Number = 0;
			var bottom:Number = 0;
			var item:Rectangle;
			var endY:Number;
			for ( var j:int = 0; j < above.length; j++ ) {
				 item = above[j]
				if ( j != 0 ) {
					endY = top - item.height;
					top -= item.height;
				} else {
					endY = targetCoordinateSpace.top - item.height;
					top = targetCoordinateSpace.top - item.height ;
				}
				item.y = endY;
			}
			for ( var k:int = 0; k < below.length; k++ ) {
				item = below[k];
				endY = 0;
				if ( k != 0 ) {
					endY = bottom;
					bottom += item.height;
				} else {
					endY = targetCoordinateSpace.bottom;
					bottom = targetCoordinateSpace.bottom;
				}
				item.y = endY;
			}
			above.reverse ( ) ;
			targets = above;
			targets = targets.concat ( below ) ;
			reorderArray(targets, origOrderedDic);
		}
		
	}

}