package com.xgame.common.commands.sending
{
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.utils.Int64;

	public class Send_Info_RequestHotkey extends SendingBase
	{
		public var accountId: Int64;
		
		public function Send_Info_RequestHotkey()
		{
			super(SocketContextConfig.ACTION_REQUEST_HOTKEY << 4 | SocketContextConfig.CONTROLLER_INFO);
		}
		
		override public function fill():void
		{
			super.fill();
			
			if(accountId != null)
			{
				_byteData.writeInt(8);
				_byteData.writeByte(SocketContextConfig.TYPE_LONG);
				_byteData.writeUnsignedInt(accountId.low);
				_byteData.writeInt(accountId.high);
			}
		}
		
		override public function get protocolName():String
		{
			return "Send_Info_RequestHotkey";
		}
	}
}