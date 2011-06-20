

package ktu.utils.align {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import ktu.utils.BoundsUtils;
	import ktu.utils.DisplayObjectUtils;
	import ktu.utils.StageUtils;
	
	public class VizAlign {
		
		
		public static const TO_TARGETS			:Rectangle	= new Rectangle(-1, -1, -1, -1);// place holder when aligning targets to the bounding area they create
		public static var pixelHinting			:Boolean 	= true;
		
		private static var _stageRef			:Stage;
		
		
		public static function align (targets:Array, vizAlignments:VizAlignment, applyResults:Boolean = false, ignoreOrigin:Boolean = false, stage:Stage = null):void {
			targets = targets.concat();																				// copy array so we have new one (refactor when doing groups)
			checkStageRef(stage);																					// make sure we have a reference to the stage
			verifyInput(targets, [vizAlignments]);																// verify that all the input is acceptable
			var alignTargets:Array = convertToAlignTargets(targets);												// convert all targets to VizAlignTarget
			var origTargetBounds:Array = getBoundsFromVizAlignTargets(alignTargets);								// get all rectangles to move
			
			// loop through and do all the maths
			var tcsBounds:Rectangle = BoundsUtils.getBounds(vizAlignments.tcs, stage);								// get the tcs Bounds
			var alignedTargetBounds:Array = vizAlignments.type(tcsBounds, origTargetBounds);						// align them and get the new Bounds for the targets
			
			// apply options
			if (pixelHinting) roundResults (alignedTargetBounds);
			if (ignoreOrigin) DisplayObjectUtils.offsetNewBoundsByOrigin(targets, alignedTargetBounds, stage);		//TODO: change this to be VizAlignTarget.offsetOrigins(array:Array/* of VizAlignTarget */):void
			if (applyResults) DisplayObjectUtils.applyNewBounds(targets, alignedTargetBounds);
		}
		
		public static function roundResults(alignedTargetBounds:Array):void {
			for (var i:int = 0; i < alignedTargetBounds.length; i++) {
				var item:Rectangle = alignedTargetBounds[i];
				item.x = Math.round(item.x);
				item.y = Math.round(item.y);
				item.width = Math.round(item.width);
				item.height = Math.round(item.height);
			}
		}
		
		
		
		
		
		
		public static function getBoundsFromVizAlignTargets(vizAlignTargets:Array):Array {
			var bounds:Array = [];
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				bounds[i] = vizAlignTargets[i].end;
			}
			return bounds;
		}
		
		public static function convertToAlignTargets(targets:Array):Array {
			var alignTargets:Array = [];
			for (var i:int = 0; i < targets.length; i++) {
				var item:* = targets[i];
				switch (true) {
					case item is Array:
						alignTargets[i] = convertToAlignTargets(item);
						break;
					case item is DisplayObject:
						alignTargets[i] = new VizAlignTarget(item);
						break;
					case item is VizAlignTarget:
						alignTargets[i] = item;
						VizAlignTarget(item).applyEndBounds();
						break;
					default:									//object passed in was not a DisplayObject
						throw new Error ("VizAlign : Target passed in was not Acceptable: must be DisplayObject or VizAlignTarget");
						break;
				}
			}
			return alignTargets;
		}
		
		
		
		/** @private
		 * 
		 * 		checkStageRef is called at the beginning of every align() call. This checks to see if the stage reference
		 * has been set for the AlignUtils class which is required for that class to function properly.
		 * @param	targets
		 * @param	passedRef
		 */
		private static function checkStageRef (passedRef:Stage = null):void {
			if (_stageRef) return;									//if I already have it set, stop
			if (passedRef) { _stageRef = passedRef; return; }	    //if it was passed in , stop
		}
		
		/*
		**************************************************************************************************
		*
		*  Error Methods
		*
		* 			verifyInput() - This method does all of the error checking for each align() call
		*
		* 		This method will check to make sure all of your input is acceptable to make the align()
		* 	function as expected. If you wish to override this, simply comment out the method call to this
		* 	function inside of the align().
		*
		**************************************************************************************************
		*/
		/** @private
		 * 
		 * 		verifyInput does just that, it verifies that everything you have passed into the align() method is acceptable
		 * input.
		 * 
		 * List of thrown errors:
		 * 		targets.length == 0							VizAlign : Must have at least one target
		 * 		alignmentObjects.length == 0				VizAlign : Must have at least one alignment method
		 * 		if there are duplicate targets				VizAlign : Cannot have duplicate targets
		 * 		if target is also a tcs						VizAlign : Targets cannot also be a targetCoordinateSpace
		 * 
		 * @param	targets
		 * @param	alignmentObjects
		 */
		private static function verifyInput(targets:Array, alignmentObjects:Array):void {
			var allTargets:Array = getAllTargets(targets);							//grab all the targets 
			var dupTargets:String = checkDuplicateTargets(allTargets);				//check for duplicate targets
			var tcsOverlap:String = checkTCSOverlap(allTargets, alignmentObjects);	//check for tcs target overlap
			if ( targets.length == 0 )			VizAlignError.e (VizAlignError.NO_TARGETS);
			if ( alignmentObjects.length == 0 )	VizAlignError.e (VizAlignError.NO_ALIGNPARAM);
			if ( dupTargets.length > 0 )		VizAlignError.e (VizAlignError.DUP_TARGETS, dupTargets);
			if ( tcsOverlap.length > 0 )		VizAlignError.e (VizAlignError.TCS_OVERLAP, tcsOverlap);
		};
		/*		error util
		*
		************************
		*  Error Util Methods  *
		************************
		*/
		/** @private
		 * 
		 * 		checkDuplicateTargets checks the targets array to see if any of the targets is duplicated. Having one DisplayObject
		 * as two seperate targets will mess up the alignment math and results will not be acceptable
		 * @param	ar
		 * @return
		 */
		private static function checkDuplicateTargets (ar:Array):String {
			var length:int = ar.length;
			for (var i:int = 0; i < length; ++i) {												// loop through all targets
				var outerI:DisplayObject = (ar[i] is VizAlignTarget) ? ar[i].target : ar[i];		//		save ref to DisplayObject of target
				for (var j:int = 0; j < length; ++j) {											//		loop through all targets - check saved ref to all other targets
					if (i == j) continue;														//			if i == j, of course it will be the same object, so continue
					var innerJ:DisplayObject = (ar[j] is VizAlignTarget) ? ar[j].target : ar[j];	// 			save ref to inner loop target
					if (outerI == innerJ) return outerI.name;									//			if two targets are equal, return the name of the target
				}																				//		end loop
			}																					// end loop
			return "";																			// return empty string cause its all good
		}
		/** @private
		 * 
		 * 		checkTCSOverlap will make sure that a target is not also a target coordinate space.
		 * @param	targets
		 * @param	alignmentObjects
		 * @return
		 */
		private static function checkTCSOverlap (targets:Array, alignmentObjects:Array):String {
			var length:int = targets.length;
			var alignlength:int = alignmentObjects.length;
			for (var j:int = 0; j < length; ++j) {																// loop through targets passed in
				var t:DisplayObject = (targets[j] is VizAlignTarget) ? targets[j].target : targets[j];				//		save the DisplayObject target
				for (var i:int = 0; i < alignlength; i++) {														// 		loop through every alignmentObject passed in
					if (VizAlignment(alignmentObjects[i]).tcs == t){												//			if the tcs and target match we have a problem
						return t.name;																			//				return name of target that is also a tcs
					}																							//			end if
				}																								//		end loop
			}																									// end loop
			return "";																							// return empty if no problems
		}
		/** @private
		 * 
		 * 		getAllTargets will grab all of the targets passed in. This will grab targets inside of any and all groups that have
		 * been made as well.
		 * @param	targets
		 * @return
		 */
		private static function getAllTargets(targets:Array):Array/* of DisplayObject */ {
			var returns:Array = new Array ();								// create return array
			for (var elmnt:String in targets) {								// for every element in targets...
				var item:* = targets[elmnt];								//		keep reference to current item
				if (item is Array) {										//		if element is an Array
					var n:Array = getAllTargets(item);						//			call getAllTargets on that Array
					returns = returns.concat(n);							//			concat the results from 'group' with this one
				} else if (item is DisplayObject){							//		else if target is DisplayObject
					returns.push(item);										//			add target to return Array
				} else if (item is VizAlignTarget) {
					returns.push (item.target);
				} else {													//		else
					VizAlignError.e (VizAlignError.BAD_TARGET, item.name);	//			throw error, bad input
				}															//		end if
			}																// end loop
			return returns;													// return results
		}
	}
}

class VizAlignError {
	
	public static const NO_TARGETS		:String = "noTargets";
	public static const NO_ALIGNPARAM	:String = "noAlignParam";
	public static const DUP_TARGETS		:String = "duplicateTargets";
	public static const TCS_OVERLAP		:String = "tcsOverlap";
	public static const BAD_TARGET		:String = "targetNotDisplayObject";
	
	public static function e (type:String, extraInfo:String = "") :void {
		var str:String = "";
		switch (type) {
			case NO_TARGETS:
				str = "VizAlign : Must have at least one target";
			break;
			case NO_ALIGNPARAM:
				str = "VizAlign : Must have at least one alignment method"
			break;
			case DUP_TARGETS:
				str = "VizAlign : Cannot have duplicate targets - " + extraInfo;
			break;
			case TCS_OVERLAP:
				str = "VizAlign : Targets cannot also be a targetCoordinateSpace - " + extraInfo;
			break;
			case BAD_TARGET:
				str = "VizAlign : Target must be a DisplayObject/VizAlignTarget - " + extraInfo;
			break;
		}
		throw new ArgumentError ({type:type, message:str});
	}
	
}