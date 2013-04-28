package controllers
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.common.display.BitmapDisplay;
	import com.xgame.common.display.BitmapMovieDispaly;
	import com.xgame.common.display.ResourceData;
	import com.xgame.common.display.renders.Render;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.configuration.GlobalContextConfig;
	import com.xgame.core.center.ResourceCenter;
	import com.xgame.utils.Reflection;
	import com.xgame.utils.debug.Stats;
	import com.xgame.utils.manager.TimerManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ApplicationCommand extends SimpleCommand
	{
		private var _main: main;
		private var _list: Array;
		public function ApplicationCommand()
		{
			super();
			_list = new Array();
		}
		
		override public function execute(notification:INotification):void
		{
			var _lc: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			LoaderMax.activate([ImageLoader, SWFLoader]);
			LoaderMax.defaultContext = _lc;
			
			var _loader: XMLLoader = new XMLLoader("config/resources.xml", {name:"resourcesConfig", onComplete:completeHandler});
			_loader.load();
			_main = notification.getBody() as main;
			
			var _debugLayer: Sprite = new Sprite();
			var _debugStats: Stats = new Stats();
			_debugLayer.addChild(_debugStats);
			_main.stage.addChild(_debugLayer);
			_main.stage.addEventListener(MouseEvent.CLICK, createPlayer);
		}
		
		private function completeHandler(evt: LoaderEvent): void
		{
			ResourceCenter.instance.load("loginResources", false, "", onLoadComplete);
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			for(var i: uint = 0; i < 1; i++)
			{
				createPlayer();
			}
			TimerManager.instance.add(33, render);
		}
		
		private function createPlayer(evt: Event = null): void
		{
			var _display: BitmapMovieDispaly = new BitmapMovieDispaly();
			_main.addChild(_display);
			
			_display.x = Math.random() * 1000;
			_display.y = Math.random() * 600;
			_display.inUse = true;
			_display.isLoop = true;
			var _index: uint = Math.floor((Math.random() * 14)) + 1;
			_display.graphic = ResourcePool.instance.getResourceData("assets.character.char" + _index);
			var _render: Render = new Render();
			_display.render = _render;
			_list.push(_display);
		}
		
		private function render(): void
		{
			var _display: BitmapMovieDispaly;
			for each(_display in _list)
			{
				_display.update();
			}
			GlobalContextConfig.Timer = getTimer();
		}
	}
}