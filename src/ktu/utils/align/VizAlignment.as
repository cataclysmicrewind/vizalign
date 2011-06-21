

package ktu.utils.align {
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Rectangle;

	/**
	 * 
	 * AlignParam holds the neccessary values for each alingment.																								<br/>
	 * 																																							<br/>
	 * Each alignment needs three (3) things:																													<br/>
	 * First, the targets you wish to align.																													<br/>
	 * Second, how you wish to align the targets. 																												<br/>
	 * Third, what object do you want to align the targets to.																									<br/>
	 * 																																							<br/>
	 * Given this sentance 'I want to myMovieClip to the left of the stage', myMovieClip represents the targets,
	 * to the left represents the type, and of the stage represents the targetCoordinateSpace (tcs).															<br/>
	 * 																																							<br/>
	 * 
	 * @example 																																				<listing version="3">
	 * 		var param:AlignParam = new AlignParam(VizAlign.LEFT, stage);
	 * 		VizAlign.align([mc1, mc2], [param], true, stage);
	 * 																																							</listing>
	 */
	public class VizAlignment {
		
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
		
		/** @private **/
		public function toString ():String {
			var str:String = "{type: " + _type;
			str += ", tcs:" + _tcs.name + "}";
			return str;
		}
	}	
}