
package ktu.utils.align {
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;


	public class VizAlignTarget {

		protected var _target:DisplayObject;
		protected var _originOffset:Point;
		protected var _applyOriginOffset:Boolean = false;
		
		protected var _orig:Rectangle = new Rectangle();
		protected var _end:Rectangle = new Rectangle();
		
		
		public function get target():DisplayObject { return _target; }
		public function get originOffset():Point { return _originOffset; }
		public function get applyOriginOffset():Boolean { return _applyOriginOffset; }
		public function set applyOriginOffset(value:Boolean):void {
			_applyOriginOffset = value;
			var s:Point = scale;
			var d:Point = delta;
			if (value) {
				if (delta.x != 0)
					_end.x -= _originOffset.x * s.x;
				if (delta.y != 0)
					_end.y -= _originOffset.y * s.y;
				if (delta.x == 0 && delta.y == 0) {
					_end.x -= _originOffset.x * s.x;
					_end.y -= _originOffset.y * s.y;
				}
			} else {
				if (delta.x != 0)
					_end.x += _originOffset.x * s.x;
				if (delta.y != 0)
					_end.y += _originOffset.y * s.y;
				if (delta.x == 0 && delta.y == 0) {
					_end.x += _originOffset.x * s.x;
					_end.y += _originOffset.y * s.y;
				}
			}
		}
		public function get orig():Rectangle { return _orig; }
		public function get end():Rectangle { return _end; }
		public function get scale():Point {
			var s:Point = new Point();
			s.x = _end.width / _orig.width;
			s.y = _end.height / _orig.height;
			return s;
		}
		public function get delta():Point {
			var d:Point = new Point();
			d.x = _end.x - _orig.x;
			d.y = _end.y - _orig.y;
			return d;
		}
		
		
		
		public function VizAlignTarget(target:DisplayObject):void {
			_target = target;
			_orig.x = _end.x = target.x;
			_orig.y = _end.y = target.y;
			_orig.width = _end.width = target.width;
			_orig.height = _end.height = target.height;
			
			_originOffset = new Point(target.getBounds(target).x, target.getBounds(target).y);
		}
		
		public function applyOrigBounds():void {
			_target.x = _orig.x;
			_target.y = _orig.y;
			_target.width = _orig.width;
			_target.height = _orig.height;
		}
		
		public function applyEndBounds():void {
			_target.x = _end.x;
			_target.y = _end.y;
			_target.width = _end.width;
			_target.height = _end.height;
		}
		
		public function roundEndValues():void {
			_end.x = Math.round(_end.x);
			_end.y = Math.round(_end.y);
			_end.width = Math.round(_end.width);
			_end.height = Math.round(_end.height);
		}
		
		public function clone(target:DisplayObject = null):VizAlignTarget {
			var vat:VizAlignTarget = new VizAlignTarget((target) ? target : _target);
			vat.orig.x = _orig.x;
			vat.orig.y = _orig.y;
			vat.orig.width = _orig.width;
			vat.orig.height = _orig.height;
			
			vat.end.x = _end.x;
			vat.end.y = _end.y;
			vat.end.width = _end.width;
			vat.end.height = _end.height;
			
			return vat;
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