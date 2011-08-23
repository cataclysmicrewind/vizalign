


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
			if ( !targets.length || !vizAlignments.length )	return [];										// if no targets or vizAlignments, return nothing. idiot
			targets = targets.concat();																		// copy array so we have new one (refactor when doing groups)
			
			var vizAlignTargets:Array/*VizAlignTarget*/ = convertToVizAlignTargets(targets);				// convert all targets to VizAlignTarget
			if (ignoreOrigin) setOriginOffsets(vizAlignTargets, true);											// if ignoreOrigin, offset the end bounds so we are actually aligning the visual rectangle of the target
			var targetEndBounds:Array/*Rectangle*/ = getBoundsFromVizAlignTargets(vizAlignTargets);			// get all rectangles to move
			
			var length:uint = vizAlignments.length;															// get length of vizAlignments for optimized looping
			for (var i:int = 0; i < length; i++) {															// for each vizAlignment
				vizAlignments[i].align (targetEndBounds);													//		have the VizAlignment align the rectnalges
			}																								// end loop
			
			updateGroups(vizAlignTargets);
			if (ignoreOrigin) setOriginOffsets(vizAlignTargets, false);											// if ignoreOrigin, remove the offset, so the actual target ends up in the right place
			if (pixelHinting) roundResults (vizAlignTargets);												// if pixelHinting, round the results
			if (applyResults) applyEnds(vizAlignTargets);													// if applyResults, tell all VizAlignTarget to go to end
			
			return vizAlignTargets;																			// return VizAlignTarget s
		}
		
		/**
		 * 
		 * @param	vizAlignTargets
		 */
		static public function applyEnds (vizAlignTargets:Array/*VizAlignTarget*/):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				VizAlignTarget( vizAlignTargets[i]).applyEndBounds();
			}
		}
		/**
		 * 
		 * @param	vizAlignTargets
		 */
		static public function applyOriginals (vizAlignTargets:Array/*VizAlignTarget*/):void {
			for (var i:int = 0; i < vizAlignTargets.length; i++) {
				VizAlignTarget( vizAlignTargets[i]).applyOrigBounds();
			}
		}
		/**
		 * 
		 * @param	vizAlignTargets
		 */
		static public function setOriginOffsets (vizAlignTargets:Array/*VizAlignTarget*/, ignoreOrigins:Boolean = true ):void {
			for each (var t:VizAlignTarget in vizAlignTargets) 
				t.applyOriginOffset = ignoreOrigins;
		}
		/**
		 * 
		 * @param	alignedTargetBounds
		 */
		static public function roundResults(vizAlignTargets:Array/*VizAlignTarget*/):void {
			for each (var t:VizAlignTarget in vizAlignTargets) 
				t.roundEndValues();
		}
		
		static public function convertToVizAlignTargets(targets:Array):Array/*VizAlignTarget*/ {
			var vizAlignTargets:Array/*VizAlignTarget*/ = [];
			for (var i:int = 0; i < targets.length; i++) {
				var item:* = targets[i];
				switch (true) {
					case item is Array:
						vizAlignTargets[i] = new VizAlignGroup(convertToVizAlignTargets(item));
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
		
		static public function getBoundsFromVizAlignTargets(vizAlignTargets:Array/*VizAlignTarget*/):Array/*Rectangle*/ {
			for (var i:int = 0, bounds:Array/*Rectangle*/ = []; i < vizAlignTargets.length; i++) bounds[i] = vizAlignTargets[i].end;
			return bounds;
		}
		
		
		static public function updateGroups(vizAlignTargets:Array/*VizAlignTarget*/):void {
			for each (var t:VizAlignTarget in vizAlignTargets) 
				if (t is VizAlignGroup) (t as VizAlignGroup).updateTargetsEnds();
		}
	}
}