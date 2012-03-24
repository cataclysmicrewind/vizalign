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
	 * SpaceVerticalAligner evenly spaces the targets along the y axis inside of the target coordinate space
	 * @author ktu
	 */
	public class SpaceVerticalAligner implements IRectangleAligner {
		
		/**
		 * evenly spaces the targets along the y axis inside of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																//	copy targets into new array so i do not ruin ordering
			targets = targets.sort ( sort_rectangle_top ) ;											//	sort targets by the top edge
			
			var targetTotalHeight:Number = 0;														//	total height of all targets
			var tcsTotalHeight:Number = targetCoordinateSpace.height;								//	total height of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ )													//	loop (each target)
				targetTotalHeight += targets[i].height;												//		add height of target to total
			
			var spread:Number = ( tcsTotalHeight - targetTotalHeight ) / ( length - 1 ) ;			//	the gap between each target
			var bottom:Number = targetCoordinateSpace.top + targets[0].height;						//	current bottom of the last placed target
			targets[0].y = targetCoordinateSpace.top;												//	place the first target
			for ( var j:int = 1; j < length; j++ ) {												//	loop (each target - first)
				var item:Rectangle = targets[j];													//		grab current target
				item.y = bottom + spread ;															//		target y = bottom of the last target plus spread
				bottom += item.height + spread ;													//		update bottom to include current placed target
			}																						//	end loop
		}
	}
}