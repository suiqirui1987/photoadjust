package com
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CutImage
	{
		public static function Cut(data:Bitmap, rect:Rectangle):Bitmap
		{
			var bitmapdata:BitmapData = data.bitmapData;
			var retdata:BitmapData = new BitmapData(rect.width, rect.height, false);
			retdata.copyPixels(bitmapdata,rect,new Point(0,0));
			return new Bitmap(retdata);
		}

	}
}