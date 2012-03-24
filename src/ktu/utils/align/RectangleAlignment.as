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
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;

	/**
	 * 
	 * The VizAlignment class represents how you would like to align targets.																					<br/>
	 * 																																							<br/>
	 * Each alignment needs two (2) things:																														<br/>
	 *  how you wish to align the targets. 																														<br/>
	 *  what object do you want to align the targets to.																										<br/>
	 * 																																							<br/>
	 * Given this sentance 'I want to align myMovieClip to the left of the stage':
	 * 	- 'myMovieClip' represents the targets,
	 * 	- 'to the left' represents the type, and 
	 *  - 'of the stage' represents the targetCoordinateSpace (tcs).															<br/>
	 * 																																							<br/>
	 * I use the term targetCoordinateSpace because of the doucmentation relating to DisplayObject.getBounds(). 
	 * This particualr method describes its argument as a 'targetCoordinateSpace' and I have determined that
	 * the same concept applies to alignment. The only major difference being that VizAlignments really only
	 * use a portion of a targetCoordinateSpace. 
	 * 
	 * @example 																																				<listing version="3">
	 * 		var alignment:RectangleAlignment = new RectangleAlignment(new LeftAligner(), stage);
	 * 		alignment.align([mc1, mc2]);
	 * 																																							</listing>
	 */
	public class RectangleAlignment {
		
		/**
		 *  place holder when aligning targets to the bounding area they create
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
		 */
		public var tcs :Rectangle;
		
		
		
		
		
		/**
		 *  The constructor needs to have both the rectangleAligner and targetCoordinateSpace passed in,
		 *  this makes sure that no VizAlignment objects will be unsuitable for any VizAlign.align() call
		 * 
		 * @param	type 	IRectangleAligner	any object that inmplements that interface (an object that can align rectangles) 
		 * @param	tcs		* 	must be a DisplayObject, Stage, or Rectangle. 
		 */
		public function RectangleAlignment (rectangleAligner:IRectangleAligner, targetCoordinateSpace:Rectangle):void {
			this.rectangleAligner = rectangleAligner;
			this.tcs = targetCoordinateSpace;
		}
		
		/**
		 * 	This function will align the targets based off the specifications of this VizAlignment
		 * 
		 *  
		 * 	A VizAlignment is capable of acting on its own, and aligning targets through this function
		 * 	What this won't do is any origin ignoring, repositioning, or maintaining original dimensions
		 *  (that is what VizAlign is for)
		 * 
		 * @param	targets
		 * @return
		 */
		public function align (targetBounds:Array/*Rectangle*/):void {
			rectangleAligner.alignRectangles(getTCSBounds(tcs, targetBounds), targetBounds);				//	align them and return the new bounds for the targets
		}
		
		
		
		
		
		
		
		
		/** @private */
		static private const NO_TARGETS	:String = "RectangleAlignment : attempting to get TO_TARGETS bounds but did not receive any targetBounds";
		
		/**
		 * 	returns a rectangle consisting of the boundaries of the targetCoordinateSpace.
		 * 
		 * This accepts a Stage, DisplayObject, TO_TARGETS, or Rectangle object. 
		 * Only these objects produce a rectangular boundary.
		 * 
		 * @param	targetCoordinateSpace	the object to extract the bounds from
		 * @param	ignoreTCSOrigin			can only ignore the origin on a DisplayObject
		 * @param	targetBounds			array of Rectangle for when using the TO_TARGETS
		 * @return
		 */
		static public function getTCSBounds(targetCoordinateSpace:Rectangle, targetBounds:Array/*Rectangle*/= null):Rectangle {
			var tcsBounds:Rectangle;																						// 	the rectangle
			if (targetCoordinateSpace === TO_TARGETS) {																		// 	if (tcs is TO_TARGETS)
				if (!targetBounds || targetBounds.length == 0) throw new Error (NO_TARGETS);								// 		if (no targets) ERROR
					tcsBounds = targetBounds[0].clone();																	//			tcsBounds = first target bounds
					for (var i:int = 1; i < targetBounds.length; i++)														//			loop (through rest of targets)
						tcsBounds.union(targetBounds[i]);																	//				combine tcsBounds with next target
			} else {																										//	else
				tcsBounds = targetCoordinateSpace;																			//		tcsBounds = tcs
			}																												//	end if
			return tcsBounds;																								//	return tcsBounds
		}
		
		/** @private **/
		public function toString ():String {
			var str:String = "{type: " + rectangleAligner;
			str += ", tcs:" + tcs + "}";
			return str;
		}
	}
}