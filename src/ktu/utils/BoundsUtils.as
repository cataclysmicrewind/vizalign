package ktu.utils {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Ktu
	 */
	public class BoundsUtils {
		
		
		public static function getBounds (target:*, targetCoordinateSpace:DisplayObject = null):Rectangle {
			switch (true) {
				case target is Rectangle:
					return target;
				case target is Stage:
					return StageUtils.getStageBounds(target);
				case target is DisplayObject:
					return DisplayObject(target).getBounds(targetCoordinateSpace);
				default:
					return null;
			}
		}
		/*
		*
		*************************
		* 						*
		*        Find: x        *
		* 						*
		*************************
		*/
		public static function getLeftEdge (bounds:Rectangle):Number {
			return bounds.left;
		}
		public static function getCenterX (bounds:Rectangle):Number {
			return bounds.left + (bounds.width / 2);
		}
		public static function getRightEdge (bounds:Rectangle):Number {
			return bounds.right;
		}
		public static function getWidth (bounds:Rectangle):Number {
			return bounds.width;
		}
		public static function getTopEdge (bounds:Rectangle):Number {
			return bounds.top;
		}
		public static function getCenterY (bounds:Rectangle):Number {
			return bounds.top + (bounds.height / 2);
		}
		public static function getBottomEdge (bounds:Rectangle):Number {
			return bounds.bottom;
		}
		public static function getHeight (bounds:Rectangle):Number {
			return bounds.height;
		}
	}
}