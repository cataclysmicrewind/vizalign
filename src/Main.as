package  {
	import com.bit101.components.CheckBox;
	import com.bit101.components.ComboBox;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.flashdynamix.motion.Tweensy;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.describeType;
	import ktu.utils.align.AlignMethods;
	import ktu.utils.align.VizAlign;
	import ktu.utils.align.VizAlignment;
	import ktu.utils.align.VizAlignTarget;
	/**
	 * ...
	 * 
	 * 		//TODO: Have VizAlign know how to work with TextFields properly
	 * 
	 * 
	 * 
	 * 
	 * 
	 * @author Ktu
	 */
	public class Main extends Sprite {
		
		private var sp1:Sprite;
		private var sp2:Sprite;
		private var sp3:TextField;
		
		private var count:int = 0;
		private var combo:ComboBox;
		private var applyResults_chk:CheckBox;
		private var ignoreOrigin_chk:CheckBox;
		private var apply:PushButton;
		private var reset:PushButton;
		private var pixelHinting_chk:CheckBox;
		private var toGrid:RadioButton;
		private var toStage:RadioButton;
		private var grid:Sprite;
		private var multi:PushButton;
		
		public function Main() {
			stage.scaleMode = "noScale";
			createQuadrents ();
			addControls();
			createTargets();
			placeTargets();
		}
		
		private function addControls():void {
			combo = new ComboBox(this, 10, 10, "Choose Alignment Method:");
			combo.width = 200;
			var alignMethodsDescription:XML = describeType(AlignMethods);
			var ar:Array = [];
			for (var i:int = 0; i < alignMethodsDescription.method.length(); i++) {
				ar.push(alignMethodsDescription.method[i].@name);
			}
			ar.sort();
			for each (var method:String in ar) {
				combo.addItem(method);
			}
			
			toGrid = new RadioButton(this, 30, combo.y + combo.height + 10, "to the grid");
			toStage = new RadioButton(this, toGrid.x, toGrid.y + toGrid.height + 10, "to the stage", true);
			
			applyResults_chk = new CheckBox(this, combo.x + combo.width + 10, 14, "applyResults?");
			ignoreOrigin_chk = new CheckBox(this, applyResults_chk.x, applyResults_chk.y + applyResults_chk.height + 10, "ignoreOrigin?");
			pixelHinting_chk = new CheckBox(this, ignoreOrigin_chk.x, ignoreOrigin_chk.y + ignoreOrigin_chk.height + 10, "pixelHinting?");
			apply = new PushButton(this, ignoreOrigin_chk.x + ignoreOrigin_chk.width + 10, 10, "Apply", onApply);
			reset = new PushButton(this, apply.x, apply.y + apply.height + 10, "Reset", onReset);
			multi = new PushButton(this, reset.x + reset.width + 10, 10, "Multi", onMulti);
		}
		
		private function onMulti(e:Event):void {
			// apply a multi version of the shit
			var targets:Array = [sp1, sp2, sp3];
			var vizAlignments:Array = [];
			vizAlignments[0] = new VizAlignment(AlignMethods.left, grid);
			vizAlignments[1] = new VizAlignment(AlignMethods.bottom, grid);
			var results:Array = VizAlign.align(targets, vizAlignments, false, true);
			trace(results);
			for (var i:int = 0; i < results.length; i++) {
				var vat:VizAlignTarget = results[i];
				var to:Object = { };
				to.x = vat.end.x;
				to.y = vat.end.y;
				to.width = vat.end.width;
				to.height = vat.end.height;
				Tweensy.to(vat.target, to, .3);
			}
		}
		
		private function createQuadrents():void {
			grid = new Sprite ();
			var g:Graphics = grid.graphics;
			var h:int = 200;
			var w:int = 200;
			var hgap:int = 10;
			var vgap:int = 10;
			
			//draw white bg
			g.beginFill(0xFFFFFF);
			g.drawRect( -.5, -.5, w, h);
			
			// draw grid
			g.lineStyle(1);
			for (var i:int = 0; i < w / hgap+1; i++) {	//columns
				g.moveTo(i * hgap, 0);
				g.lineTo(i * hgap, h);
			}
			for (i = 0; i < h / hgap+1; i++) {	//columns
				g.moveTo(0, i * hgap);
				g.lineTo(w, i * hgap);
			}
			VizAlign.align([grid], [new VizAlignment(AlignMethods.center, stage)], true, true);
			addChild(grid);
			
			grid.addEventListener(MouseEvent.MOUSE_DOWN, dragSomething);
		}
		
		
		private function createTargets():void {
			// make a few sprites on the stage
			sp1 = new Sprite ();
			sp1.graphics.beginFill(0x395768, .7);
			sp1.graphics.drawRect(0, 0, 50, 150);
			addChild(sp1);
			
			sp2 = new Sprite ();
			sp2.graphics.beginFill(0x449766, .7);
			sp2.graphics.drawRect(-100, 0, 100, 100);
			addChild(sp2);
			
			sp3 = new TextField();
			sp3.width = 150;
			sp3.height = 50;
			sp3.text = "I hate textfield placement";
			sp3.border = true;
			sp3.background = true;
			addChild(sp3);
		}
		private function placeTargets():void {
			sp1.x = sp1.y = 100; sp1.scaleX = sp1.scaleY = 1;
			sp2.x = sp2.y = 200; sp2.scaleX = sp2.scaleY = 1;
			sp3.x = sp3.y = 300; sp3.scaleX = sp3.scaleY = 1;
		}
		
		private function onReset(e:Event):void {
			placeTargets();
		}
		private function onApply(e:Event):void {
			//do the selected shit
			var method:Function = AlignMethods[String(combo.selectedItem)];
			if (method == null) return;
			
			var tcs:DisplayObject = toStage.selected ? stage : grid;
			
			var applyResults:Boolean = applyResults_chk.selected;
			var ignoreOrigin:Boolean = ignoreOrigin_chk.selected;
			var pixelHinting:Boolean = pixelHinting_chk.selected;
			
			VizAlign.pixelHinting = pixelHinting;
			VizAlign.align ([sp1, sp2, sp3], [new VizAlignment(method, tcs)], applyResults, ignoreOrigin);
		}
		
		private var dragging:Object;
		
		private function dragSomething(e:MouseEvent):void {
			Sprite(e.target).startDrag();
			dragging = e.target;
			stage.addEventListener(MouseEvent.MOUSE_UP, dropSomething);
		}
		
		private function dropSomething(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, dropSomething);
			e.target.stopDrag();
		}
		
		
	}
}