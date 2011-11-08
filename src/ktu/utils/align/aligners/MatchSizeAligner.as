

package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * MatchSizeAligner makes all targets have the same width and height as the target coordinate space
	 * @author ktu
	 */
	public class MatchSizeAligner implements IRectangleAligner {
		
		/**
		 * makes all targets have the same width and height as the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var endW:Number = targetCoordinateSpace.width;											
			var endH:Number = targetCoordinateSpace.height;
			var length:int = targets.length;
			for ( var i:int = 0; i < length; i++ ) {
				targets[i].width = endW;
				targets[i].height = endH;
			}
		}
	}
}