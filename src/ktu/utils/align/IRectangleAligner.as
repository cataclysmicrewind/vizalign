package ktu.utils.align {
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ktu
	 */
	public interface IRectangleAligner {
		
		/**
		 * 
		 * 	This function will align the targets array to the targetCoordinateSpace
		 * 	in which ever way it chooses
		 * 
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void;
		
	}
	
}