

/**
 * align package
 */
package ktu.utils.align {

	import flash.display.DisplayObject;
	
	/**
	 * 
	 * the VizAlign class is simple api for visually aligning DisplayObject.
	 * 
	 * like the align panel in the flash ide, vizalign will align objects. however, with vizalign
	 * you are not limited to just the targets themselves or the stage. the object in which you align
	 * the targets to can be a Stage, DisplayObject, Rectangle, or the targets themselves. 
	 * 
	 * 
	 * 
	 * 
	 */
	public class VizAlign {
		
		static private const BAD_TARGET		:String = "VizAlign : Target must be a DisplayObject/VizAlignTarget";
		
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
			if ( !targets.length || !vizAlignments.length )	return [];									// if no targets or vizAlignments, return nothing. idiot
			targets = targets.concat();																	// copy array so we have new one (same objects, but different array object)
			
			var vizAlignTargets:Array/*VizAlignTarget*/ = convertToVizAlignTargets(targets);			// convert all targets to VizAlignTarget
			if (ignoreOrigin) applyOriginOffsets(vizAlignTargets, true);									// if ignoreOrigin, offset the end bounds so we are actually aligning the visual rectangle of the target
			var targetEndBounds:Array/*Rectangle*/ = getEndBoundsFromVizAlignTargets(vizAlignTargets);		// get all rectangles to move (the core of VizAlign is based solely on Rectangle
			
			var length:uint = vizAlignments.length;														// get length of vizAlignments for optimized looping
			for (var i:int = 0; i < length; i++) {														// for each vizAlignment
				var vizAlignment:VizAlignment = vizAlignments[i];										//		get reference to RectangleAlignment
				if (!vizAlignment) continue;															// 		not a RectangleAlignment...
				else vizAlignment.align (targetEndBounds);												//		have the VizAlignment align the rectnalges
			}																							// end loop
			
			updateGroups(vizAlignTargets);																// update groups if we have them
			if (ignoreOrigin) applyOriginOffsets(vizAlignTargets, false);									// if ignoreOrigin, remove the offset, so the actual target ends up in the right place
			if (pixelHinting) roundResults (vizAlignTargets);											// if pixelHinting, round the results
			if (applyResults) applyEnds(vizAlignTargets);												// if applyResults, tell all VizAlignTarget to go to end
			
			return vizAlignTargets;																		// return VizAlignTarget
		}
		
		/**
		 *  applies the .end property of each VizAlignTarget given to the function
		 * @param	vizAlignTargets
		 */
		static public function applyEnds (vizAlignTargets:Array/*VizAlignTarget*/):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				(vizAlignTargets[i] as VizAlignTarget).applyEndBounds();
			}
		}
		/**
		 *  applies the .orig property of each VizAlignTarget given to the function
		 * @param	vizAlignTargets
		 */
		static public function applyOriginals (vizAlignTargets:Array/*VizAlignTarget*/):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				(vizAlignTargets[i] as VizAlignTarget).applyOrigBounds();
			}
		}
		/**
		 *  set the .applyOriginOffset property of the VizAlignTarget sent in.
		 * @param	vizAlignTargets
		 */
		static public function applyOriginOffsets (vizAlignTargets:Array/*VizAlignTarget*/, ignoreOrigins:Boolean = true ):void {
			for each (var t:VizAlignTarget in vizAlignTargets) 
				t.ignoreOriginOffset = ignoreOrigins;
		}
		/**
		 * round all of the .end values. this is undoable
		 * @param	alignedTargetBounds
		 */
		static public function roundResults(vizAlignTargets:Array/*VizAlignTarget*/):void {
			for each (var t:VizAlignTarget in vizAlignTargets) 
				t.roundEndValues();
		}
		
		/**
		 *  will convert the objects in the argument to VizAlignTarget
		 * 
		 * the elements of the paramater may be an Array, DisplayObject or VizAlignTarget. This is a recursive function.
		 * If you pass an array as an element to the array, this function assumes you are attempting to group objects
		 * and will recursively call this function. Thus, if you pass an array as an element to the paramater array, the 
		 * same element requirements apply.
		 * 
		 * @param	targets
		 * @return array of VizAlignTarget
		 */
		static public function convertToVizAlignTargets(targets:Array):Array/*VizAlignTarget*/ {
			var vizAlignTargets:Array/*VizAlignTarget*/ = [];
			for (var i:int = 0; i < targets.length; i++) {
				var item:* = targets[i];
				switch (true) {
					case item is Array:
						vizAlignTargets[i] = new VizAlignGroup(convertToVizAlignTargets(item)); break;
					case item is DisplayObject:
						vizAlignTargets[i] = new VizAlignTarget(item); break;
					case item is VizAlignTarget:
						vizAlignTargets[i] = item; break;
					default:						
						throw new Error(BAD_TARGET);
				}
			}
			return vizAlignTargets;
		}
		/**
		 * returns an array of Rectangle of the .orig property of the VizAlignTarget in the same order that 
		 * the targets are in
		 * @param	vizAlignTargets
		 * @return
		 */
		static public function getOrigBoundsFromVizAlignTargets(vizAlignTargets:Array/*VizAlignTarget*/):Array/*Rectangle*/ {
			for (var i:int = 0, bounds:Array/*Rectangle*/ = []; i < vizAlignTargets.length; i++) bounds[i] = vizAlignTargets[i].orig;
			return bounds;
		}
		/**
		 * returns an array of Rectangle of the .end property of the VizAlignTarget in the same order that 
		 * the targets are in
		 * @param	vizAlignTargets
		 * @return
		 */
		static public function getEndBoundsFromVizAlignTargets(vizAlignTargets:Array/*VizAlignTarget*/):Array/*Rectangle*/ {
			for (var i:int = 0, bounds:Array/*Rectangle*/ = []; i < vizAlignTargets.length; i++) bounds[i] = vizAlignTargets[i].end;
			return bounds;
		}
		
		/**
		 * loop through the targets. if any groups, call the .updateTargetsEnds() on that target
		 * 
		 * this function is neccessary because otherwise, the groups would have no idea when to tell their
		 * individual members to get their new values.
		 * @param	vizAlignTargets
		 */
		static public function updateGroups(vizAlignTargets:Array/*VizAlignTarget*/):void {
			for each (var t:VizAlignTarget in vizAlignTargets) 
				if (t is VizAlignGroup) (t as VizAlignGroup).updateTargetsEnds();
		}
	}
}