package  {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import ktu.utils.align.VizAlign;
	/**
	 * ...
	 * @author Ktu
	 */
	public class OriginOffsetTest extends Sprite{
		
		public function OriginOffsetTest() {
			VizAlign.pixelHinting = true;
			
			var sp:Sprite = new Sprite();
			sp.x = sp.y = 10;
			var g:Graphics = sp.graphics;
			g.beginFill(0);
			g.drawRect(0, 0, 100, 100);
			g.endFill();
			
			
			var container:Sprite = new Sprite();
			container.addChild(sp);
			
			addChild(container);
			trace("fuk you");
			trace(container.transform.pixelBounds);
			trace(container.getBounds(container));
			trace("ok");
		}
	}
}