package  {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Main extends Sprite {
		
		public function Main() {
			
		}
	
		
		
		public function createTarget(bounds:Rectangle, color:uint):Sprite {
			var sp:Sprite = new Sprite ();
			sp.graphics.beginFill(color);
			sp.graphics.drawRect (0, 0, bounds.width, bounds.height);
			sp.graphics.endFill();
			sp.x = bounds.x;
			sp.y = bounds.y;
			return sp;
		}
	}

}