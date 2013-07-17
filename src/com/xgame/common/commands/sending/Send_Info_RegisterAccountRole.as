package com.xgame.common.commands.sending
{
	import com.xgame.configuration.SocketContextConfig;

	public class Send_Info_RegisterAccountRole extends SendingBase
	{
		public var GUID: uint;
		public var nickName: String;
		
		public function Send_Info_RegisterAccountRole()
		{
			super(SocketContextConfig.ACTION_REGISTER_CHARACTER << 4 | SocketContextConfig.CONTROLLER_INFO);
		}
		
		override public function fill():void
		{
			super.fill();
			
			_byteData.writeInt(4);
			_byteData.writeByte(SocketContextConfig.TYPE_INT);
			_byteData.writeUnsignedInt(GUID);
			
			_byteData.writeInt(nickName.length);
			_byteData.writeByte(SocketContextConfig.TYPE_STRING);
			_byteData.writeUTF(nickName);
		}
	}
}