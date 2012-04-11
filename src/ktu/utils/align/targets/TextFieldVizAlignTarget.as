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
    import flash.geom.Rectangle;
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
	public class TextFieldVizAlignTarget extends VizAlignTarget {
		
		
		
		//	instead of using the bounds of the textfield, we use textWidth, textHeight
		public var useTextBounds:Boolean = false;
		
		//	ignore the height of the last descent when doing calculations
		public var ignoreLastDescent:Boolean = false;
		
		//	instead of changing width and height, change scaleX and scaleY so text looks the same
		public var modifyScale:Boolean = false;
		
		
		
		/**
		 * no math needed here, the origin is always 0,0
		 */
		override public function set ignoreOriginOffset(value:Boolean):void {
			_ignoreOriginOffset = value;
		}
		
		/**
		 * pass that shit along!
		 * @param	target
		 */
		public function TextFieldVizAlignTarget(target:*) {
            _badTargetMessage = "TextFieldVizAlignTarget : target must be a TextField";
			super(target);
		}
		
		
		/**
		 * there are a number of ways to treat a textField
         * 
         * 
		 * @param	target
		 * @return
		 */
		override protected function getTargetBounds(target):Rectangle {
			var tf:TextField = target as TextField;
			var bounds:Rectangle;
			
			
			return bounds;
		}
		
		/**
		 * stage origin is always 0,0
		 * @param	target
		 * @return
		 */
		override protected function getOriginOffset(target):Point {
			return new Point();
		}
		
        /**
         *  
         * 
         * @param	target
         * @param	rect
         */
		override protected function setTargetBounds(target:Object, rect:Rectangle):void {
			// empty on purpose
		}
		
		/**
		 * override this to check if the target you were given is cool.
		 * @param	duck
		 * @return
		 */
		override protected function isAcceptableType(duck:Object):Boolean {
			if (duck is TextField)
				return true;
			return false;
		}
	}
}