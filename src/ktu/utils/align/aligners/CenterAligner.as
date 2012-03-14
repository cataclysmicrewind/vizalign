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
	import ktu.utils.align.IRectangleAligner;
	
	/**
	 * CenterAligner aligns each target so the visual x center and y center match the visual x and y center of the target coordinate space
	 * @author ktu
	 */
	public class CenterAligner implements IRectangleAligner {
		
		/**
		 * aligns each target so the visual x center and y center match the visual x and y center of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsCenterX:Number = targetCoordinateSpace.left + (targetCoordinateSpace.width / 2);	// get center x value of target coordinate space object
			var tcsCenterY:Number = targetCoordinateSpace.top + (targetCoordinateSpace.height/ 2);	// get center y value of target coordinate space object
			var length:int = targets.length;														// targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												// loop through all targets
				var target:Rectangle = targets[i];													// 		grab current target as item
				target.x = tcsCenterX - (target.width / 2);											// 		apply x centering math
				target.y = tcsCenterY - (target.height / 2);										//		apply y centering math
			}																						// end loop
		}
	}
}