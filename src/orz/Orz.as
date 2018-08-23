package orz
{
	import laya.display.Stage;
	import laya.webgl.WebGL;

	public class Orz
	{
		
		public function Orz()
		{
			InitStage();
			
			
		}
		
		
		
		private function InitStage():void{
			
			// 不支持WebGL时自动切换至Canvas
			Laya.init(960, 640, WebGL);
			//DebugTool.init();
			//DebugPanel.init()
			Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			
			Laya.stage.scaleMode = "noscale";
			Laya.stage.bgColor = "#232628";
			new FightUI();
		}
	}
}