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
	import ktu.utils.sorting.sort_rectangle_top;
	
	/**
	 * SpaceHorizontalAligner evenly spaces the targets along the x axis inside of the target coordinate space
	 * @author ktu
	 */
	public class SpaceInsideVerticalAligner implements IRectangleAligner {
		
		/**
		 * evenly spaces the targets along the x axis inside of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																// 	copy targets into new array so i do not ruin ordering
			targets = targets.sort ( sort_rectangle_top ) ;											//	sort targets on top edge
			
			var objsHeight:Number = 0;																//	total height of all targets
			var totalHeight:Number = targetCoordinateSpace.height;									//	total height of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )	 												//	loop (each target)
				objsHeight += targets[i].height ;													//		add height of target to total targets height
			
			var spread:Number = ( totalHeight - objsHeight ) / ( length + 1 ) ;						//	the gap between each target
			var bottom:Number = targetCoordinateSpace.top											//	current right edge of the last placed target
			for ( var j:int = 0; j < length; j++ ) {												//	loop (each target - first)
				var target:Rectangle = targets[j];													//		grab current item
				target.y = bottom + spread;															//		place item at right edge plus spread
				bottom += target.height + spread;														//		update right edge to include current item
			}																						//	end loop
		}
	}
}