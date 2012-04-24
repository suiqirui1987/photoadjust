package com
{
	import component.wincut;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import component.wincut;
	import mx.controls.ProgressBar;
	import mx.core.UIComponent;
	
	[Style(name="borderColor", type="Number", inherit="no")]
	[Style(name="borderAlpha", type="Number", inherit="no")]
	[Style(name="borderWidth", type="Number", inherit="no")]
	[Event(name="callbackevent",type="Core.Event.CallBackEvent")]
	public class imageloader extends  UIComponent
	{
		private var _src:String="";
		private var _loader:Loader=null;
		private var _progress:ProgressBar=null;
		private var _rwidth:Number=0;
		private var _rheight:Number=0;
		private var _uwidth:Number=0;
		private var _uheight:Number=0;
		private var _containerWidth:Number=0;
		private var _containerHeight:Number=0;
		private var _mousex:Number=0;
		private var _mousey:Number=0;
		private var _bitmap:Bitmap=null;
		private var _parentLocalx:Number=0;
		private var _parentLocaly:Number=0;
		private var _wpre:Number=1;
		private var _hpre:Number=1;
		private var _scale:Number=1;
		
		private var _imgcon:Imgcontainer;
		private var _uicomponent:UIComponent;
	    
	    //主窗体
	    private var _win:wincut=null;
	
		public var _brightness:Number=0;
	    private var _rowidth:Number;
		private var _roheight:Number;
		
		
		
		
		public function imageloader()
		{
			this.setStyle("borderThickness","1");
			this.setStyle("borderColor","#000000");
		}
		//放大放小
		public function set scale(val:Number):void
		{
			this._scale=val;
		}
		public function get scale():Number
		{
			return this._scale;
		}
			//主窗体
		public function set win(val:wincut):void
		{
			this._win=val;
		}
		public function get win():wincut
		{
			return this._win;
		}
		

		
		
		public function get loader():Loader
		{
			return this._loader;
		}
		public function get uicomponent():UIComponent
		{
			return this._uicomponent;
		}
		
		public function get bitmap():Bitmap
		{
			return this._bitmap;
		}

//容器
		public function set imgcon(value:Imgcontainer):void
		{
			this._imgcon=value
		}
		public function get imgcon():Imgcontainer
		{
			return this._imgcon;
		}
		
//宽比例

		public function get wpre():Number
		{
			return this._wpre;
		}
//高比例	

		public function get hpre():Number
		{
		   return	this._hpre;
		}
		

//图像宽度		
		public function set uwidth(value:Number):void
		{
			this._uwidth=value;
		}
		public function get uwidth():Number
		{
			return this._uwidth;
		}
		
//图像高度		
		public function set uheight(value:Number):void
		{
			this._uheight=value;
		}
		public function get uheight():Number
		{
			return this._uheight;
		}
	     

	     
	     //定位
	     public function setxy():void
	     {
	     	if(this.bitmap != null)
	     	{
	     		/*
	     		if(Math.abs(this._win.angle)== 90 || Math.abs(this._win.angle)==270)
				{  
					//宽度 翻转
					var tem:Number=this.width;
					this.width=this.height;
					this.height=tem;
					trace("ASDFDASFA");
				}
				*/
				
	     		var xx:Number =(this.imgcon.width - this.width)/2;
				var yy:Number =(this.imgcon.height - this.height)/2;	
				this.x=xx + this.width/2;
				this.y=yy + this.height/2;	
				this.bitmap.width=this.width;
				this.bitmap.height=this.height;
				this.bitmap.x=-this.width/2;
				this.bitmap.y=-this.height/2;
				testimg();
	     	}
	    }

//调节
		public  function applyImageFilters():void
		{

		  var cm:ColorMatrix=new ColorMatrix(new Array());
		  cm.adjustBrightness(this._brightness);
		  var cmf:ColorMatrixFilter=new ColorMatrixFilter(cm);
		  var filterArray:Array=new Array();
		  filterArray.push(cmf);
		  this.filters=filterArray;
		}

//加载
		public function set src(value:String):void
		{
		
			this._src=value;
			if(_loader == null)
			{
				var imgcon:Imgcontainer=this.parent as Imgcontainer;
				_loader=new Loader();
				_progress=new ProgressBar();
				_progress.visible=false;
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,IoErrorHandler);	
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,ProgressHandler);
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,CompleteHandler);	
				_loader.load(new URLRequest(this._src),null);
				
			    _progress.visible=true;
			    _progress.label="";
				_progress.width=imgcon.urectWidth;
				_progress.indeterminate=true;
				_progress.height=19;
				_progress.x=this.bitmap==null?(imgcon.width- imgcon.urectWidth) / 2:-this.width/2;
				_progress.y=this.bitmap==null?(imgcon.height- imgcon.urectHeight) / 2:-this.height/2;
				this.addChild(_progress);
			}
			else
			{
				this.CompleteHandler(new Event("evt"));
			}
		}
		public function get src():String     
		{
			return _src;
		}
	
		public function IoErrorHandler(evt:IOErrorEvent):void
		{
			_progress.visible=false;
			_progress=null;
			trace(evt.text); 
		}
		
		public function ProgressHandler(evt:ProgressEvent):void	
		{
			
		}

//完成
		public function CompleteHandler(evt:Event):void
		{
			if(_loader ==null)
			{
				_progress.visible=false;
				_loader=evt.target.loader as Loader;
			}
			
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
		
		//实际计算比例
			this._rwidth=this._win.img_width;//loader.width;
			this._rheight=this._win.img_height;//loader.height;
            var pre1:Number=this._uwidth/this._rwidth;
            var pre2:Number=this._uheight/this._rheight;
            this._wpre=pre1;
            this._hpre=pre2;
            var per:Number=Math.min(pre1,pre2);
			this._uheight=this._rheight * per;
			this._uwidth=this._rwidth * per;
            this.width=this._uwidth;
			this.height=this._uheight;
			
      //加载图计算比例			
			var curwidth:Number=loader.width;
			var curheight:Number=loader.height;
			pre1=this._uwidth/curwidth;
            pre2=this._uheight/curheight;
			per=Math.min(pre1,pre2);
			var m:Matrix=new Matrix();
			m.scale(per,per);
			var bitmapdata:BitmapData=new BitmapData(this.width,this.height,true,0);
			bitmapdata.draw(_loader.content,m);
			_bitmap=new Bitmap(bitmapdata,"auto",true);	 
		    this.addChild(_bitmap);	
		    this._bitmap.x=-this.width/2;
		    this._bitmap.y=-this.height/2;
		    
		
			this.setxy();
	 		this.buttonMode=true;
			//内部侦听
			this.addEventListener(MouseEvent.MOUSE_DOWN,ImageDragStart,false,0,true);
			this.addEventListener(MouseEvent.MOUSE_UP,ImageDragEnd,false,0,true);
			
			
			var imgcon:Imgcontainer=this.imgcon;
			imgcon.RectLayder.buttonMode=true;
			imgcon.RectLayder.addEventListener(MouseEvent.MOUSE_DOWN,ImageDragStart,false,0,true);
			imgcon.RectLayder.addEventListener(MouseEvent.MOUSE_UP,ImageDragEnd,false,0,true);
			
			this.dispatchEvent(new CallBackEvent(CallBackEvent.CALLBACKEVENT));
		
		}
		private function testimg():void
		{
			return;
			this.graphics.clear();
			this.graphics.lineStyle(1,0x000000,1);
			this.graphics.drawRect(0,0,this.width,this.height);
			
		}
		
		//拖动
		private function ImageDragStart(evt:MouseEvent):void
		{
			var w:Number=this.width;
			var h:Number=this.height;
			if(Math.abs(this._win.angle)== 90 || Math.abs(this._win.angle)==270)
			{  
				var tem:Number=w;
				w=h;
				h=tem;	
			}
			//起始位置
			var xx:Number=( w- this._imgcon.urectWidth < 0 ? this._imgcon.ustartX:this._imgcon.ustartX-(w-this._imgcon.urectWidth))+w/2;
			var yy:Number=(h-this._imgcon.urectHeight < 0 ? this._imgcon.ustartY:this._imgcon.ustartY-(h-this._imgcon.urectHeight))+h/2;
			var ww:Number=Math.abs(w-this._imgcon.urectWidth);
			var hh:Number=Math.abs(h-this._imgcon.urectHeight);
			var rect:Rectangle=new Rectangle(xx,yy,ww,hh);
			trace(this.x+"::"+this.y);
			this.startDrag(false,rect);	
		}
		
	
		
		
		//拖动完成。
		private function ImageDragEnd(evt:MouseEvent):void
		{
			this.stopDrag();
		}
		

	}
}