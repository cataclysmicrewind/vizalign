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
	 * MatchSizeAligner makes all targets have the same width and height as the target coordinate space
	 * @author ktu
	 */
	public class MatchSizeAligner implements IRectangleAligner {
		
		/**
		 * makes all targets have the same width and height as the target coordinate space
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var endW:Number = targetCoordinateSpace.width;											
			var endH:Number = targetCoordinateSpace.height;
			var length:int = targets.length;
			for ( var i:int = 0; i < length; i++ ) {
				targets[i].width = endW;
				targets[i].height = endH;
			}
		}
	}
}