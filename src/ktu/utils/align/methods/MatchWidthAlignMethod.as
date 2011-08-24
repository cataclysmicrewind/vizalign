package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class MatchWidthAlignMethod extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var endW:Number = targetCoordinateSpace.width;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].width = endW;
		}
		
	}

}