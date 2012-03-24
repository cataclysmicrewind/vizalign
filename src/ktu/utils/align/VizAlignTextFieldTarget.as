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
		
		static private const MUST_TEXTFIELD:String = "VizAlignTextFieldTarget : target must be of type TextField";
		
		
		//	instead of using the bounds of the textfield, we use textWidth, textHeight
		public var useTextBounds:Boolean = false;
		
		//	ignore the height of the last descent when doing calculations
		public var ignoreLastDescent:Boolean = false;
		
		//	instead of changing width and height, change scaleX and scaleY so text looks the same
		public var modifyScale:Boolean = false;
		
		
		override public function set target(value:DisplayObject):void {
			if (value is TextField)
				super.target = value;
			else throw new Error(MUST_TEXTFIELD);
		}
		
		public function VizAlignTextFieldTarget(target:TextField){
			super(target);
		}
		
	}
}