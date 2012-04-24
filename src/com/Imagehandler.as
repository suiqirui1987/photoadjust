package com
{
	import component.wincut;
	
	import mx.utils.*;

	
	public class Imagehandler
	{
		
		//生成预览图
		public function Imagehandler()
		{
			
		}
		

		
		public static function buildimage(il:imageloader,wi:wincut,extraobj:Object) : String
		{
			var imgcon:Imgcontainer=il.parent as Imgcontainer;
				//尺寸缩比
			var sizescalex:Number=imgcon.urectWidth/wi.size_width;
			var sizescaley:Number=imgcon.urectHeight/wi.size_height;
			
			//图像缩比
			var imgscalex:Number=il.wpre;
			var imgscaley:Number=il.hpre;
		
	        //如果原图宽高
	        var imgoriwidth:Number=il.width;
	        var imgoriheight:Number=il.height;
	        //图象X,Y
	        var imgorix:Number=il.x;
	        var imgoriy:Number=il.y;
	        
	        
	        //实际宽高
	        var realwidth:Number=il.width;
	        var realheight:Number=il.height;
	        if(Math.abs(wi.angle)== 90 || Math.abs(wi.angle)==270)
			{  
				//宽度 翻转
				var tem:Number=realwidth;
				realwidth=realheight;
				realheight=tem;
			}
			
			
			//图象坐标
	        var imgx:Number=0;  //图象X起始点
	        var imgy:Number=0;
	        
	        //翻转后的x,y
	        var rx:Number=il.x;
	        var ry:Number=il.y;
	        //默认的x,y
	        var cx:Number=il.x;
	        var cy:Number=il.y;
	        var tx:Number=rx-realwidth/2;
	        var ty:Number=ry-realheight/2;
	        //向下
	        if(il.rotation==90)
	        {
	        	rx=cx-realwidth;
	        	tx=rx+realwidth/2;
	        	ty=ry-realheight/2;
	        }
	        //向左
	        if(il.rotation==180)
	        {
	        	rx=cx-realwidth;
	        	ry=cy-realheight;
	        	tx=rx+realwidth/2;
	            ty=ry+realheight/2;
	        }
	        //向上
	        if(il.rotation==-90)
	        {
	        	ry=cy-realheight;
	        	tx=rx-realwidth/2;
	        	ty=ry+realheight/2;
	        }
	        trace(tx+":>>>"+ty);
	       
	        imgx=tx<imgcon.ustartX?0:Math.abs(tx-imgcon.ustartX);
	    	imgy=ty<imgcon.ustartY?0:Math.abs(ty-imgcon.ustartY);
	    	
	    	//图象剪裁坐标点
	    	var imgcutx:Number=0;
	    	var imgcuty:Number=0;
	    	imgcutx=(tx > imgcon.ustartX)?0:Math.abs(tx-imgcon.ustartX);
	    	imgcuty=(ty > imgcon.ustartY)?0:Math.abs(ty-imgcon.ustartY);
	    	//图象剪裁区域宽高
	    	var imgcutwidth:Number=0;
	    	var imgcutheight:Number=0;
	 
	 /******************                    */   	
	        //图像最右最下边距离
	 		var tw_img:Number=tx+realwidth;
	 		var th_img:Number=ty+realheight;
	 		trace("tw_img:"+tw_img+"::th+img:"+th_img);
	 		//容器最右最下边距离
	 		var tw_con:Number=imgcon.urectWidth + imgcon.ustartX;
	 		var th_con:Number=imgcon.urectHeight + imgcon.ustartY;
	 		trace("tw_con:"+tw_con+"::th+con:"+th_con);
	 		var tw:Number=Math.min(tw_img,tw_con);
	 		var th:Number=Math.min(th_img,th_con);
	 		
	    	imgcutwidth=tw - Math.max(tx,imgcon.ustartX);//(tx<0?imgcon.ustartX:tx);
	    	imgcutheight=th - Math.max(ty,imgcon.ustartY);// (ty<0?imgcon.ustartY:ty);
 /**********                  *********/     	
	    	//其他变量
	    	   //选择的尺寸
			var size_number:Number=wi.select_size;
			var size_width:Number=wi.size_width;
			var size_height:Number=wi.size_height;
			
			   //翻转
			var rotate:Number=wi.angle<0 ? 360+wi.angle : wi.angle;
			   //调亮
	    	var brightness:Number=il._brightness;
	    	   //裁剪与保全
			var img_cut:Number=0;
			if(wi.cutradio.selected==true)
			{
				img_cut=1;
			}
			var img_keep:Number=0;
			if(wi.keepradio.selected==true)
			{
				img_keep=1;
			}
			//放大放小
			var img_scale:Number=il.scale;
			
	   
	    	var str:String=
	    					"sizescalex:"+sizescalex+ //生成后图象比例
	    					",sizescaley:"+sizescaley+
	    					",imgscalex:" +imgscalex+//真实图象比例
	    					",imgscaley:"+imgscaley+
	    					",imgorix:"+imgorix+//图象X,y原。。
	    					",imgoriy:"+imgoriy+
	    					",imgoriwidth:"+imgoriwidth+
	    					",imgoriheight:"+imgoriheight+
	    					",imgrealwidth:"+realwidth+
	    					",imgrealheight:"+realheight+
	    					",imgx:"+imgx+//变转后图象的X，Y
	    					",imgy:"+imgy+
	    					",imgcutx:"+imgcutx+//变转剪裁图象的X，Y
	    					",imgcuty:"+imgcuty+
	    					",imgcutwidth:"+imgcutwidth+
	    					",imgcutheight:"+imgcutheight+
	    					",size_number:"+size_number+
	    					",size_width:"+size_width+
	    					",size_height:"+size_height+
	    					",rotate:"+rotate+
	    					",brightness:"+brightness+
	    					",img_cut:"+img_cut+
	    					",img_keep:"+img_keep+
	    					",img_scale:"+img_scale;
	    	
	    	trace(str);
		    return str;
		}
	}
}