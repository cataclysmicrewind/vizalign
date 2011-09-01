

package ktu.utils.align {
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ktu.utils.align.IRectangleAligner;

	/**
	 * 
	 * VizAlignment holds the neccessary values for each alignment.																								<br/>
	 * 																																							<br/>
	 * Each alignment needs two (2) things:																														<br/>
	 * First, how you wish to align the targets. 																												<br/>
	 * Second, what object do you want to align the targets to.																									<br/>
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
	 * 		var param:VizAlignment = new VizAlignment(new LeftAligner(), stage);
	 * 		VizAlign.align([mc1, mc2], [param], true, true, true);
	 * 																																							</listing>
	 */
	public class RectangleAlignment {
		
		static public const TO_TARGETS	:Object	= { };// place holder when aligning targets to the bounding area they create
		/**
		 * 
		 * Alignment method type to be used in VizAlign.align()
		 * This value should be a const from VizAlign class.
		 */
		public var rectangleAligner	:IRectangleAligner;
		/**
		 * 
		 * the object that defines a rectangle for the targets to align to
		 * This is any DisplayObject. In Flash IDE terminoligy it is the same as saying align to the left of the [stage]. The tcs is [].
		 */
		public var tcs	:*;
		/**
		 *  ignores the origin of the tcs (if any)	
		 *  
		 * 	Only applies to tcs that are DisplayObject.
		 * 	Does not apply to TO_TARGETS (if the targets have ignore origin, then it is ignored)
		 *  Does not apply to Rectangles (they can't have an origin offset)
		 * 	Does not apply to stage		 (the stage has no origin offset)
		 * 
		 * 
		 */
		public var ignoreTCSOrigin:Boolean = true;
		
		/**
		 *  The constructor needs to have both the rectangleAligner and targetCoordinateSpace passed in,
		 *  this makes sure that no VizAlignment objects will be unsuitable for any VizAlign.align() call
		 * @param	type 	IRectangleAligner	any object that inmplements that interface (an object that can align rectangles) 
		 * @param	tcs		* 	must be a DisplayObject, Stage, or Rectangle. 
		 */
		public function RectangleAlignment (rectangleAligner:IRectangleAligner, targetCoordinateSpace:*, ignoreTCSOrigin:Boolean = true):void {
			switch (true) {
				case targetCoordinateSpace is DisplayObject:
				case targetCoordinateSpace is Stage:
				case targetCoordinateSpace is Rectangle:
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
		 * 	A RectangleAlignment is capable of acting on its own, and aligning targets through this function
		 * 	What this won't do is any origin ignoring, repositioning, or maintaining original dimensions
		 * 
		 * @param	targets
		 * @return
		 */
		public function align (targetBounds:Array/*Rectangle*/):void {
			rectangleAligner.alignRectangles(getTCSBounds(tcs, ignoreTCSOrigin, targetBounds), targetBounds);				//	align them and return the new bounds for the targets
		}
		
		/** @private **/
		public function toString ():String {
			var str:String = "{type: " + rectangleAligner;
			str += ", tcs:" + tcs.name + "}";
			return str;
		}
		
		
		
		
		
		/** @private */
		static private const BAD_TCS	:String = "RectangleAlignment tcs must be a DisplayObject, Stage, or Rectangle";
		/** @private */
		static private const NO_TARGETS	:String = "RectangleAlignment : attempting to get TO_TARGETS bounds but did not receive any targetBounds";
		/**
		 * 
		 * 	returns a rectangle consisting of the boundaries of the targetCoordinateSpace
		 * 
		 * This accepts a Stage, DisplayObject, TO_TARGETS, or Rectangle object. Only these objects produce a rectangular boundary.
		 * 
		 * @param	targetCoordinateSpace	*	the object to extract the bounds from
		 * @param	ignoreTCSOrigin			Boolean	can only ignore the origin on a DisplayObject
		 * @param	targetBounds			Array	array of Rectangle for when using the TO_TARGETS
		 * @return
		 */
		static public function getTCSBounds(targetCoordinateSpace:*, ignoreTCSOrigin:Boolean = true, targetBounds:Array/*Rectangle*/= null):Rectangle {
			var tcsBounds:Rectangle = new Rectangle();
			switch (true) {
				case targetCoordinateSpace is Stage:
					var stage:Stage = targetCoordinateSpace as Stage;
					if (stage.displayState == StageDisplayState.FULL_SCREEN) 
						tcsBounds = new Rectangle (0, 0, stage.fullScreenSourceRect.width, stage.fullScreenSourceRect.height);
					else
						tcsBounds = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
					break;
				case targetCoordinateSpace is DisplayObject:
					tcsBounds = (targetCoordinateSpace as DisplayObject).getBounds(targetCoordinateSpace);
					tcsBounds.width = targetCoordinateSpace.width;
					tcsBounds.height = targetCoordinateSpace.height;
					if (ignoreTCSOrigin) {
						var dx:Point = targetCoordinateSpace.localToGlobal(new Point(tcsBounds.x, tcsBounds.y));
						tcsBounds.x = dx.x;
						tcsBounds.y = dx.y;
					}
					break;
				case targetCoordinateSpace === TO_TARGETS:
					if (!targetBounds) throw new Error (NO_TARGETS);			// can't get combined target bounds without targets...
					tcsBounds = targetBounds[0].clone();
					for (var i:int = 1; i < targetBounds.length; i++) {
						tcsBounds.union(targetBounds[i]);
					}
					break;
				case targetCoordinateSpace is Rectangle:
					tcsBounds = targetCoordinateSpace;
					break;
				default:
					return null;
			}
			return tcsBounds;
		}
	}
}