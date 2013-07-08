package com.xgame.common.commands.receiving
{
	import com.xgame.configuration.SocketContextConfig;

	public class Receive_Info_RequestHotkey extends ReceivingBase
	{
		public function Receive_Info_RequestHotkey()
		{
			super(SocketContextConfig.ACTION_REQUEST_HOTKEY << 4 | SocketContextConfig.CONTROLLER_INFO);
		}
	}
}