/*

				DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
						Version 2, December 2004
	
	Copyright (C) 2012 ktu <ktu@cataclysmicrewind.com>
	
	Everyone is permitted to copy and distribute verbatim or modified
	copies of this license document, and changing it is allowed as long
	as the name is changed.
	
				DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
	   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
		
		0. You just DO WHAT THE FUCK YOU WANT TO.


	This program is free software. It comes without any warranty, to
	the extent permitted by applicable law. You can redistribute it
	and/or modify it under the terms of the Do What The Fuck You Want
	To Public License, Version 2, as published by Sam Hocevar. See
	http://sam.zoy.org/wtfpl/COPYING for more details.

*/
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