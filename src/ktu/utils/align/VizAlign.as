

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
	 * 			Should I include option for ignoring origin on TCS... right now, I always do
	 * 
	 * 
	 * 		Method Manifests
	 * 			How can I make it so I only compile the align functions I use
	 * 			How can I forcibly include all methods?
	 * 
	 * 
	 * 		VizAlignGroup - figure out whether it should be an array of VizAlignTargets, or just DisplayObject
	 * 			scaleFromOrigin()
	 * 				x&y += offsetFromOrigin * scale
	 * 				w&h += orig w&h * scale
	 * 			override applyOriginOffset()
	 * 				x&y += originOffset * scale
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
	}
}