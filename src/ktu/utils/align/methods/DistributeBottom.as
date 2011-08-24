package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeBottom extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets.sort ( sortGlobalBottom ) ;
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top + targets[0].height;
			var spread:Number = ( ( targetCoordinateSpace.bottom - first ) / ( length - 1 ) ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first - targets[i].height + ( spread * i ) ;
			
			reorderArray(targets,origOrderedDic);
		}
		
	}

}