package ktu.utils.align.capabilities {
	
	import com.bit101.components.HSlider;
	import com.bit101.components.Slider;
	import com.bit101.components.Style;
	import com.flashdynamix.motion.Tweensy;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StatusEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.fscommand;
	import flash.system.System;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import ktu.utils.align.aligners.CenterAligner;
	import ktu.utils.align.aligners.TopRightAligner;
	import ktu.utils.align.aligners.VerticalAligner;
	import ktu.utils.align.capabilities.gfx.Fullscreen;
	import ktu.utils.align.capabilities.gfx.Grid;
	import ktu.utils.align.capabilities.gfx.Options;
	import ktu.utils.align.capabilities.gfx.Target;
	import ktu.utils.align.capabilities.gfx.TargetInfo;
	import ktu.utils.align.capabilities.gfx.VizAlignArena;
	import ktu.utils.align.capabilities.gfx.VizAlignLogo;
	import ktu.utils.align.capabilities.ui.CapabilitiesControls;
	import ktu.utils.align.capabilities.utils.ScreenRuler;
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
		private var targetInfo:TargetInfo;
		private var options:Options;
		private var screenRuler:ScreenRuler = new ScreenRuler();
		private var syntax:SyntaxVisualizer;
		
		public function VizAlignCapabilities() {
			// set stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.showDefaultContextMenu = false;
			// set style
			Style.setStyle(Style.KTU);
			// create arena
			arena = new VizAlignArena();
			arena.name = "arena";
			arena.setSize(750, 500);
			addChild(arena);
			// create targets
			createTargets();
			// add logo and grid
			addTCS(arena);
			// create target info
			addTargetInfo(arena);
			// create options
			addOptions();
			// add targets to arena
			addTargets(arena);
			// create controls
			controlPanel = new CapabilitiesControls();
			controlPanel.y = 500;
			addChild(controlPanel);
			// send possible tcs to controls
			var tcs:Array = arena.targetCoordinateSpaces;
			tcs.unshift(arena);
			tcs = tcs.concat(arena.targets);
			controlPanel.targetCoordinateSpaces = tcs;
			controlPanel.targets = arena.targets;
			// create syntax visualizer
			syntax = new SyntaxVisualizer();
			syntax.y = 475 - 4 - 6;
			syntax.setSize(750, 25);
			syntax.defaultTextFormat = new TextFormat("_typewriter", 12, 0xAEC8C8, false, null, null, null, null, TextFormatAlign.CENTER);
			controlPanel.addEventListener("vizalign", function (e:NetStatusEvent):void {
				syntax.visualize(e.info);
			});
			addChild(syntax);
			
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
			targetInfo = new TargetInfo();
			targetInfo.name = "target info"; 
			targetInfo.addEventListener("open", onTargetInfoClosed);
			addChild(targetInfo);
			
			var targets:Array = [yellow, green, red, purple, cyan];
			for (var i:int = 0; i < targets.length; i++){
				var target:Target = targets[i];
				target.addEventListener(MouseEvent.CLICK, targetInfo.onTargetSelected);
				target.addEventListener(MouseEvent.DOUBLE_CLICK, targetInfo.onTargetSelected);
			}
			
			var rect:Rectangle = new Rectangle();
			rect.x = grid.x + grid.width
			rect.y = grid.y
			rect.width = stage.stageWidth - rect.x
			rect.height = grid.height;
			VizAlign.align([targetInfo], [new VizAlignment(new CenterAligner(), rect)], false, true, true);
			
			targetInfo.x = arena.width;
		}
		private function addOptions ():void {
			options = new Options();
			options.name = "options";
			options.addEventListener("open", onOptionsOpen);
			options.addEventListener("highlightTCS", onHighLightTCS);
			options.addEventListener("screenRuler", onScreenRuler);
			addChild(options);
			
			VizAlign.align([options], [new VizAlignment(new VerticalAligner(), arena)], true, true, true);
			options.x = -options.width;
			options.open = false;
		}
		
		private function onScreenRuler(e:StatusEvent):void {
			if (e.code == "true") {
				// display and activate
				addChild(screenRuler);
				screenRuler.activated = true;
			} else {
				// hide and deactivate
				screenRuler.activated = false;
				removeChild(screenRuler);
			}
		}
		
		private function onHighLightTCS(e:StatusEvent):void {
			if (e.code == "true") {
				arena.highlightTCS = true;
			} else {
				arena.highlightTCS = false;
			}
		}
		
		private function onOptionsOpen(e:Event):void {
			if (options.open) {
				Tweensy.to(options, {x: 0});
			} else {
				Tweensy.to(options, {x: -150});
			}
		}
		
		private function onTargetInfoClosed(e:Event):void {
			if (targetInfo.open) {
				Tweensy.to(targetInfo, {x: arena.width - 150});
			} else {
				Tweensy.to(targetInfo, {x: arena.width});
			}
		}
		
		public function exampleRecursion(targets:Array /*VizAlignTarget*/):void {
			for each (var vat:VizAlignTarget in targets){
				if (vat is VizAlignGroup)
					exampleRecursion(VizAlignGroup(vat).targets);
				else {
					var params:Object = {};
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