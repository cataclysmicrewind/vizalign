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
	 * ScaleToFillAligner makes all the targets fill the entire size of the target coordinate space object while maintaining the original width/height ratio.
	 * @author ktu
	 */
	public class ScaleToFillAligner implements IRectangleAligner {
		
		/**
		 * makes all the targets fill the entire size of the target coordinate space object while maintaining the original width/height ratio.
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsWidth:Number = targetCoordinateSpace.width;										//	grab width of tcs
			var tcsHeight:Number = targetCoordinateSpace.height;									//	grab height of tcs
			var tcsRatio:Number = tcsWidth / tcsHeight ;											// 	grab the aspect ratio of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												//	loop (each target)
				var item:Rectangle = targets[i];													//		store ref to target
				var itemWHRatio:Number = item.width / item.height;									//		grab item w/h ratio
				var itemHWRatio:Number = item.height / item.width;									//		grab item h/w ratio
				if ( itemWHRatio > tcsRatio ) {														//		if (w/h ratio is greater)
					item.height = tcsHeight;														//			height of item is same as tcs height
					item.width = tcsHeight / itemHWRatio;											//			width of item is tcs height / h/w ratio)
				} else if ( itemWHRatio < tcsRatio ) {												//		if (w/h ratio is smaller)
					item.width = tcsWidth ;															//			width of item is same as tcs width
					item.height = tcsWidth / itemWHRatio;											//			height of item is tcs width / w/h ratio
				} else {																			//		else (same ratio)
					item.width = tcsWidth;															//			item width is tcs width
					item.height = tcsHeight;														//			item height is tcs height
				}																					//		end if
			}																						//	end loop
		}
	}
}