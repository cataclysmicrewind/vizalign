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
	import ktu.utils.sorting.sort_rectangle_left;
	
	/**
	 * SpaceHorizontalAligner evenly spaces the targets along the x axis inside of the target coordinate space
	 * @author ktu
	 */
	public class SpaceHorizontalAligner implements IRectangleAligner {
		
		/**
		 * evenly spaces the targets along the x axis inside of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																// 	copy targets into new array so i do not ruin ordering
			targets = targets.sort ( sort_rectangle_left ) ;										//	sort targets on left edge
			
			var objsWidth:Number = 0;																//	total width of all targets
			var totalWidth:Number = targetCoordinateSpace.width;									//	total width of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )	 												//	loop (each target)
				objsWidth += targets[i].width ;														//		add width of target to total targets width
			
			var spread:Number = ( totalWidth - objsWidth ) / ( length - 1 ) ;						//	the gap between each target
			var right:Number = targetCoordinateSpace.left + targets[0].width;						//	current right edge of the last placed target
			targets[0].x = targetCoordinateSpace.left;												//	place first target
			for ( var j:int = 1; j < length; j++ ) {												//	loop (each target - first)
				var item:Rectangle = targets[j];													//		grab current item
				item.x = right + spread;															//		place item at right edge plus spread
				right += item.width + spread;														//		update right edge to include current item
			}																						//	end loop
		}
	}
}