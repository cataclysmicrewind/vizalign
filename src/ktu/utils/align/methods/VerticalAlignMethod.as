package ktu.utils.align.methods {
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ...
	 */
	public class VerticalAlignMethod extends AlignMethod {
		
		override public function align(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var mid:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height / 2);
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )
				targets[i].y = mid - ( targets[i].height / 2 );
		}
		
	}

}