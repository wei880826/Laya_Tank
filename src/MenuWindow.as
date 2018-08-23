package
{

	
	import fairygui.GButton;
	import fairygui.GComponent;
	import fairygui.GList;
	
	import laya.net.Loader;
	import laya.utils.Handler;

	public class MenuWindow
	{
		private var _view:GComponent;
		private var _list:GList;
		public function MenuWindow()
		{
			Laya.loader.load([
				{ url: "res/ui/UI_Common@atlas0.png", type: Loader.IMAGE },
				{ url: "res/ui/UI_Common.fui", type: Loader.BUFFER }
			], Handler.create(this, this.onLoaded));
 
		}
		
//		private function __clickItem(itemObject:fairygui.GObject):void{
//			var item: fairygui.GButton = itemObject as fairygui.GButton;
//				this._view.getChild("n3").asLoader.url = item.icon;
//				this._view.getChild("n5").text = item.icon;
//		}
		private function onLoaded():void{
			Laya.stage.addChild(fairygui.GRoot.inst.displayObject);
			fairygui.UIPackage.addPackage("res/ui/UI_Common");
			_view = fairygui.UIPackage.createObject("UI_Common","MenuWindow").asCom;
			fairygui.GRoot.inst.addChild(_view);
			
			var btn_startGame:GButton = _view.getChild("btn_startGame").asButton;
			
			btn_startGame.onClick(this,this.onStartGame);
			
			
			var refreshBtn:GButton = _view.getChild("refreshBtn").asButton;
			refreshBtn.onClick(this,this.onRefresh);
			
			
		}
		
		private function onStartGame():void{
			_view.visible =false;
			
			new FightScene();
			
		}
		public function onRefresh():void{
			
			trace("onRefresh");
			
		}
	}
}