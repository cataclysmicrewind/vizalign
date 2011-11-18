package ktu.utils.align {
	import flash.geom.Point;
	
	/**
	 * 	this interface specifies a function that is used to align point.
	 * 	
	 * 
	 *  this class was designed after the core concept was implemented. Thus, most of the aligners that i have created
	 *  were designed for rectangles and adapted to work with points. 
	 * 
	 *  the way i implemented point alignments was simply re using the rectangle code and converting the tcs Point into a Rectangle
	 *  before calling the alignRectangle function. this means that the rectangle alignment functions all deal with the targets in an
	 *  untyped fashion.
	 * 
	 * 	*note* the rectangle alignments that required the knowledge of width and height do not implement IPointAligner
	 * 
	 * @author ktu
	 */
	public interface IPointAligner {
		
		/**
		 * 
		 * 	This function will align the targets array to the targetCoordinateSpace
		 * 	in which ever way it chooses
		 * 
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		function alignPoints(targetCoordinateSpace:Point, targets:Array/*Point*/):void;
		
	}
	
}