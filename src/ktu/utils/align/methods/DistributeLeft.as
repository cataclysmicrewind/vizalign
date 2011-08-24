package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class DistributeLeft extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var origOrderedDic:Dictionary = preserveOrderWithDictionary(targets);
			targets = targets.sort ( sortGlobalX ) ;
			
			var tcsLeftEdge:Number = targetCoordinateSpace.left;
			var spread:Number = (targetCoordinateSpace.width - targets[targets.length - 1].width) / (targets.length - 1);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].x = tcsLeftEdge + (spread * i) ;
				
			reorderArray(targets, origOrderedDic);
		}
		
	}

}