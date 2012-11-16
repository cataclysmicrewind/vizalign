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
package ktu.utils.align.targets {
	
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import ktu.utils.align.targets.VizAlignTarget;


	/**
	* 	The VizAlignGroup class represents a group of VizAlignTarget for alignment.
	* 
	* 	using a group allows you to preserve relative positioning for multiple targets
	* when doing alignment. this class acts much like its base but has one key difference, the 
	* updateGroupEnds(). this function is required so as to inform the targets of this group of the new alignment.
	* 
	* 	this is the same functionality as using ctrl+g in the flash ide and doing alignment on the group
	* 	
	* @author ktu
	*/
	public class VizAlignGroup extends VizAlignTarget {
		/**
		 * array for the targets of this group
		 */
		protected var _targets:Array/*VizAlignTarget*/;
		/**
		 * array of targets for this group. cannot change once set in constructor
		 */
		public function get targets():Array/*VizAlignTarget*/ { return _targets; }
		
		/**
		 * whether the origin point should be ignored during alignment
		 * 
		 * this is different than its base class as it must loop through each target
		 * in the group, and combine their bounds to create the propery group bounds
		 */
		override public function set ignoreOriginOffset(value:Boolean):void {
			_ignoreOriginOffset = value;										// 	store the value
			_targets[0].ignoreOriginOffset = value;								//	tell the first target of the new value
			var groupOrig:Rectangle = targets[0].orig.clone();					// 	Rectangle for the group .orig property (must rect.union, don't want first one to have 0,0,0,0)
			var groupEnd:Rectangle = _targets[0].end.clone();					//	Rectangle for the group .end property (must rect.union, don't want first one to have 0,0,0,0)
			for (var i:int = 1; i < _targets.length; i++) {						// 	loop (each target - the first one) 
				var t:VizAlignTarget = _targets[i];								//		grab target
				t.ignoreOriginOffset = value;									//		tell target of new value
				groupOrig = groupOrig.union(t.orig);							//		union each target orig with new group orig
				groupEnd = groupEnd.union(t.end);								//		union each target end with new group end
			}																	//	end loop
			_orig = groupOrig;													//	store new orig
			_end = groupEnd;													// 	store new end
		}
		/**
		 * constructor
		 * 
		 * this acts differently than its base class, in that it stores the array of targets
		 * and sends an empty Sprite to the base class. this empty Sprite is ignored
		 * @param	targets
		 */
		public function VizAlignGroup(targets:Array, ignoreOriginOffest:Boolean = false) {
			_targets = targets;
			super(new Sprite(), ignoreOriginOffset);
		}
		/**
		 * called from the base class constructor, it sets up the orig and end rectangles
		 */
		//override protected function init ():void {
			
			//_orig = groupEnd.clone();
			//_end = groupEnd;
		//}
		/**
		 * place each target of the group at its .orig property
		 */
		override public function applyOrigBounds():void {
			for each (var t:VizAlignTarget in _targets) t.applyOrigBounds();
		}
		/**
		 * place each target of the group at its .end property
		 */
		override public function applyEndBounds():void {
            updateTargetsEnds();
			for each (var t:VizAlignTarget in _targets) t.applyEndBounds();
		}
        override public function roundEndValues():void {
            super.roundEndValues();
            for each (var t:VizAlignTarget in _targets)
                t.roundEndValues();
        }
		/**
		 * 	update all of the target end rectangles to account for the end rectangle of the group.
		 * 
		 * this is important, because as you change the end rectangle of the group, you must somehow
		 * at some point, update the end values of each target in this group
		 */
		public function updateTargetsEnds ():void {
			for each (var t:VizAlignTarget in _targets) {									// 	loop (each target in me)
				if (t is VizAlignGroup) 													// 		if (target is VizAlignGroup)
					(t as VizAlignGroup).updateTargetsEnds();								//			tell group to update
				else {																		//		else
					var s:Point = scale;													//  		grab the scale delta
					var offset:Point = new Point(t.orig.x - _orig.x, t.orig.y - _orig.y);	// 			grab offset from group origin
					t.end.x = _end.x + (offset.x * s.x);									//			
					t.end.y = _end.y + (offset.y * s.y);									//			
					t.end.width = t.orig.width * s.x;										//
					t.end.height = t.orig.height * s.y;										//
				}																			// 		end if
			}																				//	end loop
		}
		
        /** @private */
        override public function toString ():String {
            var str:String = "VizAlignGroup::" + _target.name + "\n";
            for (var i:int = 0; i < _targets.length; i++) 
                str += "\t" + _target.toString() + ((i == _targets.length-1) ? "" : "\n");
            return str;
        }
		
        
        override protected function getOriginOffset(target:*):Point {
            return new Point();
        }
        override protected function getTargetBounds(target:*):Rectangle {
            var groupEnd:Rectangle = _targets[0].end.clone();
			for (var i:int = 1; i < _targets.length; i++) 
				groupEnd = groupEnd.union((_targets[i] as VizAlignTarget).orig);
            return groupEnd;
        }
		
        override protected function setTargetBounds(target:Object, rect:Rectangle):void {
            super.setTargetBounds(target, rect);
        }
		override protected function isAcceptableType(duck:Object):Boolean {
            if (duck is Array)
                return true;
            return false;
        }
	}
}