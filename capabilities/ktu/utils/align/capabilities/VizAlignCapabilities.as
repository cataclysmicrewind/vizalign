package ktu.utils.align.capabilities {
	
	import com.bit101.components.Style;
	import com.flashdynamix.motion.Tweensy;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.fscommand;
	import flash.system.System;
	import ktu.utils.align.aligners.CenterAligner;
	import ktu.utils.align.aligners.TopRightAligner;
	import ktu.utils.align.capabilities.gfx.Fullscreen;
	import ktu.utils.align.capabilities.gfx.Grid;
	import ktu.utils.align.capabilities.gfx.Target;
	import ktu.utils.align.capabilities.gfx.TargetInfo;
	import ktu.utils.align.capabilities.gfx.VizAlignArena;
	import ktu.utils.align.capabilities.gfx.VizAlignLogo;
	import ktu.utils.align.capabilities.ui.CapabilitiesControls;
	import ktu.utils.align.VizAlign;
	import ktu.utils.align.VizAlignGroup;
	import ktu.utils.align.VizAlignment;
	import ktu.utils.align.VizAlignTarget;
	
	/**
	 * 	This class is the Document class for the Capabilities SWF.
	 *
	 * 	This swf is designed to show off what VizAlign can do
	 *
	 *
	 *
	 *
	 * 	TO DO:
	 *
	 * 		Help - tons of instructions...
	 * 			Are you good with AS3?
	 * 				Yes		No
	 *
	 * 			AS3 Developers start father in the instructions
	 *
	 * 			Non as3 start at beginning...
	 *
	 *
	 * 			Contents:
	 *				Why I made VizAlign
	 * 				This SWF
	 * 				The Problem:
	 * 					Coordinate Planes
	 * 					Origins
	 * 					Scaling
	 *
	 * 				The Solution:
	 *					getBounds(this);
	 * 					scaling
	 *
	 * 				Using Capabilities:
	 * 					Presets
	 * 					Custom
	 *
	 *
	 *
	 *
	 *
	 * ...
	 * @author ktu
	 */
	public class VizAlignCapabilities extends Sprite {
		
		private var arena:VizAlignArena;
		private var grid:Grid;
		
		private var controlPanel:CapabilitiesControls;
		
		private var green:Target;
		private var red:Target;
		private var purple:Target;
		private var cyan:Target;
		private var yellow:Target;
		
		public function VizAlignCapabilities() {
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			stage.showDefaultContextMenu = false;
			stage.addEventListener(Event.RESIZE, function (e:Event):void {
				trace(stage.stageWidth + " : " + stage.stageHeight);
			});
			
			
			Style.setStyle(Style.KTU);
			
			arena = new VizAlignArena();
			arena.name = "arena";
			arena.setSize(750, 500);
			addChild(arena);
			
			createTargets();
			
			addTCS(arena);
			addTargetInfo(arena);
			addTargets(arena);
			
			controlPanel = new CapabilitiesControls();
			controlPanel.y = 500;
			addChild(controlPanel);
			
			var tcs:Array = arena.targetCoordinateSpaces;
			tcs.unshift(arena);
			tcs = tcs.concat(arena.targets);
			controlPanel.targetCoordinateSpaces = tcs;
			controlPanel.targets = arena.targets;
			
			
			createFullscreen();
			
		}
		
		private function createFullscreen():void {
			var _fullscreen:Fullscreen = new Fullscreen();
			addChild(_fullscreen);
			VizAlign.align([_fullscreen], [new VizAlignment(new TopRightAligner(), arena)], false, true, true);
		}
		
		private function addTCS(arena:VizAlignArena):void {
			var l:VizAlignLogo = new VizAlignLogo();
			l.name = "vizalign logo";
			l.x = 10;
			l.y = 10;
			arena.addTCS(l);
			
			grid = new Grid();
			grid.name = "grid";
			grid.x = 190;
			grid.y = 70;
			grid.setSize(360, 360);
			grid.addInterval(2, 0x999999);
			grid.addInterval(4, 0x666666);
			arena.addTCS(grid);
		}
		
		private function createTargets():void {
			yellow = new Target();
			yellow.name = "yellow";
			yellow.x = 450 - 200;
			yellow.y = 290 - 200;
			yellow.setSize(60, 100);
			yellow.setOriginOffset(-200, -200);
			yellow.setColor(0xCCFF32);
			yellow.numSides = 6;
			yellow.origPos = new Rectangle(yellow.x, yellow.y, yellow.width, yellow.height);
			
			green = new Target();
			green.name = "green";
			green.x = 230 + 70;
			green.y = 110 + 90;
			green.setSize(60, 60);
			green.setOriginOffset(70, 90);
			green.setColor(0x009966);
			green.numSides = 5;
			green.origPos = new Rectangle(green.x, green.y, green.width, green.height);
			
			cyan = new Target();
			cyan.name = "cyan";
			cyan.x = 340;
			cyan.y = 250 + 50;
			cyan.setSize(60, 40);
			cyan.setOriginOffset(0, 50);
			cyan.setColor(0x09AABB);
			cyan.numSides = 4;
			cyan.origPos = new Rectangle(cyan.x, cyan.y, cyan.width, cyan.height);
			
			red = new Target();
			red.name = "red";
			red.x = 410;
			red.y = 170;
			red.setSize(40, 40);
			red.setOriginOffset(0, 0);
			red.setColor(0xB41D00);
			red.numSides = 3;
			red.origPos = new Rectangle(red.x, red.y, red.width, red.height);
			
			purple = new Target();
			purple.name = "purple";
			purple.x = 300 + 20;
			purple.y = 210 - 20;
			purple.setSize(20, 40);
			purple.setOriginOffset(20, -20);
			purple.setColor(0xBE1AD0);
			purple.numSides = 0;
			purple.origPos = new Rectangle(purple.x, purple.y, purple.width, purple.height);
		
		}
		
		public function addTargets(arena:VizAlignArena):void {
			arena.addTarget(yellow);
			arena.addTarget(green);
			arena.addTarget(cyan);
			arena.addTarget(red);
			arena.addTarget(purple);
		}
		
		private function addTargetInfo(arena:VizAlignArena):void {
			var targetInfo:TargetInfo = new TargetInfo();
			targetInfo.name = "target info";
			
			var rect:Rectangle = new Rectangle();
			rect.x = grid.x + grid.width
			rect.y = grid.y
			rect.width = stage.stageWidth - rect.x
			rect.height = grid.height;
			
			var targets:Array = [yellow, green, red, purple, cyan];
			for (var i:int = 0; i < targets.length; i++){
				var target:Target = targets[i];
				target.addEventListener(MouseEvent.CLICK, targetInfo.onTargetSelected);
				target.addEventListener(MouseEvent.DOUBLE_CLICK, targetInfo.onTargetSelected);
			}
			
			arena.addTCS(targetInfo);
			
			VizAlign.align([targetInfo], [new VizAlignment(new CenterAligner(), rect)], false, true, true);
		}
		
		public function exampleRecursion(targets:Array /*VizAlignTarget*/):void {
			for each (var vat:VizAlignTarget in targets){
				if (vat is VizAlignGroup)
					exampleRecursion(VizAlignGroup(vat).targets);
				else {
					var params:Object = { };
					params.x = vat.end.x;
					params.y = vat.end.y;
					params.width = vat.end.width;
					params.height = vat.end.height;
					Tweensy.to(vat.target, params, .5);
				}
			}
		}
	}
}