

package ktu.utils.align {
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Point;
	import flash.geom.Rectangle;

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
		
		static public const TO_TARGETS	:Rectangle	= new Rectangle( -1, -1, -1, -1);// place holder when aligning targets to the bounding area they create
		
		private var _type	:Function;
		private var _tcs	:*;
		
		/**
		 * 
		 * Alignment method type to be used in VizAlign.align()
		 * This value should be a const from VizAlign class.
		 */
		public function set type (v:Function)	:void 		{ _type = v; 	}
		public function get type ()				:Function	{ return _type; }
		/**
		 * 
		 * Target Coordinate Space for the type in the align() call
		 * This is any DisplayObject. In Flash IDE terminoligy it is the same as saying align to the left of the [stage]. The tcs is [].
		 */
		public function set tcs (v:*)	:void 	{ _tcs = v;		}
		public function get tcs ()		:* 		{ return _tcs;  }
		
		/**
		 *  The constructor needs to have both the type and tcs passed in, this makes sure that no AlignParam objects will be unsuitable for any VizAlign.align() call
		 * @param	type 	Function	a function from the AlignMethods class
		 * @param	tcs		* 	must be a DisplayObject, Stage, or Rectangle. 
		 */
		public function VizAlignment (type:Function, tcs:*):void {
			switch (true) {
				case tcs is DisplayObject:
				case tcs is Stage:
				case tcs is Rectangle:
					break;
				default:
					throw new Error ("VizAlignment tcs must be a DisplayObject, Stage, or Rectangle");
			}
			_type = type;
			_tcs = tcs;
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
			var tcsBounds:Rectangle = getTCSBounds(targetBounds, tcs);		//	get the tcs Bounds
			type(tcsBounds, targetBounds);							//	align them and return the new bounds for the targets
		}
		
		
		
		/*
		**************************************************************************************************
		*
		*  Coordinate Space Functions
		*
		**************************************************************************************************
		*/
		static private function getTCSBounds(targetBounds:Array/*Rectangle*/, tcs:*):Rectangle {
			var tcsBounds:Rectangle = new Rectangle();
			switch (true) {
				case tcs === TO_TARGETS:
					tcsBounds = getToTargetsBounds(targetBounds);
					break;
				case tcs is Rectangle:
					tcsBounds = tcs;
					break;
				case tcs is Stage:
					tcsBounds = getStageBounds(tcs);
					break;
				case tcs is DisplayObject:
					tcsBounds = getDisplayObjectBounds(tcs);
					break;
				default:
					return null;
			}
			return tcsBounds;
		}
		static private function getToTargetsBounds(targetBounds:Array/*Rectangle*/):Rectangle {
			var tcsBounds:Rectangle = new Rectangle();
			for (var i:int = 0; i < targetBounds.length; i++) {
					tcsBounds.union(targetBounds[i]);
				}
			return tcsBounds;
		}
		
		static private function getDisplayObjectBounds(tcs:DisplayObject):Rectangle {
			var rect:Rectangle = DisplayObject(tcs).getBounds(tcs);
			var dx:Point = tcs.localToGlobal(new Point(rect.x, rect.y));
			rect.x = dx.x;
			rect.y = dx.y;
			return rect;
		}
		public static function getStageBounds(stage:Stage):Rectangle {
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				return new Rectangle (0, 0, stage.fullScreenSourceRect.width, stage.fullScreenSourceRect.height);
			} else {
				return new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
			}
		}
		
		
		
		
		
		/** @private **/
		public function toString ():String {
			var str:String = "{type: " + _type;
			str += ", tcs:" + _tcs.name + "}";
			return str;
		}
	}	
}