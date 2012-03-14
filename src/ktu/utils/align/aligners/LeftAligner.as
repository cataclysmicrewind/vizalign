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
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ktu.utils.align.IPointAligner;
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * LeftAligner aligns each target so the left edge matches the left edge of the target coordinate space
	 * @author ktu
	 */
	public class LeftAligner implements IRectangleAligner, IPointAligner {
		
		/**
		 * aligns each target so the left edge matches the left edge of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsLeftEdge:Number = targetCoordinateSpace.left;				// get left edge of target coordinate space object
			var length:int = targets.length;									// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) 								// loop through all targets
				targets[i].x = tcsLeftEdge;										// 		grab current target and set its x value
		}
		
		/**
		 * aligns Point to the left of the targetCoordinateSpace.
		 * 
		 * this function simply uses the alignRectanges. that function is genericly typed and since the only properties
		 * it cares about in the targets is an x, there is no problem because both Point and Rectangle have x properties
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignPoints(targetCoordinateSpace:Point, targets:Array/*Rectangle*/):void {
			alignRectangles(new Rectangle(targetCoordinateSpace.x, targetCoordinateSpace.y, 0, 0), targets);
		}
	}
}