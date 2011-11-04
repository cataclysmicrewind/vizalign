package ktu.utils.align {
	import flash.geom.Rectangle;
	
	/**
	 * 	this interface specifies a function that is used to align rectangles.
	 * 	
	 * 
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