package mediators.loader
{
	import com.greensock.TweenLite;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.utils.UIUtils;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import mediators.MainMediator;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LoadingIconMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "LoadingIconMediator";
		
		public static const LOADING_SHOW_NOTE: String = "loading_show_note";
		public static const LOADING_HIDE_NOTE: String = "loading_hide_note";
		
		public function LoadingIconMediator()
		{
			super(NAME, ResourcePool.instance.getDisplayObject("assets.ui.LoadingIconSkin"));
		}
		
		public function get component(): MovieClip
		{
			return viewComponent as MovieClip;
		}
		
		override public function listNotificationInterests(): Array
		{
			return [LOADING_SHOW_NOTE, LOADING_HIDE_NOTE];
		}
		
		override public function handleNotification(notification:INotification): void
		{
			switch(notification.getName())
			{
				case LOADING_SHOW_NOTE:
					showLoading();
					break;
				case LOADING_HIDE_NOTE:
					hideLoading();
					break;
			}
		}
		
		private function showLoading(): void
		{
			var main: MainMediator = (facade.retrieveMediator(MainMediator.NAME)) as MainMediator;
			component.alpha = 0;
			UIUtils.center(component);
			if(!main.contains(component))
			{
				main.addChild(component);
			}
			TweenLite.to(component, .5, {
				alpha: 1
			});
		}
		
		private function hideLoading(): void
		{
			var main: MainMediator = (facade.retrieveMediator(MainMediator.NAME)) as MainMediator;
			component.alpha = 1;
			TweenLite.to(component, .5, {
				alpha: 0,
				onComplete: function(): void {
					if(main.contains(component))
					{
						main.removeChild(component);
					}
				}
			});
		}
	}
}