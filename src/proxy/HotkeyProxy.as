package proxy
{
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_Info_RequestHotkey;
	import com.xgame.common.commands.sending.Send_Info_RequestHotkey;
	import com.xgame.core.center.CommandCenter;
	import com.xgame.utils.Int64;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import proxy.login.RequestRoleProxy;
	
	public class HotkeyProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "HotkeyProxy";
		
		private static const REQUEST_HOTKEY: uint = 0x0060;
		
		public function HotkeyProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function requestHotkey(): void
		{
			var _proxy: RequestRoleProxy = facade.retrieveProxy(RequestRoleProxy.NAME) as RequestRoleProxy;
			var _request: Send_Info_RequestHotkey = new Send_Info_RequestHotkey();
			_request.accountId = _proxy.accountId;
			
			CommandList.instance.bind(REQUEST_HOTKEY, Receive_Info_RequestHotkey);
			CommandCenter.instance.add(REQUEST_HOTKEY, onRequestHotkey);
			
			CommandCenter.instance.send(_request);
		}
		
		private function onRequestHotkey(): void
		{
			
		}
	}
}