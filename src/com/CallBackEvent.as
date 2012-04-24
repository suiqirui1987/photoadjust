package com
{
	/**
	 * 回调事件
	 * */
	import flash.events.Event;
	
	public class CallBackEvent extends Event
	{
		private var _paramObject:Object=null;
		public static const  CALLBACKEVENT:String="callbackevent";
		public function CallBackEvent(type:String,obj:Object=null)
		{
			this._paramObject=obj;
			super(type,false,true);
		}
		public function get ParamObject():Object
		{
			return this._paramObject;
		}
		
		override public function clone():Event
		{
		  return	new CallBackEvent(type);
		}
	}
}