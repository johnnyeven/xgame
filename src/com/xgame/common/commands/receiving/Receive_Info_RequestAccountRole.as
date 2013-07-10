package com.xgame.common.commands.receiving
{
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.utils.Int64;
	import com.xgame.utils.StringUtils;
	import com.xgame.utils.UInt64;
	
	import flash.utils.ByteArray;

	public class Receive_Info_RequestAccountRole extends ReceivingBase
	{
		public var accountId: Int64;
		public var nickName: String;
		public var accountCash: UInt64;
		public var direction: int;
		public var currentHealth: uint;
		public var maxHealth: uint;
		public var currentMana: uint;
		public var maxMana: uint;
		public var currentEnergy: uint;
		public var maxEnergy: uint;
		public var x: int;
		public var y: int;
		
		public function Receive_Info_RequestAccountRole()
		{
			super((SocketContextConfig.ACTION_REQUEST_CHARACTER << 4) | SocketContextConfig.CONTROLLER_INFO);
			direction = int.MIN_VALUE;
			currentHealth = uint.MIN_VALUE;
			maxHealth = uint.MIN_VALUE;
			currentMana = uint.MIN_VALUE;
			maxMana = uint.MIN_VALUE;
			currentEnergy = uint.MIN_VALUE;
			maxEnergy = uint.MIN_VALUE;
			x = int.MIN_VALUE;
			y = int.MIN_VALUE;
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
						case SocketContextConfig.TYPE_LONG:
							if (accountId == null)
							{
								accountId = new Int64();
								accountId.low = data.readUnsignedInt();
								accountId.high = data.readInt();
								break;
							}
							if(accountCash == null)
							{
								accountCash = new UInt64();
								accountCash.low = data.readUnsignedInt();
								accountCash.high = data.readUnsignedInt();
								break;
							}
						case SocketContextConfig.TYPE_STRING:
							if(StringUtils.empty(nickName))
							{
								nickName = data.readUTFBytes(length);
								break;
							}
							break;
						case SocketContextConfig.TYPE_INT:
							if(direction == int.MIN_VALUE)
							{
								direction = data.readInt();
								break;
							}
							if(currentHealth == uint.MIN_VALUE)
							{
								currentHealth = data.readUnsignedInt();
								break;
							}
							if(maxHealth == uint.MIN_VALUE)
							{
								maxHealth = data.readUnsignedInt();
								break;
							}
							if(currentMana == uint.MIN_VALUE)
							{
								currentMana = data.readUnsignedInt();
								break;
							}
							if(maxMana == uint.MIN_VALUE)
							{
								maxMana = data.readUnsignedInt();
								break;
							}
							if(currentEnergy == uint.MIN_VALUE)
							{
								currentEnergy = data.readUnsignedInt();
								break;
							}
							if(maxEnergy == uint.MIN_VALUE)
							{
								maxEnergy = data.readUnsignedInt();
								break;
							}
							if(x == int.MIN_VALUE)
							{
								x = data.readInt();
								break;
							}
							if(y == int.MIN_VALUE)
							{
								y = data.readInt();
								break;
							}
					}
				}
			}
		}
		
		override public function get protocolName():String
		{
			return "Receive_Info_RequestAccountRole";
		}
	}
}