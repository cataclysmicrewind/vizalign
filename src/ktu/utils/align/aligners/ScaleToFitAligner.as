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
	 * ScaleToFitAligner makes all the targets match the size of the target coordinate space object while maintaining the original width/height ratio.
	 * @author ktu
	 */
	public class ScaleToFitAligner implements IRectangleAligner {
		
		/**
		 * makes all the targets match the size of the target coordinate space object while maintaining the original width/height ratio.
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			var tcsWidth:Number = targetCoordinateSpace.width;										//	grab width of tcs
			var tcsHeight:Number = targetCoordinateSpace.height;									//	grab height of tcs
			var tcsRatio:Number = tcsWidth / tcsHeight ;											//	grab aspect ratio of tcs
			var length:int = targets.length;														// 	targets length for optimized looping
			for ( var i:int = 0; i < length; i++ ) {												//	loop (each target)
				var item:Rectangle = targets[i];													//		grab item
				var itemWHRatio:Number = item.width / item.height;									//		grab item w/h ratio
				var itemHWRatio:Number = item.height / item.width;									//		grab item h/w ratio
				if ( itemWHRatio > tcsRatio ) {														//		if (item w/h > tcs ratio)
					item.width = tcsWidth ;															//			item width = tcs width
					item.height = tcsWidth / itemWHRatio;											//			item height = tcs width / item wh ratio
				} else if ( itemWHRatio < tcsRatio ) {												//		else (item w/h < tcs ratio)
					item.height = tcsHeight;														//			item height = tcs height
					item.width = tcsHeight / itemHWRatio;											//			item width = tcs height / item h/w ratio
				} else {																			//		else (same ratio)
					item.width = tcsWidth;															//			item width = tcs width
					item.height = tcsHeight;														//			item height = tcs height
				}																					//		end if
			}																						//	end loop
		}
	}
}