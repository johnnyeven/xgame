package com.xgame.common.commands.receiving
{
	import com.xgame.configuration.SocketContextConfig;
	
	import flash.utils.ByteArray;

	public class Receive_Base_VerifyMap extends ReceivingBase
	{
		public var mapId: int;
		public var direction: int;
		
		public function Receive_Base_VerifyMap()
		{
			super((SocketContextConfig.ACTION_VERIFY_MAP << 4) | SocketContextConfig.CONTROLLER_BASE);
			mapId = int.MIN_VALUE;
			direction = int.MIN_VALUE;
		}
		
		override public function fill(data:ByteArray):void
		{
			super.fill(data);
			
			if (message == SocketContextConfig.ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				while (data.bytesAvailable)
				{
					length = data.readInt();
					type = data.readByte();
					switch(type)
					{
						case SocketContextConfig.TYPE_INT:
							if (mapId == int.MIN_VALUE)
							{
								mapId = data.readInt();
								break;
							}
							if (direction == int.MIN_VALUE)
							{
								direction = data.readInt();
								break;
							}
					}
				}
			}
			
		}
	}
}