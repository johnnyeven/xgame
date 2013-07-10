package com.xgame.common.commands.receiving
{
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.utils.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Info_RequestHotkey extends ReceivingBase
	{
		public var config: XML;
		
		public function Receive_Info_RequestHotkey()
		{
			super(SocketContextConfig.ACTION_REQUEST_HOTKEY << 4 | SocketContextConfig.CONTROLLER_INFO);
		}
		
		override public function fill(data:ByteArray):void
		{
			super.fill(data);
			
			if(message == SocketContextConfig.ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				while(data.bytesAvailable)
				{
					length = data.readInt();
					type = data.readByte();
					switch(type)
					{
						case SocketContextConfig.TYPE_STRING:
							var s: String = data.readUTFBytes(length);
							if(!StringUtils.empty(s))
							{
								config = XML(s);
							}
							break;
					}
				}
			}
		}
	}
}