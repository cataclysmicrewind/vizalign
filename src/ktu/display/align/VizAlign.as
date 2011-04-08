

package ktu.display.align {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * 		Duplicates all of the align panel functions you see
	 * inside the Flash IDE and more. Added functionality allows you to align any number
	 * of objects to another (like toStage, but with any other display object).
	 *
	 * 		There are 33 alignment methods to choose from, some of them may seem redundant, but choosing them may save you CPU time...
	 * 		VizAlign has all the functionality of the Flash IDE align panel. All of your standard alignment methods are here plus
	 * a bunch of other useful ones.
	 *
	 * @example
	 * This will align the two objects to the left edge of the bounding area the targets create.																<br/>
	 * With two objects on the stage labeled mc1, and mc2, call this code:																						<br/><listing version="3">
	 * 		import com.crp.display.utils.VizAlign;
	 * 		import com.crp.display.utils.VizAlignment;																											<br/>
	 * 		var param:VizAlignment = new VizAlignment( VizAlign.LEFT, VizAlign.TO_TARGETS );
	 * 		VizAlign.align( [mc1, mc2], [ param ], true, stage );																								</listing><br/>
	 *																																							<br/>
	 * This will align the two objects to the right edge of the stage.																							<br/>
	 * With two objects on the stage labeled mc1, and mc2, call this code:																						<br/><listing version="3">
	 * 		import com.crp.display.utils.VizAlign;
	 * 		import com.crp.display.utils.VizAlignment;																											<br/>
	 * 		var param:VizAlignment = new VizAlignment( VizAlign.RIGHT, stage );
	 * 		VizAlign.align( [mc1, mc2], [ param ], true, stage );																								</listing><br/>
	 *																																							<br/>
	 *																																							<br/>
	 * Lets say you want to align your targets to space evenly along the stage, and then to align																<br/>
	 * bottom to the bounding area the targets create: (you need four objects from mc1...mc4)																	<br/><listing version="3">
	 * 		import com.crp.display.utils.VizAlign;
	 * 		import com.crp.display.utils.VizAlignment;																											<br/>
	 * 		var param1:VizAlignment = new VizAlignment( VizAlign.SPACE_HORIZONTALLY, stage);
	 * 		var param1:VizAlignment = new VizAlignment( VizAlign.BOTTOM, VizAlign.TO_TARGETS);
	 *		VizAlign.align( [mc1, mc2, mc3, mc4], [ param1, param2 ], true, stage );																					</listing><br/>
	 *																																							<br/>
	 *																																							<br/>
	 * 																																							<br/>
	 * 		  Simple:	Align targets, to one targetCoordinateSpace																								<br/>
	 * 		Multiple:	Align targets, with multiple methods																									<br/>
	 * 		  Groups:	Align groups of targets, with any of the above.																							<br/>
	 *																																							<br/>
	 * Simple:																																					<br/><listing version="3">
	 * 		import com.crp.display.utils.VizAlign;
	 * 		import com.crp.display.utils.VizAlignment;																											<br/>
	 * 		var param:VizAlignment = new VizAlignment (VizAlign.LEFT, VizAlign.TO_TARGETS);
	 * 		VizAlign.align( [mc1, mc2], [ param ], true, stage );																								</listing><br/>
	 *																																							<br/>
	 * Multiple:																																				<br/><listing version="3">
	 * 		import com.crp.display.utils.VizAlign;
	 * 		import com.crp.display.utils.VizAlignment;																											<br/>
	 * 		var param1:VizAlignment = new VizAlignment (VizAlign.LEFT, VizAlign.TO_TARGETS);
	 * 		var param2:VizAlignment = new VizAlignment (VizAlign.TOP, VizAlign.TO_TARGETS);
	 * 		VizAlign.align( [mc1, mc2], [ param1, param2 ], true );																								</listing><br/>
	 *																																							<br/>																																					<br/>
	 * Groups:																																					<br/><listing version="3">
	 * 		import com.crp.display.utils.VizAlign;
	 * 		import com.crp.display.utils.VizAlignment;																											<br/>
	 * 		var group1:Array = [mc1, mc2];
	 * 		var group2:Array = [mc3, mc4];
	 * 		var group3:Array = [mc5, mc6, mc7];
	 * 		var param:VizAlignment = new VizAlignment (VizAlign.LEFT, VizAlign.TO_TARGETS);
	 * 		VizAlign.align( [ group1, group2, group3 ], [ param ], true, stage );																				</listing><br/>
	 * To treat multiple targets as a group, pass an array of each grouping as an element of the targets
	 * paramater. Return array for this example would be: results[0] is an Array of VizAlignments, with
	 * the targets for the first group, and so on.
	 *																																							<br/>
	 *																																							<br/>
	 * Author: Ktu																																				<br/>
	 * Version: 1.4 *																																			<br/>
	 * Last Update: 06.19.09																																	<br/>
	*/
	public class VizAlign extends AlignMethods {
		/**
		 * Align the targets left edge to match the left edge of the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const LEFT				:String		= "left";
		/**
		 * Align the x center of each target to match the x center of the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const HORIZONTAL			:String 	= "horizontal";
		/**
		 * Align the targets right edge to match the right edge of the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const RIGHT				:String 	= "right";
		/**
		 * Align both the targets x center and y center to match the x and y center of the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const CENTER				:String 	= "center";
		/**
		 * Align the targets top edge to match the top edge of the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const TOP					:String 	= "top";
		/**
		 * Align the y center of each target to match the x center of the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const VERTICAL			:String 	= "vertical";
		/**
		 * Align the targets bottom edge to macth the bottom edge of the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const BOTTOM				:String 	= "bottom";
		/**
		 * Align the targets top and left edge to match the top and left edge of the target coordinate space object.
		 * This method is a combination of TOP, and LEFT.
		 */
		public static const TOP_LEFT			:String 	= "topLeft";
		/**
		 * Align the targets top and right edge to match the top and right edge of the target coordinate space object.
		 * This method is a combination of TOP, and RIGHT.
		 */
		public static const TOP_RIGHT			:String 	= "topRight";
		/**
		 * Align the targets bottom and left edge to macth the bottom and left edge of the target coordinate space object.
		 * This method is a combination of BOTTOM, and LEFT.
		 */
		public static const BOTTOM_LEFT			:String 	= "bottomLeft";
		/**
		 * Align the targets bottom and right edge to macth the bottom and right edge of the target coordinate space object.
		 * This method is a combination of BOTTOM, and RIGHT.
		 */
		public static const BOTTOM_RIGHT		:String 	= "bottomRight";
		/**
		 * Place the targets right edge against the left edge of the target coordinate space object.
		 */
		public static const ADJACENT_LEFT		:String		= "adjacentLeft";
		/**
		 * Stack the targets side by side around the target coordinate space object.
		 */
		public static const ADJACENT_HORIZONTAL	:String		= "adjacentHorizontal";
		/**
		 * Place the targets left edge against the right edge of the target coordinate space object.
		 */
		public static const ADJACENT_RIGHT		:String		= "adjacentRight";
		/**
		 * Place the targets bottom edge against the top edge of the target coordinate space object.
		 */
		public static const ADJACENT_TOP		:String		= "adjacentTop";
		/**
		 * Stack the targets on top of each other around the target coordinate space object.
		 */
		public static const ADJACENT_VERTICAL	:String		= "adjacentVertical";
		/**
		 * Place the targets top edge againts the bottom edge of the target coordinate space object.
		 */
		public static const ADJACENT_BOTTOM		:String		= "adjacentBottom";
		/**
		 * Place the targets bottom and right edge against the top and left edge of the target coordinate space object.
		 */
		public static const ADJACENT_TL			:String		= "adjacentTopLeft";
		/**
		 * Place the targets bottom and left edge against the top and right edge of the target coordinate space object.
		 */
		public static const ADJACENT_TR			:String		= "adjacentTopRight";
		/**
		 * Place the targets top and right edge againts the bottom and left edge of the target coordinate space object.
		 */
		public static const ADJACENT_BL			:String		= "adjacentBottomLeft";
		/**
		 * Place the targets top and left edge againts the bottom and right edge of the target coordinate space object.
		 */
		public static const ADJACENT_BR			:String		= "adjacentBottomRight";
		/**
		 * Distribute the left edge of the targets evenly inside the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const DIST_LEFT			:String 	= "distLeft";
		/**
		 * Distribute the x center of the targets evenly inside the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const DIST_HORIZONTAL		:String 	= "distHorizontal";
		/**
		 * Distribute the right edge of the targets evenly inside the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const DIST_RIGHT			:String 	= "distRight";
		/**
		 * Distribute the top edge of the targets evenly inside the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const DIST_TOP			:String 	= "distTop";
		/**
		 * Distribute the y center of the targets evenly inside the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const DIST_VERTICAL		:String 	= "distVertical";
		/**
		 * Distribute the bottom edge of the targets evenly inside the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const DIST_BOTTOM			:String 	= "distBottom";
		/**
		 * Make all targets have the same width as the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const MATCH_WIDTH			:String 	= "matchWidth";
		/**
		 * Make all targets have the same height as the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const MATCH_HEIGHT		:String 	= "matchHeight";
		/**
		 * Make all targets have the same width and height as the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const MATCH_SIZE			:String 	= "matchSize";
		/**
		 * Make all the targets match the size of the target coordinate space object while maintaining the original width/height ratio.
		 */
		public static const SCALE_TO_FIT		:String 	= "scaleToFit";
		/**
		 * Evenly space the targets along the y axis inside of the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const SPACE_VERTICAL		:String 	= "spaceVertical";
		/**
		 * Evenly space the targets along the y axis inside of the target coordinate space object.
		 * This method works exactly like the align panel.
		 */
		public static const SPACE_HORIZONTAL	:String 	= "spaceHorizontal";
		/**
		 * Used when wishing to align targets to the bounding box they create.
		 *
		 * @example																																				<listing version="3">
		 * 		import com.crp.utils.align.VizAlign;
		 * 		import com.crp.utils.align.VizAlignment;																											<br/>
		 * 		var param:VizAlignment = new VizAlignment ( VizAlign.LEFT, VizAlign.TO_TARGETS );
		 * 		VizAlign.align ( [mc1, mc2, mc3], [ param ], true, stage);																						</listing>
		 */
		public static const TO_TARGETS			:Sprite		= new Sprite ();				// place holder when aligning targets to the bounding area they create
		//
		private static var _stageRef			:Stage;
		private static var createdSpace			:Boolean	= false;						// used to keep track when this method has created a coordinateSpace
		private static var haveGroups			:Boolean	= false;						// used to specify whether aligning groups, or single targets
		private static var tempName				:String		= "AlignTCS" + Math.random ();	// temp name used when creating a coordinate space
		private static var originalDic			:Dictionary = new Dictionary ();			// used to preserve ordering
		private static var _truePixel			:Boolean 	= true;
		//
		/**
		 * Specifies whether to round the end results of alignment
		 * @default true
		 * When truePixel = true, x,y,width, and height values are rounded using Math.round(); This is suggested and the default because when DisplayObject
		 * 		positioning end up on anything but an int, visuals can become blurred as Flash Player will try to blend colors. When TextField end up on a partial
		 * 		pixel, the anti ailiasing becomes poor.
		 */
		public static function get truePixel ():Boolean 		{ return _truePixel; }
		public static function set truePixel (n:Boolean):void 	{ _truePixel = n; 	 }
		/*
		***************************************************************************************************
		*
		*  Public Methods
		*
		* 			       align() - Aligns the objects you wish in what way to what areas
		* 			applyResults() - Apply the resulting values on an Array of VizAlignments
		* 		   applyOriginal() - Apply the original values on an Array of VizAlignments
		* 			 cloneObject() - Make a dummy clone of DisplayObject: Used in Eliminating TCS Issues
		*
		*
		**************************************************************************************************
		*/
		/**
		 *
		 * Align DisplayObject like when using the Align Panel in the IDE
		 *
		 * @param	targets				Array of DisplayObject/VizAlignment/Array	list of targets you wish to align
		 * @param	alignmentObjects	Array of VizAlignment	objects with specified parameters for each aligment to be applied to the targets	<br/>
		 * @param	applyResults		Boolean	specifies whether to move objects to their end result
		 * @param	stageRef			Stage	a reference to the stage.
		 * @return						Array of VizAlignment	containing targets with end result of alignment math
		 *
		 *
		 * @see method verifyInput() for full list of thrown errors
		 *
		 */
		public static function align (targets:Array, alignmentObjects:Array, applyResults:Boolean = false, stageRef:Stage = null):Array {
			
			haveGroups = false;											// set to false so we don't always have groups
			var targetArray:Array = targets.concat ();					// copy target array so we don't mess with original
			checkStageRef(targetArray, stageRef);						// save stageRef if needed; It MUST be set for this to work
			verifyInput(targetArray, alignmentObjects);					// if bad input, throws error
			targetArray.every (convertToVizAlignments);					// convert targets to VizAlignments
			fillDictionary (targetArray);								// maintins for ordering
			if (haveGroups) return alignGroups(targetArray, alignmentObjects, applyResults);	// if groups, use the alignGroups method
			
			var length:int = alignmentObjects.length;
			for (var i:int = 0; i < length; ++i) {						// Loop through all of the alingments to be done on targets
				var p:VizAlignment = alignmentObjects[i];					// save current align param
				var tcs:DisplayObjectContainer = validateCoordinateSpace(DisplayObjectContainer(p.tcs), targetArray);	// create tcs if needed; look at method
				var type:String = p.type;								// save the alignment method
				targetArray = alignMethod(targetArray, tcs, type); 		// call the appropriate alignment method
				checkCoordinateSpace(tcs);								// remove created coordinate space if needed
			}															// end loop
			
			if  (_truePixel) 					{ targetArray = roundPixels(targetArray); }		// if truePixel, round the end results
			if 	(!applyResults && !haveGroups) 	{ moveAllTargets(targetArray); }				// if we are not applying results, move targets to original position
			targetArray = sortTargets (targetArray);											// return the targets in the original order
			
			return targetArray;		//return the results
		}
		/**
		 *
		 * Apply End properties of VizAlignments to target
		 *
		 * @param		targets		Array of VizAlignment		comma seperrated list of targets you wish to apply their end values
		 *
		 */
		public static function applyResults (targets:Array):void {
			moveAllToEnd(targets);
		}
		/**
		 *
		 * Apply Orig properties of VizAlignments to target
		 *
		 * @param		targets		Array of VizAlignment		comma seperrated list of targets you wish to apply their original values
		 *
		 */
		public static function applyOriginal (targets:Array):void {
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
		public static function cloneObject (target:DisplayObject):Sprite {
			return cloneTarget ( new VizAlignTarget(target) );
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
		private static function alignGroups ( targets:Array, alignmentObjects:Array, applyResults:Boolean ) :Array {
			var newTargets:Array = new Array ();											// new array for fake targets
			var length:int = targets.length;
			for (var i:int = 0; i < length; ++i) {								// loop through all targets
				newTargets.push(createCoordinateSpace(targets[i]));						// 		create a fake object that is the objects in the group
			}																			// end loop
			var groupResults:Array = align(newTargets, alignmentObjects, applyResults);	// align the fake targets
			var results:Array = adjustGroups(targets, groupResults, newTargets);		// adjust the targets inside of the grouping to match the alignment
			if  (_truePixel) 		{ results = roundPixels(results); }					// if truePixel, round the end results
			if 	(!applyResults) 	{ moveAllTargets(results); }						// if we do not apply results, move targest to original position
			return results;		//return the results
		}
		private static function adjustGroups (targets:Array, groupResults:Array, newTargets:Array):Array {
			var length:int = groupResults.length;
			for (var i:int = 0; i < length; ++i) {										// loop through each group we have
				var item:* = targets[i];
				if (item is VizAlignment) {												// 		if target is VizAlignment
					applyGroupMath (item, groupResults[i], 0);							// 			applyGroupMath to just this
				} else {																// 		else
					var itemLength:int = targets[i].length;
					for (var j:int = 0; j < itemLength; ++j) {							// 			loop through each target
						applyGroupMath (item[j], groupResults[i], j);					// 				applyGroupMath to each target
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
		 * @param	targets		all targets as VizAlignment being used in this align() call.
		 */
		private static function moveAllTargets (targets:Array):void {
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
		 * @param	targets		all targets as VizAlignment being used in this align() call.
		 */
		private static function moveAllToEnd (targets:Array):void {
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
		private static function roundPixel ( targ:VizAlignTarget ) :void {
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
		private static function roundPixels (targets:Array):Array {
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
		private static function validateCoordinateSpace ( targetCoordinateSpace:DisplayObjectContainer, targets:Array ) :DisplayObjectContainer {
			switch ( targetCoordinateSpace ) {
				case TO_TARGETS:
					targetCoordinateSpace = createCoordinateSpace(targets);		//create a coordinate space for the bounding box of targets
					createdSpace = true;
					break;
				case _stageRef:
					targetCoordinateSpace = createStageSpace();			//create a coordinate space for the stage
					createdSpace = true;
					break;
				default:
					createdSpace = false;										//no coordinate space created.
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
		private static function createCoordinateSpace(targets:*):DisplayObjectContainer {
			var obj:Sprite = new Sprite ();						//create container sprite
			obj.name = tempName;								//use the tempName for easy identification
			if (targets is Array) {
				for (var elmnt:String in targets) {
					obj.addChild(cloneTarget(targets[elmnt]));		//add clones of all targets into container sprite
				}
			} else if (targets is VizAlignment) {
				obj.addChild (cloneTarget (targets));
			}
			_stageRef.addChild(obj);					//add container to stage (must be in a displaylist for getBounds() to work)
			return obj;
		};
		/** @private
		 *
		 * 		createStageSpace will create a target coordinate space matching the dimension of the stage. Fullscreen is handled
		 * as well.
		 *
		 * @param	targets
		 * @return
		 */
		private static function createStageSpace ():DisplayObjectContainer {
			var obj:Sprite = new Sprite ();										// create container sprite
			obj.name = tempName;												// use the tempName for easy identification
			if (_stageRef.displayState == StageDisplayState.FULL_SCREEN) {				// if we are in full screen...
				obj.graphics.drawRect(0, 0, _stageRef.fullScreenSourceRect.width, _stageRef.fullScreenSourceRect.height); // draw a rectangle matching the fullscreen dimensions
			} else {															// else if not in full screen
				obj.graphics.drawRect(0, 0, _stageRef.stageWidth, _stageRef.stageHeight);		// 		draw a rectangle matching the stage size
			}																	// end if
			_stageRef.addChild(obj);													// add container to displayList (must be for getBounds() to work)
			return obj;
		};
		/** @private
		 *
		 * 		checkCoordinateSpace will check to see if a target coordinate space was created for this alignment. If so,
		 * this method removes that target coordinate space from memory as there is no more need for it.
		 * @param	space
		 */
		private static function checkCoordinateSpace (space:DisplayObjectContainer):void {
			if (space.name == tempName && createdSpace) {		// if current target coordinate space's name matches the tempName, and createdSpace = true
				_stageRef.removeChild(space); 					// remove the target coordinate space
				while (space.numChildren > 0) {					// while tcs has children
					space.removeChildAt(0);						// 		remove a child from space
				}												// end while
				space = null;									// set space = null;
			}
		};
		/*		util
		*
		******************
		*  Util Methods  *
		******************
		*/
		/** @private
		 *
		 * 		cloneTarget will take an VizAlignment and duplicate the visual bounding box in the target property.
		 * @param	targ
		 * @return
		 */
		private static function cloneTarget(targ:VizAlignTarget):Sprite {
			var item:DisplayObject = targ.target;		//save the displayObject to clone
			var bData:BitmapData = new BitmapData(getWidth(item), getHeight(item), false); //create bitmap that matches dimensions of display object to clone
			var bmp:Bitmap = new Bitmap(bData); 		//add bitmap data to bitmap object
			bmp.x = getLeftEdge(item);					//position the clone at the same x value as DisplayObjec to clone
			bmp.y = getTopEdge(item);					//position the clone at the same y value as DisplayObjec to clone
			var dup:Sprite = new Sprite();				//create container sprite to hold bmp object
			dup.addChild(bmp);							//add bmp to container sprite
			return dup;
		};
		/** @private
		 *
		 * 		convertToVizAlignments will take all targets from align() call and convert them to VizAlignments if neccessary.
		 * If a target is already an VizAlignment, then the target of that VizAlignment is placed at the end values from previous
		 * alignment math if done so.
		 *
		 * @param	element
		 * @param	index
		 * @param	arr
		 * @return
		 */
		private static function convertToVizAlignments (element:*, index:int, arr:Array):* {
			switch (true) {
				case element is Array:
					element.every(convertToVizAlignments);	//if element is array, call this method again on that array
					haveGroups = true;						//set to true because an array was passed as a target, implying groups
					break;
				case element is DisplayObject:
					arr[index] = new VizAlignTarget(element, index); //create align object with that element
					break;
				case element is VizAlignment:
					VizAlignTarget ( element ) .applyEnd ( ) ;		//if already VizAlignment, place target at end values
					VizAlignTarget ( element ) .uid = index;		//reset the uid to fit this align call
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
		 * 		checkStageRef is called at the beginning of every align() call. This checks to see if the stage reference
		 * has been set for the AlignUtils class which is required for that class to function properly.
		 * @param	targets
		 * @param	passedRef
		 */
		private static function checkStageRef (targets:Array, passedRef:* = null):void {
			if (_stageRef) return;									//if I already have it set, stop
			if (passedRef) {
				_stageRef = passedRef;
			} else {
				_stageRef = getStageRefFromTargets(targets);
			}
		}
		/**
		 * searches all targets passed in for a reference to the stage
		 *
		 * @param	targets targets to look for a stage ref
		 */
		static private function getStageRefFromTargets(targets:Array):Stage{
			var l:int = targets.length;
			for (var i:int = 0; i < l; ++i) {
				var item:* = targets[i];
				switch (true) {
					case item is VizAlignment:
						return VizAlignTarget(item).target.stage;
					case item is DisplayObject:
						return DisplayObject(item).stage;
					case item is Array:
						return getStageRefFromTargets(item);
				}
			}
			return null;
		}
		/** @private
		 *
		 * 		fillDictionary will create a dictionary object for holding the targets array in its original order
		 * @param	targets
		 */
		private static function fillDictionary (targets:Array):void {
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
		private static function sortTargets (targets:Array):Array {
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
				var outerI:DisplayObject = (ar[i] is VizAlignment) ? ar[i].target : ar[i];		//		save ref to DisplayObject of target
				for (var j:int = 0; j < length; ++j) {											//		loop through all targets - check saved ref to all other targets
					if (i == j) continue;														//			if i == j, of course it will be the same object, so continue
					var innerJ:DisplayObject = (ar[j] is VizAlignment) ? ar[j].target : ar[j];	// 			save ref to inner loop target
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
				var t:DisplayObject = (targets[j] is VizAlignment) ? targets[j].target : targets[j];				//		save the DisplayObject target
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
				} else if (item is VizAlignment) {
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
				str = "VizAlign : Target must be a DisplayObject/VizAlignment - " + extraInfo;
			break;
		}
		throw new ArgumentError ({type:type, message:str});
	}
	
}