

package ktu.utils.align {

	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * 
	 * 
	 * 	TODO:
	 * 		Origins:
	 *			Issues is that ignore origins adjusts it on both x&y every time, yet may only want one to change...
	 * 			this worked before when the origin was calculated in the align method and not post alignment
	 * 			checking against the delta of x&y helps, but not always...
	 * 
	 * 		Method Manifests
	 * 			How can I make it so I only compile the align functions I use
	 * 			How can I forcibly include all methods?
	 * 
	 * 		Input Validation
	 * 			Only throw errors for Bad Targets
	 * 			should I only accept premade VizAlignTargets? does it make a difference?
	 * 			
	 * 
	 * 		VizAlignGroup - figure out whether it should be an array of VizAlignTargets, or just DisplayObject
	 * 			scaleFromOrigin()
	 * 				x&y += offsetFromOrigin * scale
	 * 				w&h += orig w&h * scale
	 * 			override applyOriginOffset()
	 * 				x&y += originOffset * scale
	 * 
	 * 		VizAlignTarget
	 * 			scalePadding:Boolean;
	 * 			padding
	 * 				(x + padding) * scale	(scalePadding)
	 * 				x * scale + padding		(!scalePadding)
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 */
	public class VizAlign {
		/**
		 * 
		 * 
		 * @param	targets
		 * @param	vizAlignments
		 * @param	applyResults
		 * @param	ignoreOrigin
		 * @param	pixelHinting
		 * 
		 * @return
		 */
		static public function align (targets:Array, vizAlignments:Array/*VizAlignment*/, ignoreOrigin:Boolean = false, applyResults:Boolean = false, pixelHinting:Boolean = false):Array/*VizAlignTarget*/ {
			if ( targets.length == 0 || vizAlignments.length == 0)	return [];								// if no targets in array, return nothing. idiot
			
			targets = targets.concat();																		// copy array so we have new one (refactor when doing groups)
			verifyInput(targets, vizAlignments);															// verify that all the input is acceptable
			
			var vizAlignTargets:Array/*VizAlignTarget*/ = convertToVizAlignTargets(targets);				// convert all targets to VizAlignTarget
			var targetEndBounds:Array/*Rectangle*/ = getBoundsFromVizAlignTargets(vizAlignTargets);			// get all rectangles to move
			
			var length:uint = vizAlignments.length;															// get lenght of vizAlignments for optimized looping
			for (var i:int = 0; i < length; i++) {															// for each vizAlignment
				targetEndBounds = vizAlignments[i].align (targetEndBounds);									//		have the VizAlignment align the rectnalges
			}																								// end loop
			
			if (ignoreOrigin) applyOriginOffsets(vizAlignTargets);											// if ignoreOrigin, offset the results by their origin
			if (pixelHinting) roundResults (vizAlignTargets);												// if pixelHinting, round the results
			if (applyResults) applyEnds(vizAlignTargets);													// if applyResults, tell all VizAlignTarget to go to end
			
			return vizAlignTargets;																			// return VizAlignTarget s
		}
		
		/**
		 * 	TODO: account for groups
		 * 				technically already fonr as the groups extend VizAlignTarget
		 * 
		 * @param	vizAlignTargets
		 */
		static public function applyEnds (vizAlignTargets:Array/*VizAlignTarget*/):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				VizAlignTarget( vizAlignTargets[i]).applyEndBounds();
			}
		}
		/**
		 * 	TODO: account for groups
		 * 			technically already fonr as the groups extend VizAlignTarget
		 * 
		 * @param	vizAlignTargets
		 */
		static public function applyOriginals (vizAlignTargets:Array/*VizAlignTarget*/):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				VizAlignTarget( vizAlignTargets[i]).applyOrigBounds();
			}
		}
		/**
		 * 	TODO: account for groups
		 * 			technically already done as the groups extends VizAlignTarget
		 * 
		 * @param	vizAlignTargets
		 */
		static public function applyOriginOffsets (vizAlignTargets:Array/*VizAlignTarget*/):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				VizAlignTarget(vizAlignTargets[i]).applyOriginOffset = true;
			}
		}
		/**
		 * 	TODO: account for groups
		 * 			technically already done as the groups extends VizAlignTarget
		 * 
		 * @param	vizAlignTargets
		 */
		static public function removeOriginOffsets (vizAlignTargets:Array/*VizAlignTarget*/):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				VizAlignTarget(vizAlignTargets[i]).applyOriginOffset = false;
			}
		}
		
	
		/**
		 * 	TODO: account for groups
		 * 			that shouldn't be hard with the VizAlignGroup class idea
		 * 
		 * @param	alignedTargetBounds
		 */
		static public function roundResults(vizAlignTargets:Array/*VizAlignTarget*/):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				vizAlignTargets[i].roundEndValues();
			}
		}
		
		/*
		**************************************************************************************************
		*
		*  Utility Methods
		*
		**************************************************************************************************
		*/
		static private function getBoundsFromVizAlignTargets(vizAlignTargets:Array/*VizAlignTarget*/):Array/*Rectangle*/ {
			var bounds:Array/*Rectangle*/ = [];
			for (var i:int = 0; i < vizAlignTargets.length; i++) bounds[i] = vizAlignTargets[i].end;
			return bounds;
		}
		static private function convertToVizAlignTargets(targets:Array):Array/*VizAlignTarget*/ {
			var vizAlignTargets:Array/*VizAlignTarget*/ = [];
			for (var i:int = 0; i < targets.length; i++) {
				var item:* = targets[i];
				switch (true) {
					case item is Array:
						vizAlignTargets[i] = convertToVizAlignTargets(item);
						break;
					case item is DisplayObject:
						vizAlignTargets[i] = new VizAlignTarget(item);
						break;
					case item is VizAlignTarget:
						vizAlignTargets[i] = item;
						break;
					default:												// object passed in was not a DisplayObject
						VizAlignError.e(VizAlignError.BAD_TARGET);			// shouldn't even happen but still
						break;
				}
			}
			return vizAlignTargets;
		}
		/*
		**************************************************************************************************
		*
		*  Error Methods
		*
		**************************************************************************************************
		*/
		/** @private
		 * 
		 * 		verifies that everything you have passed into the align() method is acceptable input.
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
		static private function verifyInput(targets:Array, alignmentObjects:Array/*VizAlignment*/):void {
			var allTargets:Array = getAllTargets(targets);													// grab all the targets in a one dimmension array
			var tcsOverlap:String = checkTCSOverlap(allTargets, alignmentObjects);							// check for tcs target overlap
			if ( tcsOverlap.length > 0 )		VizAlignError.e (VizAlignError.TCS_OVERLAP, tcsOverlap);	// if tcsOverlap string has characters, then there is error
			//var dupTargets:String = checkDuplicateTargets(allTargets);										// check for duplicate targets
			//if ( dupTargets.length > 0 )		VizAlignError.e (VizAlignError.DUP_TARGETS, dupTargets);	// if dupTargets string has characters, then there is error
		};
		/*		error util
		*
		************************
		*  Error Util Methods  *
		************************
		*/
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
	}
}


/**
 * 	This class made it more clear as to how the Errors occur in VizAlign
 */
class VizAlignError {
	
	public static const DUP_TARGETS		:String = "VizAlign : Cannot have duplicate targets";
	public static const TCS_OVERLAP		:String = "VizAlign : Targets cannot also be a targetCoordinateSpace";
	public static const BAD_TARGET		:String = "VizAlign : Target must be a DisplayObject/VizAlignTarget";
	
	static public function e (type:String, extraInfo:String = "") :void {
		throw new ArgumentError (type + ((extraInfo.length > 0) ? " - " + extraInfo : ""));
	}
}