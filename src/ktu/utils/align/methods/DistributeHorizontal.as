package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeHorizontal extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets = targets.sort ( sortGlobalCenterX ) ;
			
			var first:Number = targetCoordinateSpace.left + (targets[0].width / 2);
			var last:Number = targetCoordinateSpace.right - (targets[targets.length - 1].width / 2) ;
			var spread:Number = ((last - first) / targets.length - 1) ;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = first - ( targets[i].width / 2 ) + ( spread * i ) ;
			
			reorderArray(targets, origOrderedDic);
		}
		
	}

}