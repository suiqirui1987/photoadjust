package com
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import mx.core.Container;
	import mx.core.UIComponent;
	
	public class Imgcontainer extends   Container
	{
	

		private var onlayer:UIComponent=null;
		
		private var dobject:UIComponent=null;
		private var startX:Number;
		private var startY:Number;
		private var rectrWidth:Number;
		private var rectrHeight:Number;
		

		
		private var drawRect:Rectangle;
		
		public static const SELECTED:String="selected";
		public var lineColor:int=0x0099FF;
		public var fileColor:int=0x0099FF;
		public var fillAlpha:Number=0.1;
				

		public function ImgContainer():void	
		{
			
		}
		override protected function createChildren():void
		{
        	super.createChildren();
        	this.onlayer=new UIComponent();
			this.addChild(this.onlayer);
		}
		
	
		public function get RectLayder():Sprite
		{
			return this.onlayer;
		}
		public function set urectWidth(value:Number):void
		{
			this.rectrWidth=value;
		}
		public function get urectWidth():Number
		{
			return this.rectrWidth;
		}
		
		public function set urectHeight(value:Number):void
		{	
			this.rectrHeight=value;
		}
		public function get urectHeight():Number
		{
			return this.rectrHeight;
		}
		
		public function set ustartX(value:Number):void
		{
			this.startX=value;
		}
		public function get ustartX():Number
		{
			return this.startX;
		}
		
		public function get ustartY():Number
		{
			return this.startY;
		}
		
		public function set ustartY(value:Number):void
		{
			this.startY=value;
		}
		
		public  function dashLineToPattern(target:UIComponent, x1:Number, y1:Number,x2:Number, y2:Number,pattern:Array):void 
        { 
            
           
            var x:Number=x2-x1;
            var y:Number=y2-y1;
            var hyp:Number = Math.sqrt((x)*(x) + (y)*(y));
            
            var units:Number = hyp/(pattern[0]+pattern[1]); 
            var dashSpaceRatio:Number = pattern[0]/(pattern[0]+pattern[1]); 
            
            var dashX:Number = (x/units)*dashSpaceRatio; 
            var spaceX:Number = (x/units)-dashX; 
            var dashY:Number = (y/units)*dashSpaceRatio; 
            var spaceY:Number = (y/units)-dashY; 
            
            target.graphics.moveTo(x1, y1); 
            var te:Number=1;
            while (hyp > 0)  
            { 
                x1 += dashX; 
                y1 += dashY; 
                hyp -= pattern[0]; 
                if (hyp < 0)  
                { 
                   x1 = x2; 
                   y1 = y2; 
                } 
                var color:int=0xffffff;
      			if(te%2==0)
      			{
      				color=0x000000;
      				
      			}
      			te++;
                target.graphics.lineStyle(0,color,1);
                target.graphics.lineTo(x1, y1); 
                x1 += spaceX; 
                y1 += spaceY; 
           
                target.graphics.moveTo(x1, y1); 
                hyp -= pattern[1]; 
            } 
            
            target.graphics.moveTo(x2, y2); 
        } 

	

         //画区域
		public function DrawingRect():void
		{		


			this.startX=(this.width - this.rectrWidth)/2;
			this.startY=(this.height -this.rectrHeight)/2;
			
	
		
			this.onlayer.graphics.clear();
			//第一块
			this.onlayer.graphics.lineStyle(0,0xcccccc,0);
			this.onlayer.graphics.beginFill(0x000000,0.5);
			//.... one
			this.onlayer.graphics.drawRect(0,0,this.startX,this.height);
			//.... two
			this.onlayer.graphics.drawRect(this.startX,0,this.rectrWidth,this.startY);
			//.... three
			this.onlayer.graphics.drawRect(this.startX+this.rectrWidth,0,this.width-this.startX-this.rectrWidth,this.height);
			//.... four
			this.onlayer.graphics.drawRect(this.startX,this.startY+this.rectrHeight,this.rectrWidth,this.height-this.startY-this.rectrHeight);
			
			//this.onlayer.graphics.lineStyle(0,this.lineColor,0);
			var pusharr:Array=new Array(6,0);
		    this.dashLineToPattern(this.onlayer,this.startX,this.startY,this.startX,this.startY+this.rectrHeight,pusharr);
		    this.dashLineToPattern(this.onlayer,this.startX,this.startY,this.startX+this.rectrWidth,this.startY,pusharr);
		    this.dashLineToPattern(this.onlayer,this.startX+this.rectrWidth,this.startY,this.startX+this.rectrWidth,this.startY+this.rectrHeight,pusharr);
		    this.dashLineToPattern(this.onlayer,this.startX,this.startY+this.rectrHeight,this.startX+this.rectrWidth,this.startY+this.rectrHeight,pusharr);
		    
			this.onlayer.graphics.beginFill(this.fileColor,0);
			this.drawRect=new Rectangle(this.startX,this.startY,this.rectrWidth,this.rectrHeight);
			//this.onlayer.graphics.drawRect(this.drawRect.x,this.drawRect.y,this.drawRect.width,this.drawRect.height);
			
		}	
	}
}