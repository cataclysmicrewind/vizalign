
package ktu.utils.align {
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;


	public class VizAlignTarget {

		protected var _target:DisplayObject;
		
		protected var _orig:Rectangle = new Rectangle();
		protected var _end:Rectangle = new Rectangle();
		
		protected var _originOffset:Point;
		protected var _applyOriginOffset:Boolean = false;
		
		
		
		public function get target():DisplayObject { return _target; }
		public function set target(value:DisplayObject):void {
			_target = value;
			init();
		}
		public function get orig():Rectangle { return _orig; }
		public function get end():Rectangle { return _end; }
		public function get originOffset():Point { return _originOffset; }
		public function get applyOriginOffset():Boolean { return _applyOriginOffset; }
		public function set applyOriginOffset(value:Boolean):void {
			_applyOriginOffset = value;
			var s:Point = scale;
			var negate:int = value ? 1 : -1;
			var dx:Number = _originOffset.x * s.x * negate;
			var dy:Number = _originOffset.y * s.y * negate;
			_end.x += dx; _end.y += dy;
			_orig.x += dx; _orig.y += dy;
		}
		public function get scale():Point {
			var s:Point = new Point();
			s.x = (_end.width / _orig.width) * _target.scaleX;
			s.y = (_end.height / _orig.height) * _target.scaleY;
			return s;
		}
		
		public function VizAlignTarget(target:DisplayObject = null):void {
			_target = target;
			init();
		}
		
		protected function init():void {
			_orig.x = _end.x = _target.x;
			_orig.y = _end.y = _target.y;
			_orig.width = _end.width = _target.width;
			_orig.height = _end.height = _target.height;
			
			_originOffset = new Point(_target.getBounds(_target).x, _target.getBounds(_target).y);
		}
		
		public function applyOrigBounds():void {
			setTargetBounds(_orig);
		}
		
		public function applyEndBounds():void {
			setTargetBounds (_end);
		}
		
		public function roundEndValues():void {
			_end.x = Math.round(_end.x);
			_end.y = Math.round(_end.y);
			_end.width = Math.round(_end.width);
			_end.height = Math.round(_end.height);
		}
		protected function setTargetBounds (rect:Rectangle):void {
			_target.x = rect.x;
			_target.y = rect.y;
			_target.width = rect.width;
			_target.height = rect.height;
		}
		
		/** @private */
		public function toString():String {
			var str:String = "";
			str += "VizAlignTarget:\ttarget:" + _target.name;
			str += "\t";
			str += "orig: " + _orig + " ";
			str += "end: " + _end + " ";
			str += "originOffset: " + _originOffset;
			str += "\n";
			return str;
		}
	}
}