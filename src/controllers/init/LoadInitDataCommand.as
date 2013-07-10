package controllers.init
{
	import mediators.loader.LoadingIconMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadInitDataCommand extends SimpleCommand
	{
		public static const LOAD_INIT_DATA_NOTE: String = "LoadInitDataCommand.LoadInitDataNote";
		
		public function LoadInitDataCommand()
		{
			super();
			facade.registerCommand(LoadSkillResourcesCommand.LOAD_RESOURCES, LoadSkillResourcesCommand);
			facade.registerCommand(LoadSkillResourcesCommand.LOAD_LOGIC, LoadSkillResourcesCommand);
			facade.registerCommand(LoadHotkeyConfigCommand.LOAD_HOTKEY_CONFIG_NOTE, LoadHotkeyConfigCommand);
		}
		
		override public function execute(notification:INotification):void
		{
			facade.removeCommand(LOAD_INIT_DATA_NOTE);
			
			facade.sendNotification(LoadSkillResourcesCommand.LOAD_RESOURCES);
		}
	}
}