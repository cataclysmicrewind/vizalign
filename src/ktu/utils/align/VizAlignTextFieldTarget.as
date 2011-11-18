

package ktu.utils.align {
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	/**
	 * A Target specifically designed for TextField.
	 *
	 * they get special behaviour for things such as retriving the bounds,
	 * comensating for last line descent,
	 * can change scale or dim.
	 *
	 * 
	 * 
	 * this is a new feature i am working on. there are a lot of aspects of TextField
	 * that are not ideal, and such i felt it would be good to create this class
	 * which will give some options to how the TextField gets treated. maybe i should include
	 * some way of modifying the defaults, because it would be a pain in the ass to change the options.
	 * you would either have to get the array back and search for it, or create the VizAlignTextFieldTarget 
	 * yourself, change the values, then send it to VizAlign
	 * 
	 *
	 *
	 *	INTEGRATION:
	 * 		add to converToVizAlignTargets:
	 * 			case item is TextField
	 * 				vizAlignTargets[i] = new VizAlignTextFieldTarget(item); break;
	 *
	 * 	yup, thats it for integration :)
	 * 
	 * 
	 * 
	 *
	 * @author ktu
	 */
	public class VizAlignTextFieldTarget extends VizAlignTarget {
		
		
		//	instead of using the bounds of the textfield, we use textWidth, textHeight
		public var useTextBounds:Boolean = false;
		
		//	ignore the height of the last descent when doing calculations
		public var ignoreLastDescent:Boolean = false;
		
		//	instead of changing width and height, change scaleX and scaleY so text looks the same
		public var modifyScale:Boolean = false;
		
		
		override public function set target(value:DisplayObject):void {
			if (value is TextField)
				super.target = value;
		}
		
		public function VizAlignTextFieldTarget(target:TextField){
			super(target);
		}
		
	}
}