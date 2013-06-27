package com.xgame.common.commands.sending
{
	import com.xgame.configuration.SocketContextConfig;

	public class Send_Info_RequestAccountRole extends SendingBase
	{
		public var GUID: uint;
		
		public function Send_Info_RequestAccountRole()
		{
			super(SocketContextConfig.ACTION_REQUEST_CHARACTER << 4 | SocketContextConfig.CONTROLLER_INFO);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteData.writeInt(4);
			_byteData.writeByte(SocketContextConfig.TYPE_INT);
			_byteData.writeUnsignedInt(GUID);
		}
		
		override public function get protocolName():String
		{
			return "Send_Info_RequestAccountRole";
		}
	}
}