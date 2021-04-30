package utils 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import ui.*;
    import ui.sheet.*;
    
    public class CLib extends Object
    {
        public function CLib()
        {
            super();
            return;
        }

        public static function set volume(arg1:Number):void
        {
            so.data.volume = arg1;
            if (clib) 
            {
                clib.synth_setVolume(arg1);
            }
            return;
        }

        public static function set stereoDepth(arg1:Number):void
        {
            so.data.stereoDepth = arg1;
            if (clib) 
            {
                clib.synth_setStereoDepth(arg1 != 0 ? 0.3 : 0);
            }
            return;
        }

        public static function loadSwf(arg1:Function):void
        {
            swfLoadCompleteCallBack = arg1;
            if(null == CLib.clib)
            {
                swfLoader.contentLoaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS, onSwfProgress);
                swfLoader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, onSwError);
                swfLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onSwComplete);
                ui.HUD.show("加载音色库", 0);
                swfLoader.load(new flash.net.URLRequest(Config.flash_sound_lib_URL));
            } else {
                swfLoadCompleteCallBack();
            }
            return;
        }

        //Add by Acgnu
        public static function myLoadSwf() : void
        {
            swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onSoundsReady);
            swfLoader.load(new URLRequest(Config.flash_sound_lib_URL));
        }

        internal static function onSwError(arg1:flash.events.Event):void
        {
            ui.HUD.show("加载音色库出错", 0);
            return;
        }

        internal static function onSwfProgress(arg1:flash.events.Event):void
        {
            ui.HUD.show("加载音色库 " + int(arg1.target.bytesLoaded / arg1.target.bytesTotal * 100) + "%", 0);
            return;
        }

        internal static function onSwComplete(arg1:flash.events.Event):void
        {
            swfLoader.contentLoaderInfo.removeEventListener(flash.events.ProgressEvent.PROGRESS, onSwfProgress);
            swfLoader.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, onSwError);
            swfLoader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, onSwComplete);
            var loc1:*=swfLoader.contentLoaderInfo.applicationDomain;
            var loc2:*=loc1.getDefinition("Sounds") as Class;
            utils.CLib.clib = loc2.cLibInit();
            swfLoadCompleteCallBack();
            return;
        }

        //Add by Acgnu
        internal static function onSoundsReady(arg1:Event) : void
        {
            swfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onSoundsReady);
            var loc1:* = swfLoader.contentLoaderInfo.applicationDomain;
            var loc2:* = loc1.getDefinition("Sounds") as Class;
            CLib.clib = loc2.cLibInit();
            if(utils.Func.ypadId != 0) {
                //由于 flash_debugger 不可交互, 修改为启动时将琴谱地址上传, 宿主判断是否下载
                var url:* = CLib.getURL(utils.Func.ypadId);
                //http://www.77music.com/flash_get_yp_info.php?ypid=66138&amp;sccode=77c83a7bf44542486ff37815ab75c147&amp;r1=9185&amp;r2=6640&amp;input=123
                 var args:* = "?" + url.split("?")[1]
                urlLoader3 = new flash.net.URLLoader();
                urlLoader3.load(new flash.net.URLRequest(Config.flash_yuepu_fetch_URL + args));
            }
        }

        public static function set pedal(arg1:Boolean):void
        {
            if (clib) 
            {
                clib.synth_setPedal(arg1);
            }
            return;
        }

        public static function play(arg1:flash.utils.ByteArray, arg2:int):void
        {
            if (clib) 
            {
                clib.synth_play(arg1, arg2);
            }
            return;
        }

        public static function noteOn(arg1:int, arg2:int, arg3:Number):void
        {
            if (clib) 
            {
                clib.synth_noteOn(arg1, arg2, arg3);
            }
            return;
        }

        public static function noteOff(arg1:int, arg2:int):void
        {
            if (clib) 
            {
                clib.synth_noteOff(arg1, arg2);
            }
            return;
        }

        public static function allNoteOff():void
        {
            if (clib) 
            {
                clib.synth_allNoteOff();
            }
            return;
        }

        
        {
            swfLoader = new flash.display.Loader();
            so = flash.net.SharedObject.getLocal("77player", "/");
        }

        public static function get_ypad(arg1:int, arg2:Function):void
        {
            if (urlLoader == null) 
            {
                urlLoader = new flash.net.URLLoader();
                urlLoader.addEventListener(flash.events.Event.COMPLETE, onComplete1);
                urlLoader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, onError);
                urlLoader.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, onError);
                urlLoader2 = new flash.net.URLLoader();
                urlLoader2.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
                urlLoader2.addEventListener(flash.events.Event.COMPLETE, onComplete2);
                urlLoader2.addEventListener(flash.events.ProgressEvent.PROGRESS, onProgress);
                urlLoader2.addEventListener(flash.events.IOErrorEvent.IO_ERROR, onError);
                urlLoader2.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, onError);
            }
            callBack_s = arg2;
            utils.Func.trace(getURL(arg1));
            urlLoader.load(new flash.net.URLRequest(getURL(arg1)));
            ui.HUD.show("加载乐谱 0%", 0);
            return;
        }

        public static function onComplete1(arg1:flash.events.Event):void
        {
            var loc1:*=new XML(urlLoader.data);
            ui.sheet.SheetPage.yp_create_time = loc1.body.yp_create_time;
            ui.sheet.SheetPage.yp_page_count = loc1.body.yp_page_count;
            ui.sheet.SheetPage.yp_page_width = loc1.body.yp_page_width;
            ui.sheet.SheetPage.yp_page_height = loc1.body.yp_page_height;
            ui.sheet.SheetPage.ypad_url = loc1.body.ypad_url;
            ypad_url2 = loc1.body.ypad_url2;
            yp_is_yanyin = loc1.body.yp_is_yanyin == "1";
            if (ypad_url2 != "") 
            {
                urlLoader2.load(new flash.net.URLRequest(ypad_url2));
            }
            else 
            {
                ui.HUD.show(urlLoader.data, 0);
            }
            return;
        }

        public static function onComplete2(arg1:flash.events.Event):void
        {
            ypad_bArr = urlLoader2.data;
            callBack_s();
            return;
        }

        public static function onError(arg1:int):void
        {
            ui.HUD.show("加载乐谱出错", 0);
            return;
        }

        public static function onProgress(arg1:flash.events.Event):void
        {
            ui.HUD.show("加载乐谱 " + int(arg1.target.bytesLoaded / arg1.target.bytesTotal * 100) + "%", 0);
            return;
        }

        public static function gzip_uncompress(arg1:flash.utils.ByteArray):Boolean
        {
            arg1.position = 0;
            return clib.gzip_uncompress(arg1, arg1.length);
        }

        public static function get_array(arg1:flash.utils.ByteArray):void
        {
            arg1.position = 0;
            clib.get_array(arg1, arg1.length);
            return;
        }

        public static function getURL(arg1:int):String
        {
            return clib.getURL(arg1);
        }

        public static function get volume():Number
        {
            return so.data.volume != null ? so.data.volume : 1;
        }

        public static function get stereoDepth():Number
        {
            return so.data.stereoDepth != null ? so.data.stereoDepth : 0.5;
        }

        internal static var swfLoader:flash.display.Loader;

        internal static var swfLoadCompleteCallBack:Function;

        internal static var urlLoader:flash.net.URLLoader;

        internal static var urlLoader2:flash.net.URLLoader;

        internal static var urlLoader3:flash.net.URLLoader;

        internal static var callBack_s:Function;

        public static var ypad_bArr:flash.utils.ByteArray;

        public static var ypad_url2:String;

        public static var yp_is_yanyin:Boolean;

        public static var clib:Object;

        internal static var so:flash.net.SharedObject;
    }
}
