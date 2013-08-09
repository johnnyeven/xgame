package proxy.interaction
{
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_Move_RequestFindPath;
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.core.center.CommandCenter;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class MoveProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "MoveProxy";
		
		public function MoveProxy(data:Object=null)
		{
			super(NAME, data);
			
			CommandCenter.instance.add(SocketContextConfig.REQUEST_FIND_PATH, onRequestFindPath);
			CommandList.instance.bind(SocketContextConfig.REQUEST_FIND_PATH, Receive_Move_RequestFindPath);
		}
		
		private function onRequestFindPath(protocol: Receive_Move_RequestFindPath): void
		{
			
		}
	}
}