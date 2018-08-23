package orz
{
	public class OSpriteManager
	{
		public function OSpriteManager()
		{
			
			
		}
		
		
		
		
		
		
		private static var _instance:OSpriteManager;
		
		public static function get instance():OSpriteManager
		{
			if(_instance==null){
				_instance = new OSpriteManager();
			}
			return _instance;
		}
		
	}
}