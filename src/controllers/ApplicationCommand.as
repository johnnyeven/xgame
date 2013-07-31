package controllers
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.common.behavior.Behavior;
	import com.xgame.common.behavior.MainPlayerBehavior;
	import com.xgame.common.behavior.MonsterBehavior;
	import com.xgame.common.display.ActionDisplay;
	import com.xgame.common.display.BitmapDisplay;
	import com.xgame.common.display.BitmapMovieDispaly;
	import com.xgame.common.display.MonsterDisplay;
	import com.xgame.common.display.ResourceData;
	import com.xgame.common.display.renders.Render;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.configuration.GlobalContextConfig;
	import com.xgame.core.Camera;
	import com.xgame.core.center.HotkeyCenter;
	import com.xgame.core.center.ResourceCenter;
	import com.xgame.core.scene.Scene;
	import com.xgame.enum.Action;
	import com.xgame.enum.Direction;
	import com.xgame.events.scene.SceneEvent;
	import com.xgame.ns.NSCamera;
	import com.xgame.utils.Reflection;
	import com.xgame.utils.debug.Stats;
	import com.xgame.utils.manager.TimerManager;
	
	import controllers.init.LoadResourcesConfigCommand;
	import controllers.login.LoadLoginResourcesCommand;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	
	import mediators.MainMediator;
	import mediators.loader.LoadingIconMediator;
	import mediators.loader.ProgressBarMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ApplicationCommand extends SimpleCommand
	{
		private var _main: main;
		private var _scene: Scene;
		private var _mouseX: Number;
		private var _mouseY: Number;
		
		public function ApplicationCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _lc: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			LoaderMax.activate([ImageLoader, SWFLoader]);
			LoaderMax.defaultContext = _lc;
			
			_main = notification.getBody() as main;
			
			initCommand();
			initMediator();
			initProxy();
			
			facade.sendNotification(LoadResourcesConfigCommand.LOAD_RESOURCE_CONFIG);
		}
		
		private function initCommand(): void
		{
			facade.registerCommand(LoadResourcesConfigCommand.LOAD_RESOURCE_CONFIG, LoadResourcesConfigCommand);
		}
		
		private function initMediator(): void
		{
			facade.registerMediator(new MainMediator(_main));
			facade.registerMediator(new LoadingIconMediator());
			facade.registerMediator(new ProgressBarMediator());
		}
		
		private function initProxy(): void
		{
			
		}
		
	}
}