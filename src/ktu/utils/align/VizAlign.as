

package ktu.utils.align {

	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class VizAlign {
		
		
		
		static public const TO_TARGETS			:Rectangle	= new Rectangle( -1, -1, -1, -1);// place holder when aligning targets to the bounding area they create
		
		static public var pixelHinting			:Boolean 	= true;
		
		
		static private var _stageRef			:Stage;
		static private const LEFT				:Function 	= AlignMethods.left;		// so that the AlignMethods class is always compiled with VizAlign... yuck
		/**
		 * 	TODO:
		 * 		Make sure TO_TARGETS works
		 * 	  +		build function
		 * 	  +  	test
		 * 	  + verifyInput
		 * 	  + return VizAlignTargets properly
		 * 	  + think about the right way to get them converted to VizAlignTargets and how
		 * 		groups
		 * 			refactor copy of array
		 * 			implement the logic for getting a groups bounds
		 * 			implement the logic to adjust the individual rectangles after the group is done
		 * 		
		 * 
		 * 
		 * @param	targets
		 * @param	vizAlignments
		 * @param	applyResults
		 * @param	ignoreOrigin
		 * @param	stage
		 */
		static public function align (targets:Array, vizAlignments:Array/* of VizAlignment */, applyResults:Boolean = false, ignoreOrigin:Boolean = false):Array {
			targets = targets.concat();																				// copy array so we have new one (refactor when doing groups)
			verifyInput(targets, vizAlignments);																	// verify that all the input is acceptable
			
			var vizAlignTargets:Array/* of VizAlignTarget */ = convertToAlignTargets(targets);						// convert all targets to VizAlignTarget
			var alignedTargetBounds:Array/* of Rectangle */ = getBoundsFromVizAlignTargets(vizAlignTargets);		// get all rectangles to move
			
			
			var length:uint = vizAlignments.length;																	// get lenght of vizAlignments for optimized looping
			for (var i:int = 0; i < length; i++) {																	// for each vizAlignment
				var alignment:VizAlignment = vizAlignments[i];														// 		store ref to vizAlignment
				var tcsBounds:Rectangle = getTCSBounds(vizAlignTargets, alignment.tcs);								// 		get the tcs Bounds
				alignedTargetBounds = alignment.type(tcsBounds, alignedTargetBounds);								// 		align them and get the new Bounds for the targets
			}																										// end loop
			
			updateEndRectanglesForVizAlignTargets(vizAlignTargets, alignedTargetBounds);							// apply the changes to each VizAlignTarget
			// apply options
			if (pixelHinting) roundResults (vizAlignTargets);														// if pixelHinting, round the results
			if (ignoreOrigin) offsetOrigins(vizAlignTargets);														// if ignoreOrigin, offset the results by their origin
			if (applyResults) applyEnds(vizAlignTargets);															// if applyResults, tell all VizAlignTarget to go to end
			
			return vizAlignTargets;																					// return VizAlignTarget s
		}
		
		/**
		 * 	TODO: account for groups
		 * 	
		 * 
		 * @param	vizAlignTargets
		 */
		static public function applyEnds (vizAlignTargets:Array/* of VizAlignTarget */):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				VizAlignTarget( vizAlignTargets[i]).applyEndBounds();
			}
		}
		/**
		 * 	TODO: account for groups
		 * 	
		 * 
		 * @param	vizAlignTargets
		 */
		static public function applyOriginals (vizAlignTargets:Array/* of VizAlignTarget */):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				VizAlignTarget( vizAlignTargets[i]).applyOrigBounds();
			}
		}
		/**
		 * 	TODO: account for groups
		 * 	
		 * 
		 * @param	vizAlignTargets
		 */
		static public function offsetOrigins (vizAlignTargets:Array):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				VizAlignTarget( vizAlignTargets[i]).applyOriginOffestToEnd();
			}
		}
		
		
	
		/**
		 * 	TODO: account for groups
		 * 	
		 * 
		 * @param	alignedTargetBounds
		 */
		static public function roundResults(vizAlignTargets:Array):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				var end:Rectangle = VizAlignTarget(vizAlignTargets[i]).end;
				end.x = Math.round(end.x);
				end.y = Math.round(end.y);
				end.width = Math.round(end.width);
				end.height = Math.round(end.height);
			}
		}
		
		
		
		
		
		/*
		**************************************************************************************************
		*
		*  Utility Methods
		*
		* 			convertToVizAlignTargets
		* 			getBoundsFromVizAlignTargets
		* 			updateEndRectanglesForVizAlignTargets
		*
		*
		**************************************************************************************************
		*/
		
		
		
		
		
		
		
		
		static private function updateEndRectanglesForVizAlignTargets(alignTargets:Array, alignedTargetBounds:Array):void {
			for (var i:int = 0; i < alignTargets.length; i++) {
				var target:VizAlignTarget = alignTargets[i];
				var alignedRect:Rectangle = alignedTargetBounds[i];
				
				var targetEnd:Rectangle = target.end;
				targetEnd.x = alignedRect.x;
				targetEnd.y = alignedRect.y;
				targetEnd.width = alignedRect.width;
				targetEnd.height = alignedRect.height;
			}
		}
		
		
		static private function getBoundsFromVizAlignTargets(vizAlignTargets:Array):Array {
			var bounds:Array = [];
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				bounds[i] = vizAlignTargets[i].end;
			}
			return bounds;
		}
		
		static private function convertToAlignTargets(targets:Array):Array {
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
						break;
					default:												// object passed in was not a DisplayObject
						VizAlignError.e(VizAlignError.BAD_TARGET);			// shouldn't even happen but still
						break;
				}
			}
			return alignTargets;
		}
		/*
		**************************************************************************************************
		*
		*  Coordinate Space Functions
		*
		* 			getTCSBounds
		* 			getStageBounds
		*
		*
		**************************************************************************************************
		*/
		static private function getTCSBounds(vizAlignTargets:Array, tcs:*):Rectangle {
			var tcsBounds:Rectangle = new Rectangle();
			switch (true) {
				case tcs === TO_TARGETS:
					tcsBounds = getToTargetsBounds(vizAlignTargets);
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
		static private function getToTargetsBounds(targets:Array/* of VizAlignTarget */):Rectangle {
			var tcsBounds:Rectangle = new Rectangle();
			for (var i:int = 0; i < targets.length; i++) {
					tcsBounds.union(VizAlignTarget(targets[i]).end);
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
		static private function verifyInput(targets:Array, alignmentObjects:Array):void {
			if ( targets.length == 0 )			VizAlignError.e (VizAlignError.NO_TARGETS);					// if no targets in array, throw error
			if ( alignmentObjects.length == 0 )	VizAlignError.e (VizAlignError.NO_ALIGNPARAM);				// if not vizAlignemtns in array, throw error
			var allTargets:Array = getAllTargets(targets);													// grab all the targets in a one dimmension array
			var dupTargets:String = checkDuplicateTargets(allTargets);										// check for duplicate targets
			var tcsOverlap:String = checkTCSOverlap(allTargets, alignmentObjects);							// check for tcs target overlap
			if ( dupTargets.length > 0 )		VizAlignError.e (VizAlignError.DUP_TARGETS, dupTargets);	// if dupTargets string has characters, then there is error
			if ( tcsOverlap.length > 0 )		VizAlignError.e (VizAlignError.TCS_OVERLAP, tcsOverlap);	// if tcsOverlap string has characters, then there is error
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
		static private function checkDuplicateTargets (ar:Array):String {
			var length:int = ar.length;															// get length of targets for optimized looping
			for (var i:int = 0; i < length; ++i) {												// loop through all targets
				var outerI:DisplayObject = (ar[i] is VizAlignTarget) ? ar[i].target : ar[i];	//		save ref to DisplayObject of target
				for (var j:int = 0; j < length; ++j) {											//		loop through all targets - check saved ref to all other targets
					if (i == j) continue;														//			if i == j, of course it will be the same object, so continue
					var innerJ:DisplayObject = (ar[j] is VizAlignTarget) ? ar[j].target : ar[j];// 			save ref to inner loop target
					if (outerI === innerJ) return outerI.name;									//			if two targets are equal, return the name of the target
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
		static private function checkTCSOverlap (targets:Array, alignmentObjects:Array):String {
			var length:int = targets.length;															// get length of targets for optimized looping
			var alignlength:int = alignmentObjects.length;												// get length of alignmentObjects
			for (var j:int = 0; j < length; ++j) {														// loop through targets passed in
				var t:DisplayObject = (targets[j] is VizAlignTarget) ? targets[j].target : targets[j];	//		save the DisplayObject target
				for (var i:int = 0; i < alignlength; i++) {												// 		loop through every alignmentObject passed in
					if (VizAlignment(alignmentObjects[i]).tcs == t){									//			if the tcs and target match we have a problem
						return t.name;																	//				return name of target that is also a tcs
					}																					//			end if
				}																						//		end loop
			}																							// end loop
			return "";																					// return empty if no problems
		}
		/** @private
		 * 
		 * 		getAllTargets will grab all of the targets passed in. This will grab targets inside of any and all groups that have
		 * been made as well.
		 * @param	targets
		 * @return
		 */
		static private function getAllTargets(targets:Array):Array/* of DisplayObject */ {
			var returns:Array = new Array ();									// create return array
			for (var elmnt:String in targets) {									// for every element in targets...
				var item:* = targets[elmnt];									//		keep reference to current item
				if (item is Array) {											//		if element is an Array
					var n:Array = getAllTargets(item);							//			call getAllTargets on that Array
					returns = returns.concat(n);								//			concat the results from 'group' with this one
				} else if (item is DisplayObject){								//		else if target is DisplayObject
					returns.push(item);											//			add target to return Array
				} else if (item is VizAlignTarget) {							//		else if target is VizAlignTarget
					returns.push (item.target);									//			add VizAlignTarget.target to return array
				} else {														//		else
					var name:String = item.name ? item.name : item.toString();	//			try to get a name for it, if not then use it to string
					VizAlignError.e (VizAlignError.BAD_TARGET, name);			//			throw error, bad input
				}																//		end if
			}																	// end loop
			return returns;														// return results
		}
	}
}


/**
 * 
 * 	This class made it more clear as to how the Errors occur in VizAlign
 * 
 */
class VizAlignError {
	
	public static const NO_TARGETS		:String = "VizAlign : Must have at least one target";
	public static const NO_ALIGNPARAM	:String = "VizAlign : Must have at least one alignment method";
	public static const DUP_TARGETS		:String = "VizAlign : Cannot have duplicate targets";
	public static const TCS_OVERLAP		:String = "VizAlign : Targets cannot also be a targetCoordinateSpace";
	public static const BAD_TARGET		:String = "VizAlign : Target must be a DisplayObject/VizAlignTarget";
	
	static public function e (type:String, extraInfo:String = "") :void {
		var str:String = type
		str += (extraInfo.length > 0) ? " - " + extraInfo : "";
		throw new ArgumentError (str);
	}
	
}