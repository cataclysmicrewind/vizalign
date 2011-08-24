package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class SpaceVertical extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets = targets.sort ( sortGlobalY ) ;
			
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