/**
 *
 *
 *
**/
package ktu.utils {
	
	public class Range {
		
		public static const BELOW	:int = -1;
		public static const IN		:int = 0;
		public static const ABOVE	:int = 1;
		
		
		private var _min		:Number;
		private var _max		:Number;
		private var _length		:Number;
		
		public function get min():Number { return _min; }
		public function set min(value:Number):void { 
			if (value > max) {
				throw new RangeError ();
			} else {
				_min = value; 
				_length = _max - _min;
			}
		}
		
		public function get max():Number { return _max; }
		public function set max(value:Number):void {
			if (value < min) {
				throw new RangeError ();
			} else {
				_max = value; 
				_length = _max - _min;
			}
		}
		
		public function get length():Number { return _length; }
		
		
		
		
		
		public function Range (min:Number = 0, max:Number = 0) {
			_min 	= min;
			_max 	= max;
			_length = max - min;
		}
		
		public function inRange (value:Number):int {
			switch (true) {
				case value < min:
					return BELOW;
				case value > max:
					return ABOVE;
				default:
					return IN;
			}
		}
		
		public function contains (range:Range):Boolean {
			if (range.min >= min && range.max <= max) return true;
			return false;
		}
		
		public function equals (range:Range):Boolean {
			if (range.min == min && range.max == max) return true;
			return false;
		}
		
		public function getRandom():Number {
			return min + int(Math.random() * (_length + 1));
		}
		public function intersect (range:Range):Range {
			var intersection:Range = new Range( (range.min < min) ? min : range.min, (range.max > max) ? max : range.max );
			if (intersection.min > intersection.max) return null;
			return intersection;
		}
		
		public function intersects (range:Range):Boolean {
			if (intersect(range) == null) return false;
			return true;
		}
		
		public function union (range:Range):Range {
			return new Range ( (range.min > min) ? min : range.min, (range.max < max) ? max : range.max );
		}
		
		
		public function toString ():String {
			var str:String = "{min: " + min + ", max:" + max + ", length:" + length + "}";
			return str;
		}
		
		
	}
}