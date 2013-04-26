package controllers
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.core.center.ResourceCenter;
	import com.xgame.utils.Reflection;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ApplicationCommand extends SimpleCommand
	{
		private var _main: main;
		public function ApplicationCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _lc: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			LoaderMax.activate([ImageLoader, SWFLoader]);
			LoaderMax.defaultContext = _lc;
			
			var _loader: XMLLoader = new XMLLoader("config/resources.xml", {name:"resourcesConfig", onComplete:completeHandler});
			_loader.load();
			_main = notification.getBody() as main;
		}
		
		private function completeHandler(evt: LoaderEvent): void
		{
			ResourceCenter.instance.load("loginResources", false, "", onLoadComplete);
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			var _loader: SWFLoader = LoaderMax.getLoader("loginUI") as SWFLoader;
//			var _class: Class = _loader.getClass('assets.skin.login.bg');
			var _bitmapData: BitmapData = Reflection.createBitmapData("assets.skin.login.bg");
			_main.addChild(new Bitmap(_bitmapData));
		}
	}
}