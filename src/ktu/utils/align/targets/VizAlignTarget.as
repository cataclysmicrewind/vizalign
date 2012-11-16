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
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * The VizAlignTarget class represents a target for use in VizAlign.
	 * 
	 * a VizAlignTarget handles many special aspects of aligning, such as retaining the original position
	 * of the target before alignment, the resulting position after alignment, and is capable of compensating
	 * for any wacky origins (or rotation point) of the given DisplayObject.
	 * 
	 * the target must be a DisplayObject (that's the point of VizAlign!). 
	 * 
	 * in normal routine, you will not need to change any flags in this object. most will be taken care of in the VizAlign.align parameters.
	 * your biggest concern is if you wish to animate. to animate, the applyResults flag on VizAlign.align must be false. You then
	 * take the .end property of each target for the animation code. really simple.
	 * 
	 */
	public class VizAlignTarget {
		
		/**
		 * the target
		 */
		protected var _target:*;
		/**
		 * position before alignment
		 */
		protected var _orig:Rectangle;
		/**
		 * position after alignment
		 */
		protected var _end:Rectangle;
		/**
		 * the origin location in relation to the top left pixel of the target
		 */
		protected var _originOffset:Point;
		/**
		 * whether to ignore the origin offest or not
		 */
		protected var _ignoreOriginOffset:Boolean = false;
        
        /**
         * error message to be overridden by each subclass so someone has a bit of help
         */
        protected var _badTargetMessage:String = "VizAlignTarget: target must quack like a rectangle or be DisplayObject";
		/**
		 * the DisplayObject that will be aligned
		 */
		public function get target():* { return _target; }
		/** @private */
		public function set target(value:*):void {
            if (isAcceptableType(value)) {
                _target = value;
                init();
            } else throw new Error (_badTargetMessage);
		}
		/**
		 * the rectangle before alignment
		 * keeping track of this is important mostly for animating and even undo
		 */
		public function get orig():Rectangle { return _orig; }
		/**
		 * the resulting rectangle after alignment
		 * when the object is first created this value is the same as the orig value
		 */
		public function get end():Rectangle { return _end; }
		/**
		 * a reference to the origin offset
		 * (how far away the top left pixel of the target is from the origin (0,0))
		 */
		public function get originOffset():Point { return _originOffset; }
		/**
		 * whether the origin point should be ignored during alignment
		 */
		public function get ignoreOriginOffset():Boolean { return _ignoreOriginOffset; }
		/** @private */
		public function set ignoreOriginOffset(value:Boolean):void {
            if (_ignoreOriginOffset == value) return;
			_ignoreOriginOffset = value;
			var s:Point = scale;
			var negate:int = value ? 1 : -1;
			var dx:Number = _originOffset.x * s.x * negate;
			var dy:Number = _originOffset.y * s.y * negate;
			_end.x += dx; _end.y += dy;
			_orig.x += dx; _orig.y += dy;
		}
		/**
		 * get the scale delta of the object.
		 * 
		 * this is super crutial for ignoring origin offests. 
		 */
		public function get scale():Point {
            var s:Point = new Point();
            s.x = (_end.width / _orig.width);
            s.y = (_end.height / _orig.height);
            if (_target is DisplayObject) {
                s.x *= _target.scaleX;
                s.y *= _target.scaleY;
            }
			return s;
		}
		
		
		/**
		 * constructor
		 * @param	target  the object for alignment 
         * @param   ignoreOriginOffset ignore the origin offset?
		 */
		public function VizAlignTarget(target:* = null, ignoreOriginOffset:Boolean = false):void {
			this.target = target ? target : new Rectangle;
            this.ignoreOriginOffset = ignoreOriginOffset;
		}
		/**
		 * setups some of the initial values
		 * it is important that this is done in this function instead of the constructor
		 * because the VizAlignGroup class must do things differently.
		 */
		protected function init():void {
			_orig = getTargetBounds(_target);
            _end = _orig.clone();
			_originOffset = getOriginOffset(_target);
		}
		/**
		 * place the target dimensions at the .orig values
		 */
		public function applyOrigBounds():void { setTargetBounds(_target, _orig); }
		/**
		 * place the target dimensions at the .end values
		 */
		public function applyEndBounds():void { setTargetBounds (_target, _end); }
		/**
		 *  permanently round the .end values
		 */
		public function roundEndValues():void {
			_end.x = Math.round(_end.x);
			_end.y = Math.round(_end.y);
			_end.width = Math.round(_end.width);
			_end.height = Math.round(_end.height);
		}
		/** @private */
		public function toString():String {
			var str:String = "";
			str += "VizAlignTarget:\ttarget:" + _target.name + "\t";
			str += "orig: " + _orig + " ";
			str += "end: " + _end + " ";
			str += "originOffset: " + _originOffset + "\n";
			return str;
		}
        protected function getTargetBounds(target:*):Rectangle {
            return new Rectangle(target.x, target.y, target.width, target.height);
        }
        protected function getOriginOffset(target:*):Point {
            var offset:Point = new Point();
            if (target is DisplayObject) {
                var bounds:Rectangle = target.getBounds(target);
                offset.x = bounds.x;
                offset.y = bounds.y;
            }
            return offset;
        }
        /**
		 * set the target dimensions to the given rectangle
		 * @param	rect
		 */
		protected function setTargetBounds (target:Object, rect:Rectangle):void {
			target.x = rect.x;
			target.y = rect.y;
			target.width = rect.width;
			target.height = rect.height;
            
		}
        protected function isAcceptableType(duck:Object):Boolean {
            if (duck && duck.x != null && duck.y != null && duck.width != null && duck.height != null)
                return true;
            return false;
        }
	}
}