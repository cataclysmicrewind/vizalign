package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class AdjacentBottomRightAlignMethod implements IAlignMethod {
		
		public function alignTargetsToTCS(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsBottomEdge:Number = targetCoordinateSpace.bottom;
			var tcsRightEdge:Number = targetCoordinateSpace.right;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {
				var item:Rectangle = targets[i];
				item.x = tcsRightEdge;
				item.y = tcsBottomEdge;
			}
		}
		
	}

}