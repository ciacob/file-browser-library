package ro.ciacob.desktop.filebrowser {
	import ro.ciacob.utils.Strings;

	/**
	 * WINDOWS ONLY
	 * Class represents one entry in a classical Windows file filter. Complete with self equality test,
	 * and a utility function for batch testing (use it to compare two arrays of FileFilterEntry objects).
	 */
	public class FileFilterEntry {

		public static function areSetsEqual(setA:Array, setB:Array):Boolean {
			if (setA == null && setB == null) {
				return true;
			}
			if (setA == null || setB == null) {
				return false;
			}
			if (setA.length != setB.length) {
				return false;
			}
			for (var i:int = 0; i < setA.length; i++) {
				var entryFromA:FileFilterEntry = (setA[i] as FileFilterEntry);
				if (entryFromA == null) {
					return false;
				}
				var entryFromB:FileFilterEntry = (setB[i] as FileFilterEntry);
				if (entryFromB == null) {
					return false;
				}
				if (!entryFromA.equals(entryFromB)) {
					return false;
				}
			}
			return true;
		}

		public function FileFilterEntry(description:String, ... fileExtensions:Array) {
			_description = Strings.trim(description);
			_fileExtensions = [];
			for (var i:int = 0; i < fileExtensions.length; i++) {
				var fileType:String = (fileExtensions[i] as String);
				if (fileType != null) {
					fileType = Strings.remove(fileType, '.');
					fileType = Strings.remove(fileType, '*');
					fileType = Strings.trim(fileType);
					fileType = fileType.toLowerCase();
					if (!Strings.isEmpty(fileType)) {
						_fileExtensions.push(fileType);
					}
				}
			}
		}

		private var _description:String;
		private var _fileExtensions:Array;

		public function get description():String {
			return _description;
		}

		public function equals(anotherEntry:FileFilterEntry):Boolean {
			if (_description != anotherEntry.description) {
				return false;
			}
			if (_fileExtensions.length != anotherEntry.fileExtensions.length) {
				return false;
			}
			for (var i:int = 0; i < fileExtensions.length; i++) {
				if (fileExtensions[i] != anotherEntry.fileExtensions[i]) {
					return false;
				}
			}
			return true;
		}

		/**
		 * Copy, not reference
		 */
		public function get fileExtensions():Array {
			return _fileExtensions.concat();
		}
	}
}
