package ktu.utils {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Ktu
	 */
	public class DisplayObjectUtils {
		/** 
		 * A reference to the Stage, this must be set for this class to function.
		 * Static classes have issues with Stage references, as static methods cannot create objects that can get a reference to the stage. <br/>
		 * If this is NOT set, VizAlign package will not work.
		 */
		public static var stageRef:Stage;
		/*
		*
		*************************
		* 						*
		*        Find: x        *
		* 						*
		*************************
		*/
		/**
		 *	returns the center x pixel value of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the center x pixel of according to the Stage
		 * @return			returns the center x of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getCenterX (item:DisplayObject):Number {
			var bounds:Rectangle = item.getBounds(stageRef);
			return bounds.left + (bounds.width / 2);
		}
		/**
		 *  returns the difference between the left edge of the item, and the origin of the item
		 *
		 *  This is a significant method when doing alignment. If the origin of a DisplayObject is not 0,0 the x or y
		 *  values of the object do not reflect the edge of the pixels in the DisplayObject.
		 *
		 * @param	item	item you wish to retrieve the difference between the left edge and origin, according to the Stage
		 * @return			returns the difference of the left edge of the item paramater and its origin.
		 */
		public static function getOriginX (item:DisplayObject):Number {
			return item.x - item.getBounds(stageRef).left;
		}
		/*
		*
		*************************
		* 						*
		*        Find: y        *
		* 						*
		*************************
		*/
		/**
		 *	returns the center y pixel value of the passed in DisplayObject in relation to the Stage
		 *
		 * @param	item	item you wish to retrieve the center y pixel of according to the Stage
		 * @return			returns the center y of the item paramater according to DisplayObject.getBounds(Stage)
		 */
		public static function getCenterY (item:DisplayObject):Number {
			var bounds:Rectangle = item.getBounds(stageRef);
			return bounds.top + (bounds.height / 2);
		}
		/**
		 *  returns the difference between the top edge of the item, and the origin of the item
		 *
		 *  This is a significant method when doing alignment. If the origin of a DisplayObject is not 0,0 the x or y
		 *  values of the object do not reflect the edge of the pixels in the DisplayObject.
		 *
		 * @param	item	item you wish to retrieve the difference between the top edge and origin, according to the Stage
		 * @return			returns the difference of the top edge of the item paramater and its origin.
		 */
		public static function getOriginY (item:DisplayObject):Number {
			return item.y - item.getBounds(stageRef).top;
		}
		
		
		
		public static function getBoundsArray(array:Array/* of DisplayObject*/, targetCoordinateSpace:DisplayObject):Array/* of Rectangle */ {
			var boundsArray:Array = [];
			for (var i:int = 0; i < array.length; i++) {
				var item:DisplayObject = array[i];
				boundsArray[i] = item.getBounds(targetCoordinateSpace);
			}
			return boundsArray;
		}
		public static function offsetNewBoundsByOrigin (targets:Array/* of DisplayObject */, newBounds:Array/* of Rectangle*/, stage:Stage):void {
			for (var i:int = 0; i < targets.length; i++) {
				var target:DisplayObject = targets[i];
				var targetBounds:Rectangle = target.getBounds(stage);
				var bounds:Rectangle = newBounds[i];
				bounds.x += target.x - targetBounds.x;
				bounds.y += target.y - targetBounds.y;
			}
		}
		public static function applyNewBounds (targets:Array/* of DisplayObject */, newBounds:Array/* of Rectangle */):void {
			for (var i:int = 0; i < targets.length; i++) {
				var target:DisplayObject = targets[i];
				var bounds:Rectangle = newBounds[i];
				target.x = bounds.x
				target.y = bounds.y;
				target.width = bounds.width;
				target.height = bounds.height;
			}
		}
	}
}