package controllers.init
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.core.center.ResourceCenter;
	import com.xgame.utils.manager.LanguageManager;
	
	import mediators.loader.ProgressBarMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadResourcesConfigCommand extends SimpleCommand
	{
		public static const LOAD_RESOURCE_CONFIG: String = "LoaderResourcesConfigCommand.LoadResourceConfig";
		
		public function LoadResourcesConfigCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _loader: XMLLoader = new XMLLoader("config/" + LanguageManager.language + "/resources.xml", {name:"resourcesConfig", onComplete:completeHandler});
			_loader.load();
		}
		
		private function completeHandler(evt: LoaderEvent): void
		{
			ResourceCenter.instance.load("baseResource", null, onLoadComplete, onLoadProgress, onLoadIOError);
			facade.sendNotification(ProgressBarMediator.SHOW_PROGRESSBAR_NOTE);
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			var loader: LoaderCore = evt.currentTarget as LoaderCore;
			facade.sendNotification(ProgressBarMediator.SET_PROGRESSBAR_PERCENT_NOTE, loader.progress);
		}
		
		private function onLoadIOError(evt: LoaderEvent): void
		{
			
		}
	}
}