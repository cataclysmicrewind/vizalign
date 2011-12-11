

package ktu.utils.align {
	
	import flash.geom.Rectangle;
	
	/**
	 * 	this interface specifies a function that is used to align rectangles.
	 * 	
	 * 
	 * the decision to use an interface includes a number of reasons. explaining these reasons may help you understand more about
	 * why this library was built that way and how you might be able to extend it in a way that suites you.
	 * 
	 * a large factor in deciding to make an interface was file size. i recognize that this library while useful will rarely be used in its
	 * entirety. the likelyhood that any one application will use more than a handful of alignment methods is very rare. thus, making an 
	 * interface allowed me to separate each method into its own object so only the methods you need get compiled into the swf.
	 * 
	 * another reason for choosing an interface is to allow a developer to make their own alignment methods. since this is an interface, you can
	 * give your object any number of flags or settings before using it in alignment. a quick example could help:
	 * 		make a XAligner object. in there is a .mode property which can either be "left", "center", "right". 
	 * to utilize this flag and within VizAlign the code would look like this:
	 * 		var xa:XAligner = new XAligner();
	 * 		xa.mode = "center";
	 * 		VizAlign.align ( [targets], [new VizAlignment (xa, stage)], true, true, true );
	 * this has allowed you to create one object that can act in different ways. 
	 * one more example to show you how far out you could go:
	 * 		make a SpiralAligner object. it has properties such as .fromCorner, .objectReferencePoint, .direction
	 * 		.fromCorner = which corner of the tcs to start from
	 * 		.objectReferencePoint = which part of the targets are you placing along the spiral
	 * 		.direction = clockwise or counter clockwise
	 * to show an example of what it looks like:
	 * 		var sa:SpiralAligner = new SpiralAligner();
	 * 		sa.fromCorner = "topRight";
	 * 		sa.direction = "ccw";
	 * 		sa.objectReferencePoint = "topLeft";
	 * 		VizAlign.align ( [targets], [new VizAlignment (sa, stage)], true, true, true );
	 * 
	 * in recognition of the challenges that may come with having separate objects for each alignment method, i have implemented an example of a manifest.
	 * the AlignerManigest includes static public get methods for each aligner that i created. this way, you can just say AlignerManifest.left and get an
	 * instance of the LeftAligner object. Given the understanding of how that works, you could easily create your own manifest with your own flavor of methods.
	 * the most simple way would be to copy AlignerManifest and only keep in there the ones you will be using.
	 * in the case of the 'capabilities swf' that i created to showcase the library, with a manifest you can use describeType to get a list of all the 
	 * aligners that are compiled in the swf to give user access to them (in the case of the mentiond swf, it was in the add alignment dialog).
	 * 
	 * 
	 * 
	 * 
	 * @author ktu
	 */
	public interface IRectangleAligner {
		/**
		 * 	This function will align the targets array to the targetCoordinateSpace in which ever way it chooses
		 * 
		 * @param	targetCoordinateSpace 	the rectangle that will not change
		 * @param	targets					the rectangles you want to align
		 */
		function alignRectangles(targetCoordinateSpace:Rectangle, targets:Array/*Rectangle*/):void;
	}
}