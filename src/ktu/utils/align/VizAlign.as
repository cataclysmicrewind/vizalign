/* MIT License

Copyright (c) 2012 ktu <ktu@cataclysmicrewind.com>

Permission is hereby granted, free of charge, to any person obtaining a 
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
THEAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN THE SOFTWARE.

*/
package ktu.utils.align {
    
    import flash.display.Stage;
    import flash.utils.getQualifiedClassName;
    import ktu.utils.align.targets.StageVizAlignTarget;
    import ktu.utils.align.targets.VizAlignGroup;
    import ktu.utils.align.targets.VizAlignTarget;

	/**
	 * 
	 * the VizAlign class is simple api for visually aligning DisplayObject.
	 * 
	 * like the align panel in the flash ide, vizalign will align objects. however, with vizalign
	 * you are not limited to just the targets themselves or the stage. the object in which you align
	 * the targets to only has to quack like a Rectangle (x,y,width,height) including the targets themselves. 
	 * 
	 * 
	 *  NOTE: almost all the methods other than align() are utilities that align() uses. they are made public in case you want to utilize their
	 * functionality. more often than not you will not need to touch any of those methods.
	 * 
	 * 
	 * TODO: add more explanation to what this does and how it is used.
	 * TODO: add in nuances and things to pay attention to when aligning
	 * TODO: add examples
	 * 
	 * 
	 */
	public class VizAlign {
		
        
        static private var registeredClasses:Array = [ [Stage, StageVizAlignTarget] ];
        static private var registeredBaseClasses:Array = [ ];
        static public function registerClass (targetClass:Class, vizAlignTargetClass:Class, isBase:Boolean = false):void {
            if (isBase) registeredBaseClasses.push( [targetClass, vizAlignTargetClass] );
            else registeredClasses.push( [targetClass, vizAlignTargetClass] );
        }
        static public function deregisterClass (targetClass:Class, isBase:Boolean = false):void {
            var ar:Array = isBase ? registeredBaseClasses : registeredClasses;
            for (var i:int = 0; i < ar.length; i++) {
                if (ar[i][0] == targetClass) {
                    ar.splice(i, 1);
                    break;
                }
            }
        }
        
		/**
		 *  aligns the specified targets how the vizAlignments specify.
		 * 
		 * this function is the main point of entry when using VizAlign. this is the function that will do _all_ the work for you. 
		 * this is the only function in this library that will handle origins/rotation points completely for you. all you must do is specify the flag ignoreOrigin.
		 * 
		 * 
		 * TODO: add example
		 * 
		 * @param	targets			an array of targets to be aligned. no matter the state that they are sent in, 
         *                          they will all be converted to VizAlignTarget accordingly. 
		 * @param	vizAlignments	an array of VizAlignment that specify how you want the targets to be aligned. 
		 * @param	applyResults	whether you want VizAlign to actually move the targets or just calculate the end position
		 * @param	ignoreOrigin	whether you want VizAlign to ignore the origin offset.
		 * @param	pixelHinting	whether VizAlign should round the end result before finishing.
		 * 
		 * @return
		 */
		static public function align (targets:Array, vizAlignments:Array/*VizAlignment*/, ignoreOrigin:Boolean = false, applyResults:Boolean = false, pixelHinting:Boolean = false):Array/*VizAlignTarget*/ {
			if ( !targets.length || !vizAlignments.length )	return [];									// if no targets or vizAlignments, return nothing. idiot
			targets = targets.concat();																	// copy array so we have new one (same elements, but different array reference)
			
			var vizAlignTargets:Array/*VizAlignTarget*/ = convertToVizAlignTargets(targets);			// convert all targets to VizAlignTarget (@see for which object types are acceptable)
			if (ignoreOrigin) ignoreOriginOffsets(vizAlignTargets, true);								// if ignoreOrigin, offset the end bounds so we are actually aligning the visual rectangle of the target
			var targetEndBounds:Array/*Rectangle*/ = getEndBoundsFromVizAlignTargets(vizAlignTargets);	// get all rectangles to move (the core of VizAlign is based solely on Rectangle)
			
			var length:uint = vizAlignments.length;														// get length of vizAlignments for optimized looping
			for (var i:int = 0; i < length; i++) {														// for each vizAlignment
				var vizAlignment:VizAlignment = vizAlignments[i];										//		get reference to VizAlignment
				if (vizAlignment) vizAlignment.align (targetEndBounds);									//		if (have alignment) align the rectanlges
			}																							// end loop
			
			updateGroups(vizAlignTargets);																// update groups if we have them
			if (ignoreOrigin) ignoreOriginOffsets(vizAlignTargets, false);								// if ignoreOrigin, remove the offset, so the actual target ends up in the right place
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
		static public function ignoreOriginOffsets (vizAlignTargets:Array/*VizAlignTarget*/, ignoreOrigins:Boolean = true ):void {
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
                vizAlignTargets[i] = convertToVizAlignTarget(targets[i]);
            }
            return vizAlignTargets;
		}
        /**
         * converts one target into a vizAlignTarget
         * @param	target
         * @return
         */
        static public function convertToVizAlignTarget(target:*):VizAlignTarget {
            // if already a VizAlignTarget, return it
            if (target is VizAlignTarget) 
                return target as VizAlignTarget;
            // if its an Array, make a group
            if (target is Array) 
                return new VizAlignGroup(convertToVizAlignTargets(target));
            // if it matches any registered classes, send it up!
            for (var i:int = 0; i < registeredClasses.length; i++) {
                var registeredClass:Array = registeredClasses[i];
                var targetClass:String = getQualifiedClassName(target);
                var rClass:String = getQualifiedClassName(registeredClass[0]);
                if (targetClass == rClass)
                    return new registeredClass[1](target);
            }
            // if it matches any base classes, send it up!
            for (i = 0; i < registeredBaseClasses.length; i++) {
                var registeredBaseClass:Array = registeredBaseClasses[i];
                if (target is registeredBaseClass[0]) {
                    return new registeredBaseClass[1](target);
                }
            }
            // fine, just try it as a normal VizAlignTarget
            return new VizAlignTarget(target);
        }
	}
}