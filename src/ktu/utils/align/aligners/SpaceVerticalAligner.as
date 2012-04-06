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
	import ktu.utils.sorting.sort_rectangle_top;
	
	/**
	 * SpaceVerticalAligner evenly spaces the targets along the y axis inside of the target coordinate space
	 * @author ktu
	 */
	public class SpaceVerticalAligner extends SortableAligner implements IRectangleAligner {
		
        public function SpaceVerticalAligner(sortTargets:Boolean = false) {
            super(sortTargets);
        }
		/**
		 * evenly spaces the targets along the y axis inside of the target coordinate space
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		public function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void {
			targets = targets.concat();																//	copy targets into new array so i do not ruin ordering
			if (sortTargets) targets = targets.sort ( sort_rectangle_top ) ;											//	sort targets by the top edge
			
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