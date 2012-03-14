/*

				DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
						Version 2, December 2004
	
	Copyright (C) 2012 ktu <ktu@cataclysmicrewind.com>
	
	Everyone is permitted to copy and distribute verbatim or modified
	copies of this license document, and changing it is allowed as long
	as the name is changed.
	
				DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
	   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
		
		0. You just DO WHAT THE FUCK YOU WANT TO.


	This program is free software. It comes without any warranty, to
	the extent permitted by applicable law. You can redistribute it
	and/or modify it under the terms of the Do What The Fuck You Want
	To Public License, Version 2, as published by Sam Hocevar. See
	http://sam.zoy.org/wtfpl/COPYING for more details.

*/
package ktu.utils.align {
	
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
		 * the target DisplayObject
		 */
		protected var _target:DisplayObject;
		/**
		 * position before alignment
		 */
		protected var _orig:Rectangle = new Rectangle();
		/**
		 * position after alignment
		 */
		protected var _end:Rectangle = new Rectangle();
		/**
		 * the origin location in relation to the top left pixel of the target
		 */
		protected var _originOffset:Point = new Point();
		/**
		 * whether to ignore the origin offest or not
		 */
		protected var _ignoreOriginOffset:Boolean = false;
		
		
		/**
		 * the DisplayObject that will be aligned
		 */
		public function get target():DisplayObject { return _target; }
		/** @private */
		public function set target(value:DisplayObject):void {
			_target = value;
			init();
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
			return new Point ((_end.width / _orig.width) * _target.scaleX, (_end.height / _orig.height) * _target.scaleY);
		}
		
		
		/**
		 * constructor
		 * @param	target
		 */
		public function VizAlignTarget(target:DisplayObject):void {
			_target = target;
			init();
		}
		/**
		 * setups some of the initial values
		 * it is important that this is done in this function instead of the constructor
		 * because the VizAlignGroup class must do things differently.
		 */
		protected function init():void {
			_orig.x = _end.x = _target.x;
			_orig.y = _end.y = _target.y;
			_orig.width = _end.width = _target.width;
			_orig.height = _end.height = _target.height;
			
			var bounds:Rectangle = _target.getBounds(_target);
			_originOffset.x = bounds.x;
			_originOffset.y = bounds.y;
		}
		/**
		 * place the target dimensions at the .orig values
		 */
		public function applyOrigBounds():void { setTargetBounds(_orig); }
		/**
		 * place the target dimensions at the .end values
		 */
		public function applyEndBounds():void { setTargetBounds (_end); }
		/**
		 * set the target dimensions to the given rectangle
		 * @param	rect
		 */
		protected function setTargetBounds (rect:Rectangle):void {
			_target.x = rect.x;
			_target.y = rect.y;
			_target.width = rect.width;
			_target.height = rect.height;
		}
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
	}
}