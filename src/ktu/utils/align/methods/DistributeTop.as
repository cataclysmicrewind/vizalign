package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeTop extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets = targets.sort ( sortGlobalY ) ;
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top;
			var spread:Number = ( targetCoordinateSpace.bottom - targets[length - 1].height - first ) / ( length - 1 ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first + ( spread * i ) ;
			
			reorderArray(targets, origOrderedDic);
		}
		
	}

}