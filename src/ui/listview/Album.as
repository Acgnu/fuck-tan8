package ui.listview 
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.net.*;
    import utils.*;
    
    public class Album extends flash.display.Sprite
    {
        public function Album()
        {
            this.yp_titleArr = [];
            this.yp_idArr = [];
            this.listSp = new flash.display.Sprite();
            this.maskSp = new flash.display.Sprite();
            super();
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < 4) 
            {
                loc1[loc2] = new flash.display.Sprite();
                loc1[loc2].graphics.beginFill(16777215, 0.5 + loc2 * 0.2);
                loc1[loc2].graphics.drawRoundRect(0, 0, 10, 40, 10, 10);
                ++loc2;
            }
            this.sp = new flash.display.SimpleButton(loc1[0], loc1[1], loc1[2], loc1[3]);
            this.sp.x = 200 - 10;
            this.sp.y = 0;
            this.sp.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.listSp.mask = this.maskSp;
            this.h = 200;
            this.pos = 0;
            addChild(this.listSp);
            addChild(this.maskSp);
            this.filters = [new flash.filters.DropShadowFilter(5, 135)];
            if (utils.Func.albumId == 0) 
            {
                return;
            }
            this.urlLoader = new flash.net.URLLoader();
            this.urlLoader.addEventListener(flash.events.Event.COMPLETE, this.onComplete);
            this.urlLoader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
            this.urlLoader.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.onError);
            this.urlLoader.load(new flash.net.URLRequest(Config.flash_get_album_info_URL + "?albumid=" + utils.Func.albumId));
            return;
        }

        internal function onMouseDown(arg1:flash.events.Event):void
        {
            this.temp = mouseY - this.sp.y;
            stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseMove);
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onMouseUp);
            return;
        }

        internal function onMouseMove(arg1:flash.events.Event):void
        {
            this.sp.y = mouseY - this.temp;
            if (this.sp.y < 0) 
            {
                this.sp.y = 0;
            }
            if (this.sp.y > this.maskSp.height - this.sp.height) 
            {
                this.sp.y = this.maskSp.height - this.sp.height;
            }
            this.updateListSpY();
            return;
        }

        internal function onMouseUp(arg1:flash.events.Event):void
        {
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseMove);
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onMouseUp);
            return;
        }

        internal function updateListSpY():void
        {
            this.listSp.y = (-(this.listSp.height - this.maskSp.height)) * this.pos;
            return;
        }

        public function set pos(arg1:Number):void
        {
            this.sp.y = (this.maskSp.height - this.sp.height) * arg1;
            return;
        }

        public function get pos():Number
        {
            return this.sp.y / (this.maskSp.height - this.sp.height);
        }

        public function set h(arg1:Number):void
        {
            var loc1:*=this.pos;
            this.maskSp.graphics.clear();
            this.maskSp.graphics.beginFill(0, 0.8);
            this.maskSp.graphics.drawRect(0, 0, 200, arg1);
            graphics.clear();
            graphics.beginFill(0, 0.6);
            graphics.drawRect(0, 0, 200, arg1);
            this.pos = loc1;
            this.updateListSpY();
            return;
        }

        public function get h():Number
        {
            return this.maskSp.height;
        }

        internal function onClick(arg1:flash.events.Event):void
        {
            this.lastCell.selected = false;
            this.lastCell = arg1.currentTarget as ui.listview.CellButton;
            this.lastCell.selected = true;
            if (this.value != this.yp_idArr[this.lastCell.id]) 
            {
                this.value = this.yp_idArr[this.lastCell.id];
                dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            }
            return;
        }

        internal function onComplete(arg1:flash.events.Event):void
        {
            var loc3:*=null;
            var loc1:*=new XML(this.urlLoader.data);
            this.album_title = loc1.body.album_title;
            this.yp_count = loc1.body.yp_count;
            var loc2:*=0;
            while (loc2 < this.yp_count) 
            {
                this.yp_titleArr[loc2] = loc1.body["yp_title_" + (loc2 + 1)].slice(21 * 0);
                this.yp_idArr[loc2] = loc1.body["yp_id_" + (loc2 + 1)];
                (loc3 = new ui.listview.CellButton(this.listSp, " " + (loc2 + 1) + "." + this.yp_titleArr[loc2], 0, loc2 * 30, 200 - 10)).id = loc2;
                loc3.addEventListener(flash.events.MouseEvent.CLICK, this.onClick);
                if (loc2 == 0) 
                {
                    this.lastCell = loc3;
                }
                ++loc2;
            }
            this.lastCell.selected = true;
            this.value = this.yp_idArr[this.lastCell.id];
            addChild(this.sp);
            return;
        }

        internal function onError(arg1:flash.events.Event):void
        {
            return;
        }

        internal var urlLoader:flash.net.URLLoader;

        internal var album_title:String;

        internal var yp_count:int;

        internal var yp_titleArr:Array;

        internal var yp_idArr:Array;

        internal var lastCell:ui.listview.CellButton;

        public var value:int;

        internal var sp:flash.display.SimpleButton;

        internal var listSp:flash.display.Sprite;

        internal var maskSp:flash.display.Sprite;

        internal var temp:Number;
    }
}
