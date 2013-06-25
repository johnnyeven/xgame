package com.xgame.common.commands.sending
{
	import com.xgame.configuration.SocketContextConfig;
	
	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_QuickStart extends SendingBase 
	{
		public var GameId: int;
		
		public function Send_Info_QuickStart() 
		{
			super((SocketContextConfig.ACTION_QUICK_START << 4) | SocketContextConfig.CONTROLLER_INFO);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteData.writeInt(4);
			_byteData.writeByte(SocketContextConfig.TYPE_INT);
			_byteData.writeInt(GameId);
		}
		
		override public function get protocolName():String
		{
			return "Send_Info_QuickStart";
		}
	}

}