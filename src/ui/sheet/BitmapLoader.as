package ui.sheet 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import ui.*;
    
    public class BitmapLoader extends flash.display.Sprite
    {
        public function BitmapLoader()
        {
            this.loader = new flash.display.Loader();
            this.urlloader = new flash.net.URLLoader();
            super();
            this.doubleClickEnabled = true;
            this.loader.doubleClickEnabled = true;
            this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.onComplete);
            this.loader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
            this.loader.contentLoaderInfo.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onError);
            addChild(this.loader);
            this.urlloader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
            this.urlloader.addEventListener(flash.events.Event.COMPLETE, this.onCom);
            this.urlloader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onEr);
            this.urlloader.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onEr);
            return;
        }

        public function load(arg1:flash.net.URLRequest):void
        {
            visible = false;
            this.urlloader.load(arg1);
            return;
        }

        internal function onCom(arg1:flash.events.Event):void
        {
            this.loader.loadBytes(this.urlloader.data);
            return;
        }

        internal function onEr(arg1:flash.events.Event):void
        {
            ui.HUD.show("乐谱页加载失败");
            return;
        }

        public function getBmp():flash.display.Bitmap
        {
            return this.bmp;
        }

        internal function onComplete(arg1:flash.events.Event):void
        {
            visible = true;
            this.bmp = this.loader.content as flash.display.Bitmap;
            this.bmp.smoothing = true;
            dispatchEvent(arg1.clone());
            return;
        }

        internal function onError(arg1:flash.events.Event):void
        {
            ui.HUD.show("乐谱页加载失败");
            return;
        }

        internal var bmp:flash.display.Bitmap;

        internal var loader:flash.display.Loader;

        internal var urlloader:flash.net.URLLoader;
    }
}
