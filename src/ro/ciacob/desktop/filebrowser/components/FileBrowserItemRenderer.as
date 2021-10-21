package ro.ciacob.desktop.filebrowser.components {
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	
	import ro.ciacob.desktop.filebrowser.constants.Sizes;
	import ro.ciacob.utils.constants.GenericSizes;

	public class FileBrowserItemRenderer extends Canvas {
		private static const ICON_SIZE:Number = 32;
		private static const LIST_STYLE_NAME:String = 'mx.controls.List';
		private static const TEXT_SIZE:Number = 12.8;

		public function FileBrowserItemRenderer() {
			mouseChildren = false;
			doubleClickEnabled = true;
			_image = new Image;
			_image.width = ICON_SIZE;
			_image.height = ICON_SIZE;
			_image.scaleContent = false;
			_image.x = GenericSizes.SMALL_SPACE;
			_image.y = GenericSizes.TINY_SPACE;
			_text = new Label;
			_text.truncateToFit = true;
			_text.x = ICON_SIZE + GenericSizes.SMALL_SPACE * 2;
		}

		private var _image:Image;
		private var _imageData:Class;
		private var _imageDataChanged:Boolean;
		private var _style:CSSStyleDeclaration;
		private var _text:Label;
		private var _textData:String;
		private var _textDataChanged:Boolean;

		override public function set data(value:Object):void {
			super.data = value;
			if (value != null) {
				if ('icon' in value) {
					_imageData = value['icon'];
					_imageDataChanged = true;
					invalidateProperties();
				}
				if (_textData != value['label']) {
					_textData = value['label'];
					_textDataChanged = true;
					invalidateProperties();
				}
			}
		}

		override protected function childrenCreated():void {
			super.childrenCreated();
			_text.setStyle('fontSize', TEXT_SIZE);
			var manager:IStyleManager2 = IStyleManager2(UIComponent(owner).styleManager);
			_style = manager.getMergedStyleDeclaration(LIST_STYLE_NAME);
			if (_style != null) {
				_text.setStyle('color', _style.getStyle('color'));
			}
			addChild(_image);
			addChild(_text);
		}

		override protected function commitProperties():void {
			super.commitProperties();
			if (_imageDataChanged) {
				_imageDataChanged = false;
				_image.source = _imageData;
			}
			if (_textDataChanged) {
				_textDataChanged = false;
				_text.text = _textData;
			}
		}

		override protected function measure():void {
			super.measure();
			measuredHeight = ICON_SIZE + GenericSizes.TINY_SPACE * 2;
			measuredMinHeight = measuredHeight;
			measuredWidth = (ICON_SIZE + _text.getExplicitOrMeasuredWidth() + GenericSizes.SMALL_SPACE * 3);
			measuredMinWidth = (ICON_SIZE + GenericSizes.SMALL_SPACE * 2);
		}

		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			_updateBackgroundColor(w, h);
			var textH:Number = _text.getExplicitOrMeasuredHeight();
			var textY:Number = (ICON_SIZE - textH) * 0.5 + GenericSizes.TINY_SPACE;
			_text.move(_text.x, textY);
			_text.width = w - ICON_SIZE - GenericSizes.SMALL_SPACE * 3;
		}

		private function _updateBackgroundColor(w:Number, h:Number):void {
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
	}
}
