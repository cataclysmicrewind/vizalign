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
package  {

	import flash.display.Sprite;
	import ktu.utils.align.aligners.CenterAligner;
	import ktu.utils.align.VizAlign;
	import ktu.utils.align.VizAlignment;
	
	/**
	 * 	compiling this class will give you a comparison about how large an empty swf is and one with VizAlign in it
	 * @author ktu
	 */
	public class Empty extends Sprite {
		
		public function Empty() {
			var p:VizAlignment = new VizAlignment();
			p.rectangleAligner = new CenterAligner();
			p.targetCoordinateSpace = stage;
			
			var tcs:RectangleSprite = new RectangleSprite(stage, 0, 0, 300, 300, 0xAACCFF);
            //VizAlign.align([tcs], [new VizAlignment (new CenterAligner(), stage)], true, true, true);
            VizAlign.align([tcs], [p], true, true, true);
            
            var greenGuy:RectangleSprite = new RectangleSprite(stage   ,  10,  10, 100, 100, 0x00FF00);
            var brownGuy:RectangleSprite = new RectangleSprite(greenGuy, 110, 110,  10,  50, 0x623131);
			
            VizAlign.align ([brownGuy, greenGuy], [new VizAlignment (new CenterAligner(), tcs)], true, true, true);
		}
		
	}

}
// simple class to remove boilerplate from main function.
import flash.display.Sprite;
import flash.display.DisplayObjectContainer;
class RectangleSprite extends Sprite {
    public function RectangleSprite(parent:DisplayObjectContainer, x:int, y:int, w:int, h:int, color:uint) {
        graphics.beginFill(color);
        graphics.drawRect(0, 0, w, h);
        this.x = x; this.y = y;
        parent.addChild(this);
    }
}