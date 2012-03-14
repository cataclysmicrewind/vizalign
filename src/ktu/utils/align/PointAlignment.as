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
	 * encapsulates the rectangle aspect of the core aligning code and replaces it with a point
	 * @author ktu
	 */
	public class PointAlignment {
		
		
		public var pointAligner	:IPointAligner;
		public var tcs:Point;
		
		
		
		public function PointAlignment(pointAligner:IPointAligner, targetCoordinateSpace:Point){
			this.pointAligner = pointAligner;
			this.tcs = targetCoordinateSpace;
		}
		
		
		public function align (targetBounds:Array/*Point*/):void {
			pointAligner.alignPoints(tcs, targetBounds);
		}
		
		
		/** @private **/
		public function toString ():String {
			var str:String = "{type: " + pointAligner;
			str += ", tcs:" + tcs + "}";
			return str;
		}
	}
}