

package ktu.utils.align.test {

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
		
		public static const LEFT				:Function	= AlignMethods.left;
		public static const HORIZONTAL			:Function 	= AlignMethods.horizontal;
		public static const RIGHT				:Function 	= AlignMethods.right;
		public static const CENTER				:Function 	= AlignMethods.center;
		public static const TOP					:Function 	= AlignMethods.top;
		public static const VERTICAL			:Function 	= AlignMethods.vertical;
		public static const BOTTOM				:Function 	= AlignMethods.bottom;
		public static const TOP_LEFT			:Function 	= AlignMethods.topLeft;
		public static const TOP_RIGHT			:Function 	= AlignMethods.topRight;
		public static const BOTTOM_LEFT			:Function 	= AlignMethods.bottomLeft;
		public static const BOTTOM_RIGHT		:Function 	= AlignMethods.bottomRight;
		public static const ADJACENT_LEFT		:Function	= AlignMethods.adjacentLeft;
		public static const ADJACENT_HORIZONTAL	:Function	= AlignMethods.adjacentHorizontal;
		public static const ADJACENT_RIGHT		:Function	= AlignMethods.adjacentRight;
		public static const ADJACENT_TOP		:Function	= AlignMethods.adjacentTop;
		public static const ADJACENT_VERTICAL	:Function	= AlignMethods.adjacentVertical;
		public static const ADJACENT_BOTTOM		:Function	= AlignMethods.adjacentBottom;
		public static const ADJACENT_TL			:Function	= AlignMethods.adjacentTopLeft;
		public static const ADJACENT_TR			:Function	= AlignMethods.adjacentTopRight;
		public static const ADJACENT_BL			:Function	= AlignMethods.adjacentBottomLeft;
		public static const ADJACENT_BR			:Function	= AlignMethods.adjacentBottomRight;
		public static const DIST_LEFT			:Function 	= AlignMethods.distLeft;
		public static const DIST_HORIZONTAL		:Function 	= AlignMethods.distHorizontal;
		public static const DIST_RIGHT			:Function 	= AlignMethods.distRight;
		public static const DIST_TOP			:Function 	= AlignMethods.distTop;
		public static const DIST_VERTICAL		:Function 	= AlignMethods.distVertical;
		public static const DIST_BOTTOM			:Function 	= AlignMethods.distBottom;
		public static const MATCH_WIDTH			:Function 	= AlignMethods.matchWidth;
		public static const MATCH_HEIGHT		:Function 	= AlignMethods.matchHeight;
		public static const MATCH_SIZE			:Function 	= AlignMethods.matchSize;
		public static const SCALE_TO_FIT		:Function 	= AlignMethods.scaleToFit;
		public static const SCALE_TO_FILL		:Function 	= AlignMethods.scaleToFill;
		public static const SPACE_VERTICAL		:Function 	= AlignMethods.spaceVertical;
		public static const SPACE_HORIZONTAL	:Function 	= AlignMethods.spaceHorizontal;
		
		public static const TO_TARGETS			:Rectangle	= new Rectangle(-1, -1, -1, -1);// place holder when aligning targets to the bounding area they create
		
		public static var pixelHinting			:Boolean 	= true;
		
		private static var _stageRef			:Stage;
		
		
		
		
		public static function align (targets:Array, vizAlignments:VizAlignment, applyResults:Boolean = false, ignoreOrigin:Boolean = false, stage:Stage = null):void {
			
			targets = targets.concat();																				// copy array so we have new one (refactor when doing groups)
			checkStageRef(stage);																					// make sure we have a reference to the stage
			//verifyInput(targets, [vizAlignments]);																// verify that all the input is acceptable
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
		***************************************************************************************************
		*
		*  Public Methods
		*
		* 			       align() - Aligns the objects you wish in what way to what areas
		* 			applyResults() - Apply the resulting values on an Array of VizAlignTargets
		* 		   applyOriginal() - Apply the original values on an Array of VizAlignTargets
		* 			 cloneObject() - Make a dummy clone of DisplayObject: Used in Eliminating TCS Issues
		*
		*
		**************************************************************************************************
		*/
		/**
		 * 
		 * Align DisplayObject like when using the Align Panel in the IDE
		 *
		 * @param	targets				Array of DisplayObject/VizAlignTarget/Array	list of targets you wish to align
		 * @param	alignmentObjects	Array of AlignParam	objects with specified parameters for each aligment to be applied to the targets	<br/>
		 * @param	applyResults		Boolean	specifies whether to move objects to their end result
		 * @param	ignoreOrigin		Boolean	specifies whether to adjust the end positions by their origin offset. If true, then we will move them.
		 * @param	stageRef			Stage	a reference to the stage.
		 * @return						Array of VizAlignTarget	containing targets with end result of alignment math
		 *
		 * 
		 * @see method verifyInput() for full list of thrown errors
		 *
		 */
/*		public static function align (targets:Array, vizAlignments:Array, applyResults:Boolean = false, ignoreOrigin:Boolean = false, stageRef:Stage = null):Array {
		
			// copy the array of targets (we give you new one because we convert to VizAlignTarget)
				// when we end up implementing groups, then this function must be refactored to copy any sub array
			var targetArray:Array = targets.concat ();						// copy target array so we don't mess with original
			// make sure we have a reference to the stage
			checkStageRef(stageRef);										// save stageRef if needed; It MUST be set for this to work
			// verify that the input we receieved is ok
				//verifyInput(targetArray, vizAlignments);					// if bad input, throws error
			// convert all targets to VizAlignTarget
			var origTargetBounds:Array = DisplayObjectUtils.getBoundsArray(targets, _stageRef);
			targetArray.every (convertToVizAlignTargets);						// convert targets to VizAlignTargets
			
			// loop through and do all the maths
			var length:int = vizAlignments.length;
			for (var i:int = 0; i < length; ++i) {							// Loop through all of the alingments to be done on targets
				var p:VizAlignment = vizAlignments[i];						// save current align param
				var tcs:Rectangle = BoundsUtils.getBounds(p.tcs, _stageRef);// create tcs if needed; look at method
				var type:Function = p.type;									// save the alignment method
				var alignedTargetBounds:Array = type(tcs, origTargetBounds); 						// call the appropriate alignment method
			}																// end loop
			
			
			
			// if truePixel, round all the results to whole numbers
			if  (pixelHinting) 	{ targetArray = roundPixels(targetArray); }	// if truePixel, round the end results
			// if ignoreOrigin, apply the originOffsets
			if (ignoreOrigin) 	{ DisplayObjectUtils.offsetNewBoundsByOrigin(targets, alignedTargetBounds, stage) };
			// if applyResults, put them there
			if 	(applyResults) 	{ DisplayObjectUtils.applyNewBounds(targets, alignedTargetBounds); }				// if we are not applying results, move targets to original position
			// 
			return targetArray;		//return the results
		}
		/**
		 *
		 * Apply End properties of VizAlignTargets to target
		 *
		 * @param		targets		Array of VizAlignTarget		comma seperrated list of targets you wish to apply their end values
		 *
		 */
/*		public static function applyResults (targets:Array):void {
			moveAllToEnd(targets);
		}
		/**
		 *
		 * Apply Orig properties of VizAlignTargets to target
		 *
		 * @param		targets		Array of VizAlignTarget		comma seperrated list of targets you wish to apply their original values
		 *
		 */
/*		public static function applyOriginal (targets:Array):void {
			moveAllTargets(targets);
		}
		/**
		 *
		 * Clone a DisplayObject.
		 * 
		 * This may be useful when needed to eliminate the tcs issues.
		 *
		 * @param		target		DisplayObject	object you wish to duplicate in x, y, width, and height
		 * @return				Sprite				Dummy object duplicate of the target
		 *
		 */
/*		public static function cloneObject (target:DisplayObject):Sprite {
			return cloneTarget ( new VizAlignTarget(target) );
		}
		/**
		 * Make it work bitch
		 * @param	rect
		 * @return
		 */
/*		public static function createTCSbyRect (rect:Rectangle):Sprite {
			return new Sprite ();
		}
		/*
		**************************************************************************************************
		*
		*  Private Methods
		*
		* 		These are the private methods that are used by the public methods. They are grouped via
		* 		their use inside this class.
		*
		*
		**************************************************************************************************
		*/
		/*
		 *
		 ******************
		 *  Align Groups  *
		 ******************
		 */
/*		private static function alignGroups ( targets:Array, alignmentObjects:Array, applyResults:Boolean ) :Array {
			var newTargets:Array = new Array ();											// new array for fake targets
			var length:int = targets.length;
			for (var i:int = 0; i < length; ++i) {								// loop through all targets
				newTargets.push(createCoordinateSpace(targets[i]));						// 		create a fake object that is the objects in the group
			}																			// end loop
			var groupResults:Array = align(newTargets, alignmentObjects, applyResults);	// align the fake targets
			var results:Array = adjustGroups(targets, groupResults, newTargets);		// adjust the targets inside of the grouping to match the alignment
			if  (pixelHinting) 		{ results = roundPixels(results); }					// if truePixel, round the end results
			if 	(!applyResults) 	{ moveAllTargets(results); }						// if we do not apply results, move targest to original position
			return results;		//return the results
		}
		private static function adjustGroups (targets:Array, groupResults:Array, newTargets:Array):Array {
			var length:int = groupResults.length;
			for (var i:int = 0; i < length; ++i) {										// loop through each group we have
				var t:* = targets[i];
				if (t is VizAlignTarget) {													// 		if target is VizAlignTarget
					applyGroupMath (t, groupResults[i], 0);								// 			applyGroupMath to just this
				} else {																// 		else
					var tLength:int = targets[i].length;
					for (var j:int = 0; j < tLength; ++j) {								// 			loop through each target
						applyGroupMath (t[j], groupResults[i], j);						// 				applyGroupMath to each target
					}																	// 			end loop
				}																		// 		end if
				createdSpace = true;													// 		since we have groups, we must erase all fake targets
				checkCoordinateSpace(groupResults[i].target);							// 		this deletes the fake target I created
			}																			// end loop
			return targets;																// return targets
		}
		private static function applyGroupMath (target:VizAlignTarget, group:VizAlignTarget, index:int):void {
			var tend:Rectangle  = target.end;
			var ttarg:DisplayObject = target.target;
			var gtarg:DisplayObjectContainer = DisplayObjectContainer(group.target);
			tend.width  = ttarg.width  *= gtarg.scaleX;
			tend.height = ttarg.height *= gtarg.scaleY;
			tend.x      = ttarg.x       = getLeftEdge(gtarg.getChildAt(index)) - getLeftEdge(ttarg) + ttarg.x;
			tend.y      = ttarg.y       = getTopEdge (gtarg.getChildAt(index)) - getTopEdge (ttarg) + ttarg.y;
		}
		/*		move to c
		 *
		 *******************************
		 *  Move To Original Position  *
		 *******************************
		 */
		/** @private
		 * 
		 * 		moveAllTargets will move all of the targets in the align() call to their original values
		 * @param	targets		all targets as VizAlignTarget being used in this align() call.
		 */
/*		private static function moveAllTargets (targets:Array):void {
			var length:int = targets.length;
			for ( var i:int = 0; i < length; ++i ) {
				if ( targets [ i ] is Array ) {					//if the element in the targets is an array (aka group)
					moveAllTargets ( targets [ i ] ) ;			//call this method again with that array (aka group)
				} else {
					VizAlignTarget ( targets [ i ] ) .applyOrig ( ) ;	//apply the original results
				}
			}
		};
		/*		move to e
		 *
		 *****************************
		 *  Move To Ending Position  *
		 *****************************
		 */
		/** @private
		 * 
		 * 		moveAllToEnd will move all targets in this align() call to the end results.
		 * @param	targets		all targets as VizAlignTarget being used in this align() call.
		 */
/*		private static function moveAllToEnd (targets:Array):void {
			var length:int = targets.length;
			for ( var i:int = 0; i < length; ++i ) {
				if ( targets [ i ] is Array ) {					//if the element in the targets is an array (aka group)
					moveAllToEnd ( targets [ i ] ) ;			//call this method again with that array (aka group)
				} else {
					VizAlignTarget ( targets [ i ] ) .applyEnd ( ) ;	//apply the end results
				}
			}
		};
		/*		round
		 *
		 *******************
		 *  Round Results  *
		 *******************
		 */
		/** @private
		 * 
		 * 		roundPixel will take the end results and round the pixel values to an int.
		 * @param	targ	target to which the end results should be rounded to .0
		 */
/*		private static function roundPixel ( targ:VizAlignTarget ) :void {
			targ.target.x 		= targ.end.x 		= Math.round ( targ.target.x ) ;
			targ.target.y 		= targ.end.y 		= Math.round ( targ.target.y ) ;
			targ.target.width 	= targ.end.width 	= Math.round ( targ.target.width ) ;
			targ.target.height 	= targ.end.height 	= Math.round ( targ.target.height ) ;
		}
		/** @private
		 * 
		 * 		roundPixels takes all targets and rounds the pixels to an int.
		 * @param	targets
		 * @return
		 */
/*		private static function roundPixels (targets:Array):Array {
			var length:int = targets.length;
			for ( var i:int = 0; i < length; ++i ) {
				if ( targets [ i ] is Array ) {					//if the element in the targets is an array (aka group)
					roundPixels ( targets [ i ] ) ;				//call this method again with that array (aka group)
				} else {
					roundPixel ( targets [ i ] ) ;				//round the pixels of the results
				}
			}
			return targets;
		};
		/*		tcs
		*
		**********************
		*  Coordinate Space  *
		**********************
		*/
		/** @private
		 * 
		 * 		This method is used to check if a target coordinate space needs to be created or not. If the possible
		 * target coordinate space is already a display object, then our target coordinate space is already created.
		 * However if the potential target coordinate space is either the TO_TARGETS constant, or a reference to the
		 * stage, a target cooridnate space must be created for it. 
		 * 																																						<br/></br>
		 * When creating a coordinate space for the TO_TARGETS constant, a display object is created that is equal to
		 * the bounding box of all the targets in this align() call.
		 * 																																						<br/><br/>
		 * When creating a coordinate space for the stage, it creates a box equal to the visible area of the stage.
		 * 
		 * 
		 * @param	targetCoordinateSpace
		 * @param	targets
		 * @return
		 */
/*		private static function validateCoordinateSpace ( targetCoordinateSpace:*, targets:Array ) :Rectangle {
			switch ( targetCoordinateSpace ) {
				case TO_TARGETS:
					targetCoordinateSpace = createCoordinateSpace(targets);		//create a coordinate space for the bounding box of targets
					break;
				case _stageRef:
					targetCoordinateSpace = StageUtils.getStageBounds(_stageRef);
					break;
			}
			return targetCoordinateSpace;
		};
		/** @private
		 * 
		 * 		createCoordinateSpace will create a coordinate space that matches the bounding box of all the targets combined
		 * 
		 * @param	targets
		 * @return
		 */
/*		private static function createCoordinateSpace(targets:*):Rectangle {
			var rect:Rectangle = new Rectangle();
			if (targets is Array) {
				for each (var elmnt:VizAlignTarget in targets) {
					rect.union(elmnt.end);
				}
			} else if (targets is VizAlignTarget) {
				rect = VizAlignTarget(targets).end;
			}	
			return rect;
		};
		
		/*		util
		*
		******************
		*  Util Methods  *
		******************
		*/
		
		/** @private
		 * 
		 * 		convertToVizAlignTargets will take all targets from align() call and convert them to VizAlignTargets if neccessary.
		 * If a target is already an VizAlignTarget, then the target of that VizAlignTarget is placed at the end values from previous
		 * alignment math if done so.
		 * 
		 * @param	element
		 * @param	index
		 * @param	arr
		 * @return
		 */
/*		private static function convertToVizAlignTargets (element:*, index:int, arr:Array):* {
			switch (true) {
				case element is Array:
					element.every(convertToVizAlignTargets);	//if element is array, call this method again on that array
					haveGroups = true;						//set to true because an array was passed as a target, implying groups
					break;
				case element is DisplayObject:
					arr[index] = new VizAlignTarget(element, index); //create align object with that element
					break;
				case element is VizAlignTarget:
					VizAlignTarget(element).applyEnd ( ) ;		//if already VizAlignTarget, place target at end values
					break;
				default:									//object passed in was not a DisplayObject
					var errorString:String = "VizAlign : Target passed in was not Acceptable - " + element;
					errorString += (element.name != null) ? " - " + element.name : "";
					VizAlignError.e (VizAlignError.BAD_TARGET, errorString);
					break;
			}
			return true;
		}
		
		/** @private
		 * 
		 * 		fillDictionary will create a dictionary object for holding the targets array in its original order
		 * @param	targets
		 */
/*		private static function fillDictionary (targets:Array):void {
			originalDic = new Dictionary ();
			var length:int = targets.length;
			for (var i:int = 0; i < length; ++i) {
				originalDic[i] = targets[i];
			}
		}
		/** @private
		 *
		 * 		sortTargets sorts the target back into the original order that they were passed in as
		 * @param	array
		 */
/*		private static function sortTargets (targets:Array):Array {
			var ar:Array = new Array ();
			var length:int = targets.length;
			for (var i:int = 0; i < length; ++i) {
				ar[i] = originalDic[i];
				if (targets[i] is Array) targets[i].sortOn ("uid");
			}
			return ar;
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
		private static function getAllTargets(targets:Array):Array {
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