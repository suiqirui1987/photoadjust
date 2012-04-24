package com
{
	import component.wincut;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import component.wincut;
	public class loadsaveinfo
	{
		private var _win:wincut;
		private var imgobject:Object=null;
		public function loadsaveinfo(win:wincut)
		{
			this._win=win;	
		}
		public function loadinfo():void
		{
			var infourl:String=this._win.SUBMITURL+"&build=gettemplateinfo";
			var _loader:URLLoader=new URLLoader();
			_loader.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			_loader.addEventListener(Event.COMPLETE,completeHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			_loader.load(new URLRequest(infourl));
		}
		private function errorHandler(evt:IOErrorEvent):void
		{
		//	trace(evt.text);
		}
		private function completeHandler(evt:Event):void
		{
			var str:String=evt.target.data;
	
			if(str!="")
			{
				imgobject=new Object();			
				var ta:Array=str.split(",");		
				for(var i:Number=0;i<ta.length;i++)
				{
					var exp_array:Array=ta[i].toString().split(":");		
					imgobject[exp_array[0]]=exp_array[1];
				}
				//设置页面
				this._win.AddPrintSizeRadio(imgobject.size_number);				
				var obj:Object=com.PrintSize.print_size[imgobject.size_number];
				this._win.size_width=obj.short_size;
				this._win.size_height=obj.long_size;
				this._win.adjustsize();
				this._win.imagesrc.addEventListener(CallBackEvent.CALLBACKEVENT,loadedimageHandler);
			}
			else
			{
				this._win.AddPrintSizeRadio();
				this._win.adjustsize();
				this._win.imagesrc.addEventListener(CallBackEvent.CALLBACKEVENT,firstloadimageHandler);
			}
			this._win.showprogressState.label="正在生成，请稍候...";
			this._win.showprogressState.visible=false;
		}
		
		private function firstloadimageHandler(evt:CallBackEvent):void
		{
			this._win.submitbutton.enabled=true;
			this._win.imagesrc.removeEventListener(CallBackEvent.CALLBACKEVENT,this.loadedimageHandler);
		}
		
		private function loadedimageHandler(evt:CallBackEvent):void
		{
			this._win.submitbutton.enabled=true;
			var img_cut:Number=this.imgobject.img_cut  ;
			var img_keep:Number=this.imgobject.img_keep ;
			var imgorix:Number=this.imgobject.imgorix ;
			var imgoriy:Number=this.imgobject.imgoriy ;
			var size_number:Number=this.imgobject.size_number;

		
			
			
			this._win.imagesrc._brightness=this.imgobject.brightness;
			this._win.brightnesssilder.value=this.imgobject.brightness;
			this._win.imagesrc.applyImageFilters();
			//番转
			this._win.imagesrc.rotation=this.imgobject.rotate;
			this._win.angle=this.imgobject.rotate;
			
			
			
			if(img_cut==1)
			{
				 this._win.cutradio.selected=true;
			  	 this._win.cutradioHandler(new MouseEvent("mouse"));
			  	 
				 this._win.bigsmallslider.value=this.imgobject.img_scale;
				 this._win.bigsmallsiderHandler(new Event("event"));
				 
			
			}
			if(img_keep==1)
			{
				this._win.keepradio.selected=true;
				this._win.keepradioHandler(new MouseEvent("mouse"));
			}
				//X,y设置
			trace("imgorix"+imgorix+"imgoriy"+imgoriy);
			this._win.imagesrc.x=imgorix;
			this._win.imagesrc.y=imgoriy;
			this._win.imagesrc.removeEventListener(CallBackEvent.CALLBACKEVENT,this.loadedimageHandler);
			
		}
		private function progressHandler(evt:ProgressEvent):void
		{
			this._win.showprogressState.label="正在加载，请稍候...";
			this._win.showprogressState.visible=true;
			
		}

	}
}