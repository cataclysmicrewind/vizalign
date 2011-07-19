

package ktu.utils.align.methods {
	
	
	import flash.display.Sprite;
	import ktu.utils.align.AlignMethods;
	import ktu.utils.align.VizAlign;
	import ktu.utils.align.VizAlignment;
	import ktu.utils.align.VizAlignTarget;
	import org.hamcrest.assertThat;
	/**
	 * ...
	 * @author Ktu
	 */
	[TestCase]
	public class Left {
		
		[Test(description="test the left method")]
		public function simple ():void {
			
			var targets:Array = [];
			targets.push(createTarget(10, 10));
			targets.push(createTarget(10, 20));
			targets.push(createTarget(20, 10));
			targets.push(createTarget(20, 20));
			targets.push(createTarget(30, 10));
			
			var vizAlignments:Array = [];
			vizAlignments[0] = new VizAlignment(AlignMethods.left, VizAlign.TO_TARGETS);
			
			var results:Array = VizAlign.align(targets, vizAlignments, true, false);
			
			
			for (var i:int = 0; i < results.length; i ++) {
				var vTarget:VizAlignTarget = results[i];
				var origTarget:Sprite = targets[i];
				assertThat(vTarget.target, origTarget);
				assertThat(vTarget.end.x, 10);
				assertThat(vTarget.target.x, 10);
			}
			
			
			
		}
		
		private function createTarget(w:Number, h:Number):Sprite {
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(w * h);
			sprite.graphics.drawRect(0, 0, w, h);
			sprite.graphics.endFill();
			
			sprite.x = w;
			sprite.y = h;
			
			return sprite;
		}
		
	}

}