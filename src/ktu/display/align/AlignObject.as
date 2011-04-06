

package ktu.display.align {
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	/**
	 *
	 * 		Used to keep track of DisplayObject and their positioning before and after
	 * alignment math is complete. Every time a DisplayObject is used in the VizAlign
	 * it is automatically added to an AlignObject, and the AlignObject is returned from
	 * the VizAlign.align() call. Instead of passing a DisplayObject into the VizAlign.align()
	 * you can pass in AlignObjects. This may be useful when making multiple VizAlign.align()
	 * calls and wish to use the previous results of the first VizAlign.align() call.
	 * 																																							<br/>
	 * 		For more information please view the VizAlign class.
	 *
	 *																																							<br/>
	 * @example																																					<br/>
	 * 		Say you align mc1, and mc2, to the left of the stage. The return
	 * array of VizAlign.align() will be an array of AlignObjects. Use the properties
	 * of this class to apply movement.																															<br/>
	 *																																							<br/>
	 * If you want to move the objects half way to the destination																								<br/><listing version="3">
	 * results[0].target.x -= (results[0].orig.x - results[0].end.x) / 2;
	 * results[0].target.y -= (results[0].orig.y - results[0].end.y) / 2;																						</listing><br/>
	 *																																							<br/>
	 *																																							<br/>
	 * Author: Ktu																																				<br/>
	 * Version: 0.5 *																																			<br/>
	 * Last Update: 05.03.09																																	<br/>
	 *																																							<br/>
	 * version history:																																			<br/>
	 * 05.03.09 0.5 : Removed deprecated variables and cleand up code																							<br/>
	 * 11.19.08	0.4	: Removed temp var. no longer needed.																										<br/>
	 * 11.15.08	0.3 : Removed old methods																														<br/>
	 * 11.13.08	0.2 : Added temp vars for multiple methods																										<br/>
	 * 11.10.08	0.1 : First Created																																<br/>
	 *
	*/
	public class AlignObject extends Object {
		
		private var _target:DisplayObject;
		private var _uid:int;
		
		private var _orig:Rectangle = new Rectangle ( ) ;
		private var _end:Rectangle = new Rectangle ( ) ;
		
		/**
		 *
		 * DisplayObject assosiated with this object.
		 * This property can only be set through the constructor.
		 */
		public function get target ( ) :DisplayObject { return _target; }
		/**
		 *
		 * unique identifier for each AlignObject during alignment code.
		 * @default 0
		*/
		public function get uid ( ) :int { return _uid; }
		public function set uid ( n:int ) :void { _uid = n; }
		/**
		 *
		 * rectangle containing the target's original x, y, width, and height before alignment.
		 */
		public function get orig ( ) :Rectangle { return _orig; }
		/**
		 *
		 * rectangle containing the target's resulting x, y, width, and height after alignment.
		 */
		public function get end ( ) :Rectangle { return _end; }
		
		/**
		 *
		 * Let's you create an AlignObject with the specified target and unique identifier
		 *
		 * @param	target		the target DisplayObject who'se values will be modified
		 * @param	uid			unique identifier for each alignment call
		 */
		public function AlignObject ( target:DisplayObject, uid:int = 0 ) :void {
			_target = target;
			_uid 	= uid;	//used for mainting original order of targets
			//save current initial values
			_orig.x 		= _end.x 		= target.x;
			_orig.y 		= _end.y 		= target.y;
			_orig.width 	= _end.width 	= target.width;
			_orig.height 	= _end.height 	= target.height;
		}
		/**
		 *
		 * applies the original values of the target object to the target before any alignment math was completed
		 */
		public function applyOrig ( ) :void {
			_target.x 		= _orig.x;
			_target.y 		= _orig.y;
			_target.width 	= _orig.width;
			_target.height 	= _orig.height;
		}
		/**
		 *
		 * applies the resulting values of the alignment math to the target
		 */
		public function applyEnd ( ) :void {
			_target.x 		= _end.x;
			_target.y 		= _end.y;
			_target.width 	= _end.width;
			_target.height 	= _end.height;
		}
		
		/** @private */
		public function toString ( ) :String {
			var str:String = "";
			str += "AlignObject:\ttarget:" + _target.name + "\t";
			str += "eX:" + _end.x + " ";
			str += "eY:" + _end.y + " ";
			str += "eW:" + _end.width + " ";
			str += "eH:" + _end.height + "\n";
			return str;
		}
	}
}