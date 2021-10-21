package ro.ciacob.desktop.filebrowser.windowable {
	
	import flash.display.Screen;
	
	import mx.events.FlexEvent;
	
	import ro.ciacob.desktop.filebrowser.components.FileBrowser;
	import ro.ciacob.desktop.windows.IWindowContent;
	import ro.ciacob.desktop.windows.IWindowsManager;
	import ro.ciacob.desktop.windows.WindowContentBehavior;

	public class WindowableFileBrowser extends FileBrowser implements IWindowContent {
		
		public function WindowableFileBrowser() {
			_windowContentDelegate = new WindowContentBehavior (this);				
		}
			
		private var _windowContentDelegate : WindowContentBehavior;
		
		public function get homeScreen () : Screen {
			return _windowContentDelegate.homeScreen;
		}
		
		public function get windowUid ():String {
			return _windowContentDelegate.windowUid;
		}
		
		public function get allScreensX () : Number {
			return _windowContentDelegate.allScreensX;
		}
		
		public function get allScreensY () : Number {
			return _windowContentDelegate.allScreensY;
		}
		
		public function get currentScreensX () : Number {
			return _windowContentDelegate.currentScreensX;
		}
		
		public function get currentScreensY () : Number {
			return _windowContentDelegate.currentScreensY;
		}
		
		public function set manager (value : IWindowsManager) : void {
			_windowContentDelegate.manager = value;
		}
		
		public function get manager () : IWindowsManager {
			return _windowContentDelegate.manager;
		}
			
	}
}