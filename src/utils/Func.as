package utils 
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import ui.*;
    
    public class Func extends Object
    {
        public function Func()
        {
            super();
            return;
        }

        public static function initFlashVars(arg1:flash.display.Stage):void
        {
            try 
            {
                albumId = arg1.getChildAt(0).root.loaderInfo.parameters["album"];
                ypadId = arg1.getChildAt(0).root.loaderInfo.parameters["id"];
            }
            catch (e:Error)
            {
            };
            if (ypadId == 0) 
            {
                //Add by Acgnu
                ypadId = 29189;
            }
            return;
        }

        public static function getColor(arg1:int):int
        {
            return [5080063, 16744482, 3257096, 14750438][arg1 % 4];
        }

        public static function navigate(arg1:String):void
        {
            var s:String;

            var loc1:*;
            s = arg1;
            try 
            {
                flash.net.navigateToURL(new flash.net.URLRequest(s));
            }
            catch (e:Error)
            {
                ui.HUD.show("当前网页不允许弹出新窗口");
            }
            return;
        }

        public static function switch_flash_width(arg1:flash.display.Stage):void
        {
            if (arg1.displayState != flash.display.StageDisplayState.FULL_SCREEN) 
            {
                utils.Func.fullScreenSwitch(arg1);
            }
            else 
            {
                arg1.displayState = flash.display.StageDisplayState.NORMAL;
            }
            return;
        }

        public static function fullScreenSwitch(arg1:flash.display.Stage):void
        {
            var stage:flash.display.Stage;

            var loc1:*;
            stage = arg1;
            try 
            {
                stage.displayState = stage.displayState != flash.display.StageDisplayState.FULL_SCREEN ? flash.display.StageDisplayState.FULL_SCREEN : flash.display.StageDisplayState.NORMAL;
            }
            catch (e:Error)
            {
                ui.HUD.show("当前网页不允许使用全屏模式");
            }
            return;
        }

        public static function gc():void
        {
            var loc1:*=null;
            var loc2:*=null;
            try 
            {
                loc1 = new flash.net.LocalConnection();
                loc2 = new flash.net.LocalConnection();
                loc1.connect("name");
                loc2.connect("name");
            }
            catch (e:Error)
            {
            };
            return;
        }

        public static function trace(... rest):void
        {
            return;
        }

        public static function nullFunc(arg1:flash.events.Event):void
        {
            return;
        }

        public static var ypadId:int;

        public static var albumId:int;
    }
}
