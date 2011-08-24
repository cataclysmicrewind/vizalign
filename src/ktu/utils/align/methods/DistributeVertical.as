package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeVertical extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets = targets.sort ( sortGlobalCenterY ) ;
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top + ( targets[0].height / 2 ) ;
			var spread:Number = ( (  targetCoordinateSpace.bottom - ( targets[length - 1].height / 2 ) - first ) / ( length - 1 ) ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first - ( targets[i].height / 2 ) + ( spread * i ) ;
			
			reorderArray(targets, origOrderedDic);
		}
		
	}

}