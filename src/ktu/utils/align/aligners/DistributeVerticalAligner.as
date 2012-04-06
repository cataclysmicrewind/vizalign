/* MIT License

Copyright (c) 2012 ktu <ktu@cataclysmicrewind.com>

Permission is hereby granted, free of charge, to any person obtaining a 
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
THEAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN THE SOFTWARE.

*/
package ktu.utils.align.aligners {

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.align.IRectangleAligner;
	import ktu.utils.sorting.sort_rectangle_centerY;
	
	/**
	 * DistributeVerticalAligner places an even space between the y center of the targets inside the target coordinate space object.
	 * @author ktu
	 */
	public class DistributeVerticalAligner extends SortableAligner implements IRectangleAligner {
		
        public function DistributeVerticalAligner(sortTargets:Boolean = false) {
            super(sortTargets);
        }
		/**
		 * places an even space between the y center of the targets inside the target coordinate space object.
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();
			if (sortTargets) targets = targets.sort ( sort_rectangle_centerY );
			
			var length:int = targets.length;														// targets length for optimized looping
			var first:Number = targetCoordinateSpace.top + ( targets[0].height / 2 ) ;
			var last:Number = targetCoordinateSpace.bottom - ( targets[length - 1].height / 2);
			var spread:Number = ( last - first ) / ( length - 1 ) ;
			for ( var i:int = 0; i < length; i++ ) 
				targets[i].y = first - ( targets[i].height / 2 ) + ( spread * i ) ;
			
		}
	}
}