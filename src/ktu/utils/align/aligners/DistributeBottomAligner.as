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
package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_bottom;
	
	/**
	 * DistributeBottomAligner places an even space between the bottom edge of the targets inside the target coordinate space object.
	 * @author ktu
	 */
	public class DistributeBottomAligner implements IRectangleAligner {
		
		/**
		 * places an even space between the bottom edge of the targets inside the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																//	copy targets into new array so i do not ruin ordering
			targets.sort ( sort_rectangle_bottom ) ;												//	sort targets on bottom edge
			
			var length:int = targets.length;														// 	targets length for optimized looping
			var first:Number = targetCoordinateSpace.top + targets[0].height;						//	bottom of first target inside the tcs
			var spread:Number = ( ( targetCoordinateSpace.bottom - first ) / ( length - 1 ) ) ;		//	the gap between each target
			for ( var i:int = 0; i < length; i++ ) 													//	loop (each target)
				targets[i].y = first - targets[i].height + ( spread * i ) ;							//		place target bottom at first bottom and add spread
		}
	}
}