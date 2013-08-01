package com.xgame.common.commands.receiving
{
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.utils.Int64;
	import com.xgame.utils.StringUtils;
	import com.xgame.utils.UInt64;
	
	import flash.utils.ByteArray;

	public class Receive_Info_RegisterAccountRole extends ReceivingBase
	{
		public var accountId: Int64;
		public var nickName: String;
		public var accountCash: Int64;
		public var direction: int;
		public var currentHealth: int;
		public var maxHealth: int;
		public var currentMana: int;
		public var maxMana: int;
		public var currentEnergy: int;
		public var maxEnergy: int;
		public var x: Number;
		public var y: Number;
		
		public function Receive_Info_RegisterAccountRole()
		{
			super(SocketContextConfig.REGISTER_ACCOUNT_ROLE);
			direction = int.MIN_VALUE;
			currentHealth = int.MIN_VALUE;
			maxHealth = int.MIN_VALUE;
			currentMana = int.MIN_VALUE;
			maxMana = int.MIN_VALUE;
			currentEnergy = int.MIN_VALUE;
			maxEnergy = int.MIN_VALUE;
			x = Number.MIN_VALUE;
			y = Number.MIN_VALUE;
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
								accountCash = new Int64();
								accountCash.low = data.readUnsignedInt();
								accountCash.high = data.readInt();
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
							if(currentHealth == int.MIN_VALUE)
							{
								currentHealth = data.readInt();
								break;
							}
							if(maxHealth == int.MIN_VALUE)
							{
								maxHealth = data.readInt();
								break;
							}
							if(currentMana == int.MIN_VALUE)
							{
								currentMana = data.readInt();
								break;
							}
							if(maxMana == int.MIN_VALUE)
							{
								maxMana = data.readInt();
								break;
							}
							if(currentEnergy == int.MIN_VALUE)
							{
								currentEnergy = data.readInt();
								break;
							}
							if(maxEnergy == int.MIN_VALUE)
							{
								maxEnergy = data.readInt();
								break;
							}
						case SocketContextConfig.TYPE_DOUBLE:
							if(x == Number.MIN_VALUE)
							{
								x = data.readDouble();
								break;
							}
							if(y == Number.MIN_VALUE)
							{
								y = data.readDouble();
								break;
							}
							break;
					}
				}
			}
		}
		
		override public function get protocolName():String
		{
			return "Receive_Info_RegisterAccountRole";
		}
	}
}