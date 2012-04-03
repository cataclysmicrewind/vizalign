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
package {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import ktu.utils.align.aligners.CenterAligner;
	import ktu.utils.align.VizAlign;
	import ktu.utils.align.VizAlignment;
	
	/**
	 * 
	 *  This class shows you a super simple example of how targets should never be parent and child, or any ancestry. siblings only.
	 * 
	 */
    public class Gotcha extends Sprite {
		
        public function Gotcha():void {
			// create tcs for the nested targets
            var tcs:RectangleSprite = new RectangleSprite(0, 0, 300, 300, 0xAACCFF);
            addChild(tcs);
			// center it to the stage
            VizAlign.align([tcs], [new VizAlignment (new CenterAligner(), stage)], true, true, true);
            
			// create the nested targets
            var greenGuy:RectangleSprite = new RectangleSprite(10, 10, 100, 100, 0x00FF00);
            var brownGuy:RectangleSprite = new RectangleSprite(80, 70,  60,  50, 0x623131);
            addChild(greenGuy); // goes on the stage
            greenGuy.addChild(brownGuy); // goes in the green guy
			
			// when you click the stage, center the targets on the tcs
            stage.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
                VizAlign.align ([brownGuy, greenGuy], [new VizAlignment (new CenterAligner(), tcs)], true, true, true);
            });
        }
    }
}
// simple class to remove boilerplate from main function.
import flash.display.Sprite;
class RectangleSprite extends Sprite {
    public function RectangleSprite(x:int, y:int, w:int, h:int, color:uint) {
        graphics.beginFill(color);
        graphics.drawRect(0, 0, w, h);
        this.x = x; this.y = y;
    }
}