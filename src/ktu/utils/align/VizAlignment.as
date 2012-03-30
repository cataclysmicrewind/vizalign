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
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	import ktu.utils.align.IRectangleAligner;

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
	 * 
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
<<<<<<< HEAD
		public var targetCoordinateSpace:*;
		/**
		 *  ignores the origin of the tcs (if any)
		 *
=======
		private var _targetCoordinateSpace:*;
		public function get targetCoordinateSpace():*  { return _targetCoordinateSpace; }
		/** @private */
		public function set targetCoordinateSpace(value:*):void {
			switch (true) {
				case targetCoordinateSpace is Stage:
				case targetCoordinateSpace is DisplayObject:
				case targetCoordinateSpace is Rectangle:
				case targetCoordinateSpace == null:
					break;
				default:
					throw new Error (BAD_TCS);
			}
			_targetCoordinateSpace = value;
		}
		/**
		 *  ignores the origin of the tcs (if any)	
		 *  
>>>>>>> master
		 * 	Only applies to tcs that are DisplayObject.
		 * 	Does not apply to TO_TARGETS (if the targets are set to ignore origin, then it is ignored)
		 *  Does not apply to Rectangle  (cannot have an origin offset)
		 * 	Does not apply to Stage		 (Stage have no origin offset)
		 * 
		 */
		public var ignoreTCSOrigin:Boolean = true;
		
		/**
		 *  The constructor needs to have both the rectangleAligner and targetCoordinateSpace passed in,
		 *  this makes sure that no VizAlignment objects will be unsuitable for any VizAlign.align() call
		 * @param	rectangleAligner 	any object that inmplements that interface (an object that can align rectangles) 
		 * @param	targetCoordinateSpace		must be a DisplayObject, Stage, or Rectangle. 
		 * @param	ignoreTCSOrigin		ignore the origin of the targetCoordinateSpace
		 */
<<<<<<< HEAD
		public function VizAlignment (rectangleAligner:IRectangleAligner, targetCoordinateSpace:*, ignoreTCSOrigin:Boolean = true):void {
			switch (true) {
				case targetCoordinateSpace is Stage:
				case targetCoordinateSpace is DisplayObject:
				case targetCoordinateSpace is Rectangle:
					break;
				default:
					throw new Error (BAD_TCS);
			}
=======
		public function VizAlignment (rectangleAligner:IRectangleAligner = null, targetCoordinateSpace:* = null, ignoreTCSOrigin:Boolean = true):void {
>>>>>>> master
			this.rectangleAligner = rectangleAligner;
			this.targetCoordinateSpace = targetCoordinateSpace;
			this.ignoreTCSOrigin = ignoreTCSOrigin
		}
		
		/**
		 * 	This function will align the targets based off the specifications of this VizAlignment
		 *  
		 * 	A VizAlignment is capable of acting on its own, and aligning targets through this function
		 * 	What this won't do is any origin ignoring, repositioning, or maintaining original dimensions
		 *  (that is what VizAlign is for)
		 * 
<<<<<<< HEAD
		 * @param	targets
=======
		 * @param	targetBounds the array of target Rectangle you want to align 
>>>>>>> master
		 * @return
		 */
		public function align (targetBounds:Array/*Rectangle*/):void {
			rectangleAligner.alignRectangles(getTCSBounds(targetCoordinateSpace, ignoreTCSOrigin, targetBounds), targetBounds);				//	align them and return the new bounds for the targets
		}
		
		
		
		
		
		
		/** @private */
		static private const BAD_TCS	:String = "VizAlignment : tcs must be a DisplayObject, Stage, Rectangle or VizAlignment.TO_TARGETS";
		/** @private */
		static private const NO_TARGETS	:String = "VizAlignment : attempting to get TO_TARGETS bounds but did not receive any targetBounds";
		/**
		 * 
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
		static public function getTCSBounds(targetCoordinateSpace:*, ignoreTCSOrigin:Boolean = true, targetBounds:Array/*Rectangle*/= null):Rectangle {
			var tcsBounds:Rectangle;																							// 	the rectangle
			switch (true) {																										// 	switch (true) is so useful
				case targetCoordinateSpace is Stage:																			//		case Stage
					var stage:Stage = targetCoordinateSpace as Stage;															//			get reference to tcs as Stage
					if (stage.displayState == StageDisplayState.FULL_SCREEN) 													//			if (in fullscreen mode)
						tcsBounds = new Rectangle (0, 0, stage.fullScreenSourceRect.width, stage.fullScreenSourceRect.height);	//				tcsBounds = the fullscreen bounds
					else 																										//			else
						tcsBounds = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);									//				tcsBounds = stage bounds
					break;																										//			break
				case targetCoordinateSpace is DisplayObject:																	//		case DisplayObject
					tcsBounds = (targetCoordinateSpace as DisplayObject).getBounds(targetCoordinateSpace);						//			tcsBounds = DisplayObject.getBounds itself
					if (ignoreTCSOrigin) {																						//			if (ignore tcs origin)
						var dx:Point = targetCoordinateSpace.localToGlobal(new Point(tcsBounds.x, tcsBounds.y));				//				convert tcs x and y to global 
						tcsBounds.x = dx.x;																						//				set the x
						tcsBounds.y = dx.y;																						//				set the y
					}																											//			end if
					break;																										//			break
				case targetCoordinateSpace === TO_TARGETS:																		//		case TO_TARGETS
					if (!targetBounds) throw new Error (NO_TARGETS);															// 			if (no targets) ERROR
					tcsBounds = targetBounds[0].clone();																		//			tcsBounds = first target bounds
					for (var i:int = 1; i < targetBounds.length; i++)															//			loop (through rest of targets)
						tcsBounds.union(targetBounds[i]);																		//				combine tcsBounds with next target
					break;																										//			break
				case targetCoordinateSpace is Rectangle:																		//		case Rectangle
					tcsBounds = targetCoordinateSpace;																			//			tcsBounds = tcs
					break;																										//			break
				default:																										//		default
					return null;																								//			return nothing (fail)
			}																													//	end switch
			return tcsBounds;																									//	return tcsBounds
		}
		
		
		
		/** @private **/
		public function toString ():String {
			var str:String = "{type: " + rectangleAligner;
			str += ", tcs:" + targetCoordinateSpace.name + "}";
			return str;
		}
	}
}