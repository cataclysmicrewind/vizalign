

package ktu.utils.align {
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ktu.utils.align.methods.AlignMethod;

	/**
	 * 
	 * VizAlignment holds the neccessary values for each alignment.																								<br/>
	 * 																																							<br/>
	 * Each alignment needs two (2) things:																														<br/>
	 * First, how you wish to align the targets. 																												<br/>
	 * Second, what object do you want to align the targets to.																									<br/>
	 * 																																							<br/>
	 * Given this sentance 'I want to myMovieClip to the left of the stage', 'myMovieClip' represents the targets,
	 * 'to the left' represents the type, and of 'the stage' represents the targetCoordinateSpace (tcs).															<br/>
	 * 																																							<br/>
	 * 
	 * @example 																																				<listing version="3">
	 * 		var param:VizAlignment = new VizAlignment(AlignMethods.left, stage);
	 * 		VizAlign.align([mc1, mc2], [param], true, true, true);
	 * 																																							</listing>
	 */
	public class VizAlignment {
		
		static public const TO_TARGETS	:Object	= { };// place holder when aligning targets to the bounding area they create
		
		/**
		 * 
		 * Alignment method type to be used in VizAlign.align()
		 * This value should be a const from VizAlign class.
		 */
		public var method	:AlignMethod;
		/**
		 * 
		 * Target Coordinate Space for the type in the align() call
		 * This is any DisplayObject. In Flash IDE terminoligy it is the same as saying align to the left of the [stage]. The tcs is [].
		 */
		public var tcs	:*;
		/**
		 * 	Only applies to tcs that are DisplayObject.
		 * 
		 * 	Does not apply to TO_TARGETS (if the targets have ignore origin, then it is ignored)
		 *  Does not apply to Rectangles (they can't have an origin offset)
		 * 	Does not apply to stage		 (the stage has no origin offset)
		 * 
		 * 
		 */
		public var ignoreTCSOrigin:Boolean = true;
		
		/**
		 *  The constructor needs to have both the type and tcs passed in, this makes sure that no AlignParam objects will be unsuitable for any VizAlign.align() call
		 * @param	type 	Function	a function from the AlignMethods class
		 * @param	tcs		* 	must be a DisplayObject, Stage, or Rectangle. 
		 */
		public function VizAlignment (method:AlignMethod, tcs:*, ignoreTCSOrigin:Boolean = true):void {
			switch (true) {
				case tcs is DisplayObject:
				case tcs is Stage:
				case tcs is Rectangle:
					break;
				default:
					throw new Error ("VizAlignment tcs must be a DisplayObject, Stage, or Rectangle");
			}
			this.method = method;
			this.tcs = tcs;
			this.ignoreTCSOrigin = ignoreTCSOrigin
		}
		
		/**
		 * 	This function will align the targets based of the specifications of this VizAlignment
		 *  
		 * 	Give it some rectanges, and it will spit them back aligned... awesome idea.
		 * 
		 * 
		 * @param	targets
		 * @return
		 */
		public function align (targetBounds:Array/*Rectangle*/):void {
			method.align(getTCSBounds(targetBounds, tcs), targetBounds);				//	align them and return the new bounds for the targets
		}
		
		public function getTCSBounds(targetBounds:Array/*Rectangle*/, tcs:*):Rectangle {
			var tcsBounds:Rectangle = new Rectangle();
			switch (true) {
				case tcs is Stage:
					var stage:Stage = tcs as Stage;
					if (stage.displayState == StageDisplayState.FULL_SCREEN) 
						tcsBounds = new Rectangle (0, 0, stage.fullScreenSourceRect.width, stage.fullScreenSourceRect.height);
					else
						tcsBounds = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
					break;
				case tcs is DisplayObject:
					tcsBounds = DisplayObject(tcs).getBounds(tcs);
					tcsBounds.width = tcs.width;
					tcsBounds.height = tcs.height;
					if (ignoreTCSOrigin) {
						var dx:Point = tcs.localToGlobal(new Point(tcsBounds.x, tcsBounds.y));
						tcsBounds.x = dx.x;
						tcsBounds.y = dx.y;
					}
					break;
				case tcs === TO_TARGETS:
					tcsBounds = targetBounds[0];
					for (var i:int = 1; i < targetBounds.length; i++) {
						tcsBounds.union(targetBounds[i]);
					}
					break;
				case tcs is Rectangle:
					tcsBounds = tcs;
					break;
				default:
					return null;
			}
			return tcsBounds;
		}
		
		/** @private **/
		public function toString ():String {
			var str:String = "{type: " + method;
			str += ", tcs:" + tcs.name + "}";
			return str;
		}
	}	
}