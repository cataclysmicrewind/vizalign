package ktu.utils.align.capabilities.gfx {
	import com.bit101.components.Label;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	
	public class Chain extends Sprite {
		
		[Embed(source='../../../../../../assets/link.png')]
		private var Link:Class;
		[Embed(source='../../../../../../assets/broken-link.png')]
		private var Broken:Class;
		
		public var target:String = "";
		public var id:int = 0;
		
		private var _broken:Bitmap = new Broken();
		private var _link:Bitmap = new Link();
		private var txt:Label;
		
		
		public function Chain() {
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0, 0);
			bg.graphics.drawRect(0, -2, 14, 15);
			addChild(bg);
			
			_broken.y -= 2;
			addChild(_broken);
			
			_link.y += 2;
			
			txt = new Label(this, _broken.width + 3, -4);
			
		}
		
		public function reset():void {
			id = 5;
			plusOne();
		}
		
		
		public function plusOne ():void {
			id ++;
			
			if (id == 6) {
				id = 0;
				if (_link.parent) removeChild(_link);
				addChild(_broken);
				txt.text = "";
			} else {
				if (_broken.parent) removeChild(_broken);
				addChild(_link);
				txt.text = String(id);
			}
			
		}
		
	}

}