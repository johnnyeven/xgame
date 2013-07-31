package proxy
{
	import com.xgame.common.commands.CommandList;
	import com.xgame.common.commands.receiving.Receive_Scene_ShowPlayer;
	import com.xgame.common.display.MainPlayerDisplay;
	import com.xgame.common.display.renders.Render;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.configuration.SocketContextConfig;
	import com.xgame.core.center.CommandCenter;
	import com.xgame.core.scene.Scene;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class SceneProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "SceneProxy";
		private static const SCENE_SHOW_PLAYER: int = (SocketContextConfig.ACTION_SHOW_PLAYER << 8) | SocketContextConfig.CONTROLLER_SCENE;
		
		public function SceneProxy(data:Object=null)
		{
			super(NAME, data);
			
			CommandCenter.instance.add(SCENE_SHOW_PLAYER, onPlayerShow);
			CommandList.instance.bind(SCENE_SHOW_PLAYER, Receive_Scene_ShowPlayer);
		}
		
		private function onPlayerShow(protocol: Receive_Scene_ShowPlayer): void
		{
			var _player: MainPlayerDisplay = new MainPlayerDisplay();
			_player.speed = 7;
			_player.positionX = protocol.x;
			_player.positionY = protocol.y;
			_player.graphic = ResourcePool.instance.getResourceData("assets.character.char4");
			var _render: Render = new Render();
			_player.render = _render;
			
			Scene.instance.addObject(_player);
		}
	}
}