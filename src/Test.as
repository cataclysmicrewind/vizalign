

package  {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import ktu.display.align.VizAlign;
	import ktu.display.align.VizAlignment;
	import ktu.display.align.VizAlignTarget;
	/**
	 * ...
	 * @author Keelan
	 */
	public class Test extends Sprite {
		
		private var _red:Sprite;
		private var _green:Sprite;
		private var _blue:Sprite;
		private var _purple:Sprite;
		private var _orange:Sprite;
		
		private var _alignments:Array = [ ];
		private var _reset:Boolean = false;
		private var _lastResults:Array;
		
		
		public function Test() {
			init();
		}
		
		private function init():void {
			//add to stage. Setup alignments
			drawGrid();
			createTargets();
			setupAlignments();
			addEventListener(MouseEvent.CLICK, onStageClick);
		}
		
		private function setupAlignments():void {
			var obj:Object = {
				targets: [_red, _blue, _green, _purple, _orange],
				alignments: [new VizAlignment(VizAlign.LEFT, this)],
				truePixel:true,
				stage:stage
			}
			_alignments.push(obj);
			obj = {
				targets: [_red, _blue, _green, _purple, _orange],
				alignments: [new VizAlignment(VizAlign.RIGHT, this)],
				truePixel:true,
				stage:stage
			}
			_alignments.push(obj);
			var obj:Object = {
				targets: [_red, _blue, _green, _purple, _orange],
				alignments: [new VizAlignment(VizAlign.TOP, this)],
				truePixel:true,
				stage:stage
			}
			_alignments.push(obj);
			var obj:Object = {
				targets: [_red, _blue, _green, _purple, _orange],
				alignments: [new VizAlignment(VizAlign.BOTTOM, this)],
				truePixel:true,
				stage:stage
			}
			_alignments.push(obj);
		}
		
		
		private function onStageClick(e:MouseEvent):void {
			if (_reset) {
				resetTargets();
			} else {
				var next:Object = _alignments.shift();
				_lastResults = VizAlign.align(next.targets, next.alignments, next.truePixel, next.stage);
			}
			_reset = !_reset;
		}
		
		private function resetTargets():void{
			for (var i:int = 0; i < _lastResults.length; i++) {
				var item:VizAlignTarget = _lastResults[i];
				item.applyOrig();
			}
		}
		
		
		
		
		private function drawGrid():void{
			graphics.lineStyle(.1, 0x666666);
			var w:int = stage.stageHeight / 10 + 1;
			for (var i:int = 0; i < w; i++) {
				graphics.moveTo (0, i * 10);
				graphics.lineTo (stage.stageWidth, i * 10);
			}
			var h:int = stage.stage.stageWidth / 10 + 1;
			for (i = 0; i < h; i++) {
				graphics.moveTo (i * 10, 0);
				graphics.lineTo (i * 10, stage.stageHeight);
			}
		}
		
		private function createTargets():void{
			_red = new Sprite();
			drawBox (_red, 0xFF0000, 70, 30);
			positionRandomly(_red);
			addChild(_red);
			_green = new Sprite();
			drawBox (_green, 0x00FF00, 40, 40);
			positionRandomly(_green);
			addChild(_green);
			_blue = new Sprite();
			drawBox (_blue, 0x0000FF, 30, 20);
			positionRandomly(_blue);
			addChild(_blue);
			_purple = new Sprite();
			drawBox (_purple, 0xCCCC00, 10, 30);
			positionRandomly(_purple);
			addChild(_purple);
			_orange = new Sprite();
			drawBox (_orange, 0xFF44CC, 70, 30);
			positionRandomly(_orange);
			addChild(_orange);
		}
		
		private function positionRandomly(box:Sprite):void{
			var randX:int = Math.random() * (stage.stageWidth - box.width);
			var randY:int = Math.random() * (stage.stageHeight - box.height);
			box.x = Math.round(randX/10)*10;
			box.y = Math.round(randY/10)*10;
		}
		
		private function drawBox(box:Sprite, color:int, width:int, height:int):void{
			box.graphics.beginFill(color);
			box.graphics.drawRect(0, 0, width, height);
		}
		
		
		
	}

}