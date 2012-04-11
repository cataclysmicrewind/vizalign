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
package ktu.utils.align {
	
    import flash.geom.Rectangle;
    import ktu.utils.align.IRectangleAligner;
    import ktu.utils.align.targets.VizAlignTarget;

	/**
	 * 
	 * The VizAlignment class represents how you would like to align targets.																					<br/>
	 * 																																							<br/>
	 * Each alignment needs two (2) things:																														<br/>
	 *  how you wish to align the targets. 																														<br/>
	 *  what object do you want to align the targets to.																										<br/>
	 * 																																							<br/>
	 * Given this sentence 'I want to align myMovieClip to the left of the stage':
	 * 	- 'myMovieClip' represents the targets,
	 * 	- 'to the left' represents the type,
	 *  - 'of the stage' represents the targetCoordinateSpace (tcs).																							<br/>
	 * 																																							<br/>
	 * I use the term targetCoordinateSpace because of the doucmentation relating to DisplayObject.getBounds(). 
	 * This particular method describes its argument as a 'targetCoordinateSpace' and I have determined that
	 * the same concept applies to alignment. The only major difference being that VizAlignments really only
	 * use a portion of a targetCoordinateSpace. 
	 * 
	 * @example 																																				<listing version="3">
	 * 		var alignment:VizAlignment = new VizAlignment(new LeftAligner(), stage);
	 * 		VizAlign.align([mc1, mc2], [alignment], true, true, true);
	 * 																																							</listing>
	 */
	public class VizAlignment {
		/**
		 *  place holder when aligning targets to the bounding area they create
		 * 
		 *  using this as your tcs is akin to using the align panel in the flash ide without selecting the 'to stage' button
		 */
		static public const TO_TARGETS	:Rectangle	= new Rectangle(-1, -1, -1, -1);
		
		
		/**
		 * the object that will perform that actual alignment. this object conforms to the IRectangleAlinger interface which specifies
		 * the alignRectangles function. 
		 */
		public var rectangleAligner	:IRectangleAligner;
		/**
		 * the object that defines a rectangle for the targets to align to,
		 * this is any DisplayObject/Stage/Rectangle. In Flash IDE terminoligy it is the same as saying 
		 * align to the left of the [stage]. The tcs is [].
		 * 
		 * important to note, that as this is typed as a wildcard (*), it can only be one of three possibilities:
		 * 		DisplayObject, Stage, Rectangle
		 */
		public var targetCoordinateSpace:VizAlignTarget;
		/**
		 *  The constructor needs to have both the rectangleAligner and targetCoordinateSpace passed in,
		 *  this makes sure that no VizAlignment objects will be unsuitable for any VizAlign.align() call
		 * @param	rectangleAligner 	any object that inmplements that interface (an object that can align rectangles) 
		 * @param	targetCoordinateSpace		must be a DisplayObject, Stage, or Rectangle. 
		 * @param	ignoreTCSOrigin		ignore the origin of the targetCoordinateSpace
		 */
		public function VizAlignment (rectangleAligner:IRectangleAligner = null, targetCoordinateSpace:* = null):void {
			this.rectangleAligner = rectangleAligner;
			this.targetCoordinateSpace = VizAlign.convertToVizAlignTarget(targetCoordinateSpace);
		}
		
		/**
		 * 	This function will align the targets based off the specifications of this VizAlignment
		 *  
		 * 	A VizAlignment is capable of acting on its own, and aligning targets through this function
		 * 	What this won't do is any origin ignoring, repositioning, or maintaining original dimensions
		 *  (that is what VizAlign is for)
		 * 
		 * @param	targetBounds the array of target Rectangle you want to align 
		 * @return
		 */
		public function align (targetBounds:Array/*Rectangle*/):void {
            var tcsBounds:Rectangle;
            if (targetCoordinateSpace.target === TO_TARGETS) {
                if (!targetBounds || targetBounds.length == 0) {
                    tcsBounds = new Rectangle();
                } else {
                    tcsBounds = targetBounds[0].clone();
                    for (var i:int = 1; i < targetBounds.length; i++)
                        tcsBounds.union(targetBounds[i]);
                }
            } else {
                tcsBounds = targetCoordinateSpace.end;
            }
            rectangleAligner.alignRectangles(tcsBounds, targetBounds);
		}
		/** @private **/
		public function toString ():String {
			var str:String = "{type: " + rectangleAligner;
			str += ", tcs:" + targetCoordinateSpace + "}";
			return str;
		}
	}
}