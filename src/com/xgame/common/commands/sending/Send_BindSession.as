package com.xgame.common.commands.sending
{
	import com.xgame.configuration.SocketContextConfig;

	public class Send_BindSession extends SendingBase
	{
		public var accountName: String;
		
		public function Send_BindSession()
		{
			super((SocketContextConfig.ACTION_BIND_SESSION << 4) | SocketContextConfig.CONTROLLER_INFO);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteData.writeInt(accountName.length);
			_byteData.writeByte(SocketContextConfig.TYPE_STRING);
			_byteData.writeUTF(accountName);
		}
	}
}