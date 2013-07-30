package proxy
{
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_Base_VerifyMap;
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.core.center.CommandCenter;
	import com.xgame.utils.debug.Debug;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class MapProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "MapProxy";
		private static const BASE_VERIFY_MAP: int = (SocketContextConfig.ACTION_VERIFY_MAP << 4) | SocketContextConfig.CONTROLLER_BASE;
		
		public function MapProxy(data:Object=null)
		{
			super(NAME, data);
			
			CommandCenter.instance.add(BASE_VERIFY_MAP, onMapDataReceive);
			CommandList.instance.bind(BASE_VERIFY_MAP, Receive_Base_VerifyMap);
		}
		
		private function onMapDataReceive(protocol: Receive_Base_VerifyMap): void
		{
			if(protocol.mapId != int.MIN_VALUE)
			{
				setData(protocol);
			}
			else
			{
				Debug.error(this, "地图验证信息错误，未获取到MapID");
			}
		}
	}
}