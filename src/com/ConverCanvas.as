package com
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	
	public class ConverCanvas extends Canvas
	{
		private var ui:UIComponent=null;
		public function ConverCanvas()
		{
		}
		override protected function createChildren():void
		{
			var w:Number=this.width-1;
			var h:Number=this.height-1;
			
			ui=new UIComponent();
			this.addChild(ui);
			ui.graphics.clear();
			ui.graphics.lineStyle(1,0xBEE4FF,1);
			var fillType:String=flash.display.GradientType.LINEAR;
			var colors:Array=[0xFFFFFF,0xEFFDFF];
			var alphas:Array=[100,100];
			var rations:Array=[0xFFFFFF,0xEEFDFF]
			var matr:Matrix=new Matrix();
			matr.createGradientBox(w,h,0,0,0);
			var spread:String=SpreadMethod.PAD;
			ui.graphics.beginGradientFill(fillType,colors,alphas,rations,matr,spread);
			super.createChildren();
		}

	}
}