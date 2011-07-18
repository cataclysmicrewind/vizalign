package ktu.utils.align {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	public class VizAlignTarget {
		
		private var _target:DisplayObject;
		private var _originOffset:Point;
		
		private var _orig:Rectangle = new Rectangle ( ) ;
		private var _end:Rectangle = new Rectangle ( ) ;
		
		
		
		public function get target ( ) :DisplayObject { return _target; }
		public function get originOffset():Point { return _originOffset; }
		public function get orig ( ) :Rectangle { return _orig; }
		public function get end ( ) :Rectangle { return _end; }
		
		public function VizAlignTarget ( target:DisplayObject) :void {
			_target = target;
			_orig.x 		= _end.x 		= target.x;
			_orig.y 		= _end.y 		= target.y;
			_orig.width 	= _end.width 	= target.width;
			_orig.height 	= _end.height 	= target.height;
			
			_originOffset = new Point(target.getBounds(target).x, target.getBounds(target).y);
		}
		
		public function applyOrigBounds ( ) :void {
			_target.x 		= _orig.x;
			_target.y 		= _orig.y;
			_target.width 	= _orig.width;
			_target.height 	= _orig.height;
		}
		
		public function applyEndBounds ( ) :void {
			_target.x 		= _end.x;
			_target.y 		= _end.y;
			_target.width 	= _end.width;
			_target.height 	= _end.height;
		}
		public function applyOriginOffestToEnd():void {
			_end.x -= _originOffset.x;
			_end.y -= _originOffset.y;
		}
		public function removeOriginOffsetToEnd():void {
			_end.x += _originOffset.x;
			_end.y += _originOffset.y;
		}
		/**
		 * 
		 * 
		 * 
		 */
		public function clone ( target:DisplayObject = null ) :VizAlignTarget{
			var ao:VizAlignTarget = new VizAlignTarget ((target) ? target : _target);
			ao.orig.x = _orig.x;
			ao.orig.y = _orig.y;
			ao.orig.width = _orig.width;
			ao.orig.height = _orig.height;
			
			ao.end.x = _end.x;
			ao.end.y = _end.y;
			ao.end.width = _end.width;
			ao.end.height = _end.height;
			
			return ao;
		}
		
		/** @private */
		public function toString ( ) :String {
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