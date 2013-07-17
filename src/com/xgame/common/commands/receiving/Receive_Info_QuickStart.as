package com.xgame.common.commands.receiving
{
	import com.adobe.utils.IntUtil;
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.utils.Int64;
	import com.xgame.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author john
	 */
	public class Receive_Info_QuickStart extends ReceivingBase 
	{
		public var GUID: Int64;
		public var accountName: String;
		public var accountPass: String;
		
		public function Receive_Info_QuickStart() 
		{
			super((SocketContextConfig.ACTION_QUICK_START << 4) | SocketContextConfig.CONTROLLER_INFO);
		}
		
		override public function fill(bytes: ByteArray):void
		{
			super.fill(bytes);
			
			if (message == SocketContextConfig.ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				while (bytes.bytesAvailable)
				{
					length = bytes.readInt();
					type = bytes.readByte();
					switch(type)
					{
						case SocketContextConfig.TYPE_LONG:
							if (GUID == null)
							{
								GUID = new Int64();
								GUID.low = bytes.readUnsignedInt();
								GUID.high = bytes.readInt();
							}
							break;
						case SocketContextConfig.TYPE_STRING:
							if (StringUtils.empty(accountName))
							{
								accountName = bytes.readUTFBytes(length);
								break;
							}
							if (StringUtils.empty(accountPass))
							{
								accountPass = bytes.readUTFBytes(length);
								break;
							}
							break;
					}
				}
			}
		}
		
		override public function get protocolName():String
		{
			return "Receive_Info_QuickStart";
		}
	}

}