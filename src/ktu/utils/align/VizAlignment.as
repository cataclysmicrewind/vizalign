

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
	 * 		var alignment:VizAlignment = new VizAlignment(new LeftAligner(), stage);
	 * 		VizAlign.align([mc1, mc2], [alignment], true, true, true);
	 * 																																							</listing>
	 */
	public class VizAlignment {
		/**
		 *  place holder when aligning targets to the bounding area they create
		 */
		static public const TO_TARGETS	:Object	= { };
		
		
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
		public var tcs	:*;
		/**
		 *  ignores the origin of the tcs (if any)	
		 *  
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
		 * @param	type 	IRectangleAligner	any object that inmplements that interface (an object that can align rectangles) 
		 * @param	tcs		* 	must be a DisplayObject, Stage, or Rectangle. 
		 */
		public function VizAlignment (rectangleAligner:IRectangleAligner, targetCoordinateSpace:*, ignoreTCSOrigin:Boolean = true):void {
			switch (true) {
				case tcs is DisplayObject:
				case tcs is Stage:
				case tcs is Rectangle:
					break;
				default:
					throw new Error (BAD_TCS);
			}
			this.rectangleAligner = rectangleAligner;
			this.tcs = targetCoordinateSpace;
			this.ignoreTCSOrigin = ignoreTCSOrigin
		}
		
		/**
		 * 	This function will align the targets based off the specifications of this VizAlignment
		 *  
		 * 	A VizAlignment is capable of acting on its own, and aligning targets through this function
		 * 	What this won't do is any origin ignoring, repositioning, or maintaining original dimensions
		 *  (that is what VizAlign is for)
		 * 
		 * @param	targets
		 * @return
		 */
		public function align (targetBounds:Array/*Rectangle*/):void {
			rectangleAligner.alignRectangles(getTCSBounds(tcs, ignoreTCSOrigin, targetBounds), targetBounds);				//	align them and return the new bounds for the targets
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
			str += ", tcs:" + tcs.name + "}";
			return str;
		}
	}
}