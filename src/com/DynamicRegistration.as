package com
{
	 //动态改变注册点类
	import flash.display.DisplayObject;
	import flash.geom.Point;
	public class DynamicRegistration
	{
		 //需更改的注册点位置
		  private var regpoint:Point
		  //更改注册的显示对象
		  private var target:DisplayObject
		  private var Height:Number
		  private var Width:Number
		  //首先要确定初始状态
		 public  function DynamicRegistration(target:DisplayObject,regpoint:Point,iWidth:Number=320,iHeight:Number=240)
		  {
			   Width=iWidth;
			   Height=iHeight;
			   this.target=target;
			   this.regpoint=regpoint;
		  }
		  //设置显示对象的属性
		  public function flush(prop:String,value:Number):void
		  {
		   var mc=this.target
		   //转换为全局坐标
		   var A:Point=mc.parent.globalToLocal(mc.localToGlobal(regpoint))   
		   if(prop=="scaleX" || prop=="scaleY")
		   {
			    if(mc[prop]>value){
			     //放大过程
			    mc.x+=((Width*(value+0.1))-(Width*value))/4
			    mc.y+=((Height*(value+0.1))-(Height*value))/4
			    }else{
			     //缩小过程
			     mc.x-=((Width*value)-(Width*(value-0.1)))/4
			     mc.y-=((Height*value)-(Height*(value-0.1)))/4
			    }
			     mc[prop]=value
		   }
		   else
		   {
			    mc[prop]=value
			    //执行旋转等属性后，再重新计算全局坐标
			    var B:Point=mc.parent.globalToLocal(mc.localToGlobal(regpoint))
			    //把注册点从B点移到A点
			    mc.x+=A.x-B.x
			    mc.y+=A.y-B.y
		   }
		  }


	}
}