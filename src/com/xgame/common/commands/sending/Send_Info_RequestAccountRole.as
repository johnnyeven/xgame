package com.xgame.common.commands.sending
{
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.utils.Int64;

	public class Send_Info_RequestAccountRole extends SendingBase
	{
		public var GUID: Int64;
		
		public function Send_Info_RequestAccountRole()
		{
			super(SocketContextConfig.ACTION_REQUEST_CHARACTER << 4 | SocketContextConfig.CONTROLLER_INFO);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteData.writeInt(8);
			_byteData.writeByte(SocketContextConfig.TYPE_LONG);
			_byteData.writeUnsignedInt(GUID.low);
			_byteData.writeInt(GUID.high);
		}
		
		override public function get protocolName():String
		{
			return "Send_Info_RequestAccountRole";
		}
	}
}