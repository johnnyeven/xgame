package proxy
{
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_Info_RequestHotkey;
	import com.xgame.common.commands.sending.Send_Info_RequestHotkey;
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.core.center.CommandCenter;
	import com.xgame.core.center.HotkeyCenter;
	import com.xgame.utils.Int64;
	
	import controllers.init.LoadInitDataCommand;
	
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import proxy.login.RequestRoleProxy;
	
	public class HotkeyProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "HotkeyProxy";
		
		public function HotkeyProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function requestHotkey(): void
		{
			var _proxy: RequestRoleProxy = facade.retrieveProxy(RequestRoleProxy.NAME) as RequestRoleProxy;
			var _request: Send_Info_RequestHotkey = new Send_Info_RequestHotkey();
			_request.accountId = _proxy.accountId;
			
			CommandList.instance.bind(SocketContextConfig.REQUEST_HOTKEY, Receive_Info_RequestHotkey);
			CommandCenter.instance.add(SocketContextConfig.REQUEST_HOTKEY, onRequestHotkey);
			
			CommandCenter.instance.send(_request);
		}
		
		private function onRequestHotkey(protocol: Receive_Info_RequestHotkey): void
		{
			var code: int;
			var classRef: Class;
			for(var i: uint = 0; i < protocol.config.hotkey.length(); i++)
			{
				code = int(protocol.config.hotkey[i].@code);
				classRef = getDefinitionByName(protocol.config.hotkey[i]["@class"]) as Class;
				HotkeyCenter.instance.bind(code, classRef);
				HotkeyCenter.GlobalEnabled = false;
			}
			facade.sendNotification(LoadInitDataCommand.LOAD_SCENE);
		}
	}
}