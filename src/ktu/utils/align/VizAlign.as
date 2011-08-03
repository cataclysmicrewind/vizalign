

package ktu.utils.align {

	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * 
	 * 
	 * 	TODO:
	 * 
	 * 
	 * 		Method Manifests
	 * 			How can I make it so I only compile the align functions I use
	 * 			How can I forcibly include all methods?
	 * 
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
		
		public static const BAD_TARGET		:String = "VizAlign : Target must be a DisplayObject/VizAlignTarget";
		
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
			
			var vizAlignTargets:Array/*VizAlignTarget*/ = convertToVizAlignTargets(targets);				// convert all targets to VizAlignTarget
			var targetEndBounds:Array/*Rectangle*/ = getBoundsFromVizAlignTargets(vizAlignTargets);			// get all rectangles to move
			if (ignoreOrigin) applyOriginOffsets(vizAlignTargets);											// if ignoreOrigin, offset the end bounds so we are actually aligning the visual rectangle of the target
			
			var length:uint = vizAlignments.length;															// get length of vizAlignments for optimized looping
			for (var i:int = 0; i < length; i++) {															// for each vizAlignment
				vizAlignments[i].align (targetEndBounds);													//		have the VizAlignment align the rectnalges
			}																								// end loop
			updateGroups(vizAlignTargets);
			if (ignoreOrigin) removeOriginOffsets(vizAlignTargets);											// if ignoreOrigin, remove the offset, so the actual target ends up in the right place
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
		
		static public function convertToVizAlignTargets(targets:Array):Array/*VizAlignTarget*/ {
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
					default:						
						throw new Error(BAD_TARGET);
						break;
				}
			}
			return vizAlignTargets;
		}
		static private function getBoundsFromVizAlignTargets(vizAlignTargets:Array/*VizAlignTarget*/):Array/*Rectangle*/ {
			var bounds:Array/*Rectangle*/ = [];
			for (var i:int = 0; i < vizAlignTargets.length; i++) bounds[i] = vizAlignTargets[i].end;
			return bounds;
		}
		
		
		static private function updateGroups(vizAlignTargets:Array/*VizAlignTarget*/):void {
			for each (var t:VizAlignTarget in vizAlignTargets) {
				if (t is VizAlignGroup) {
					t.updateTargetsEnds();
				}
			}
		}
		
		
		/**
		 * 
		 * 	SHOULDN'T WORK WITH PRIMITIVES!
		 * 
		 * @param	array
		 * @return
		 */
		public static function preserveOrderWithDictionary(array:Array/*Object*/):Dictionary {
			var dic:Dictionary = new Dictionary(true);
			for (var i:int = 0; i < array.length; i++) {
				dic[array[i]] = i;
			}
			return dic;
		}
		
		/**
		 * 
		 * 	applys original order to array 
		 * 	use preserveOrderWithDictionary Dicitonary with this function
		 * 
		 * @param	array
		 * @param	orderedDic
		 * @return
		 */
		public static function reorderArray (array:Array/*Object*/, orderedDic:Dictionary):void {
			var orderedArray:Array = [];
			for (var i:int = 0; i < array.length; i++) {
				var item:* = array[i];
				var index:int = orderedDic[item];
				orderedArray[index] = item;
			}
			for (i = 0; i < orderedArray.length; i++) {
				array[i] = orderedArray[i];
			}
		}
	}
}