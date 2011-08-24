package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class AdjacentHorizontalLeftAlignMethod extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsCenterX:Number = targetCoordinateSpace.left + targetCoordinateSpace.width / 2;
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].x = tcsCenterX - targets[i].width;
		}
		
	}

}