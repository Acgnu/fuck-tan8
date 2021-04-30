package ui.sheet 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import model.*;
    import utils.*;
    
    public class SheetPage extends flash.display.Sprite
    {
        public function SheetPage()
        {
            this.maskSp = new flash.display.Sprite();
            this.pageSprite = new flash.display.Sprite();
            this.backSp = new flash.display.Sprite();
            this.pageArr = [];
            this.forMouseMove = new flash.display.Shape();
            this.forSection = [];
            this.time = [];
            super();
            if (stage) 
            {
                this.init();
            }
            else 
            {
                addEventListener(flash.events.Event.ADDED_TO_STAGE, this.init);
            }
            return;
        }

        public function setSize(arg1:Number, arg2:Number):void
        {
            this.maskSp.graphics.clear();
            this.maskSp.graphics.beginFill(13395711, 0.9);
            this.maskSp.graphics.drawRect(0, 0, arg1, arg2);
            this.backSp.graphics.clear();
            this.backSp.graphics.beginFill(6710886, 0.9);
            this.backSp.graphics.drawRect(0, 0, arg1, arg2);
            var loc1:*=20;
            var loc2:*=loc1 / 2;
            arg1 = arg1 - loc1;
            var loc3:*=arg1 > yp_page_width ? yp_page_width : arg1;
            var loc4:*;
            this.pageSprite.scaleY = loc4 = loc3 / yp_page_width;
            this.pageSprite.scaleX = loc4;
            this.scroller.canvasHeight = arg2 - 40;
            this.pageSprite.x = arg1 > yp_page_width ? (arg1 + loc1 - yp_page_width) / 2 : 0 + loc2;
            return;
        }

        internal function init(arg1:flash.events.Event=null):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.init);
            this.pageSprite.mask = this.maskSp;
            addChild(this.maskSp);
            addChild(this.backSp);
            addChild(this.pageSprite);
            this.scroller = new ui.sheet.IPhoneScroll(this.pageSprite, stage);
            this.scroller.callBack = this.onChange;
            return;
        }

        internal function onChange():void
        {
            dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            return;
        }

        internal function onMouseClick(arg1:flash.events.Event):void
        {
            if (this.nowNote && !(this.noteRectcallBack == null)) 
            {
                this.noteRectcallBack(this.nowNote);
            }
            return;
        }

        internal function onMouseMove(arg1:flash.events.Event):void
        {
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=NaN;
            this.nowNote = null;
            this.pageSprite.buttonMode = false;
            this.pageSprite.useHandCursor = false;
            var loc1:*=this.forMouseMove.graphics;
            loc1.clear();
            var loc2:*=this.pageSprite.mouseX;
            if (loc2 > this.pageArr[0].x && loc2 < this.pageArr[0].x + yp_page_width) 
            {
                loc3 = 0;
                while (loc3 < this.pageArr.length) 
                {
                    loc4 = this.pageArr[loc3].mouseX;
                    if ((loc5 = this.pageArr[loc3].mouseY) > 0 && loc5 < yp_page_height) 
                    {
                        this.nowNote = this.ypad_getNote(loc3, loc4, loc5);
                        if (!(this.nowNote == null) && this.nowNote.visible) 
                        {
                            this.pageSprite.buttonMode = true;
                            this.pageSprite.useHandCursor = true;
                            loc1.beginFill(11184810);
                            this.forMouseMove.x = this.nowNote.x1 + this.pageArr[loc3].x;
                            this.forMouseMove.y = this.nowNote.y1 + this.pageArr[loc3].y;
                            loc1.drawRoundRect(0, 0, this.nowNote.x2 - this.nowNote.x1, this.nowNote.y2 - this.nowNote.y1, 10, 10);
                            return;
                        }
                    }
                    ++loc3;
                }
            }
            return;
        }

        public function showSection(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int):void
        {
            var loc1:*;
            (loc1 = this.forSection[15].graphics).clear();
            loc1.lineStyle(5, 13395711);
            this.forSection[15].x = arg1 + this.pageArr[arg5].x;
            this.forSection[15].y = arg2 + this.pageArr[arg5].y;
            loc1.drawRoundRect(0, 0, arg3 - arg1, arg4 - arg2, 10, 10);
            return;
        }

        public function hideSection():void
        {
            var loc1:*=this.forSection[15].graphics;
            loc1.clear();
            return;
        }

        public function clearNote():void
        {
            var loc2:*=null;
            var loc1:*=0;
            while (loc1 < 15) 
            {
                loc2 = this.forSection[loc1].graphics;
                loc2.clear();
                ++loc1;
            }
            return;
        }

        public function showNote(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:int, arg6:int, arg7:int):void
        {
            var loc1:*=this.forSection[arg6].graphics;
            if (this.time[arg6] != arg7) 
            {
                loc1.clear();
                this.time[arg6] = arg7;
            }
            loc1.beginFill(utils.Func.getColor(arg6));
            var loc2:*=arg1 + this.pageArr[arg5].x;
            var loc3:*=arg2 + this.pageArr[arg5].y;
            loc1.drawRoundRect(loc2, loc3, arg3 - arg1, arg4 - arg2, 10, 10);
            return;
        }

        public function initData_1(arg1:ui.sheet.BitmapLoader):void
        {
            this.pageArr[0] = arg1;
            this.pageArr[0].y = 20;
            this.pageSprite.addChild(this.pageArr[0]);
            return;
        }

        public function initData(arg1:int=0):void
        {
            var loc3:*=null;
            while (this.pageSprite.numChildren) 
            {
                this.pageSprite.removeChildAt(0);
            }
            if (arg1 == 1) 
            {
                this.pageSprite.addChild(this.pageArr[0]);
            }
            var loc1:*=arg1;
            while (loc1 < yp_page_count) 
            {
                if (this.pageArr[loc1] == null) 
                {
                    this.pageArr[loc1] = new ui.sheet.BitmapLoader();
                }
                this.pageArr[loc1].load(new flash.net.URLRequest(ypad_url + "." + loc1 + ".png?yp_create_time=" + yp_create_time));
                this.pageArr[loc1].y = 20 + (yp_page_height + 20) * loc1;
                this.pageSprite.addChild(this.pageArr[loc1]);
                ++loc1;
            }
            var loc2:*=0;
            if (this.isinited != false) 
            {
                loc2 = 0;
                while (loc2 < 16) 
                {
                    this.pageSprite.addChild(this.forSection[loc2]);
                    ++loc2;
                }
            }
            else 
            {
                this.isinited = true;
                loc2 = 0;
                while (loc2 < 16) 
                {
                    (loc3 = new flash.display.Shape()).blendMode = flash.display.BlendMode.MULTIPLY;
                    this.forSection[loc2] = loc3;
                    this.pageSprite.addChild(loc3);
                    ++loc2;
                }
                this.forMouseMove.blendMode = flash.display.BlendMode.MULTIPLY;
                this.pageSprite.addChild(this.forMouseMove);
                this.pageSprite.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.pageSprite.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.onMouseMove);
                this.pageSprite.addEventListener(flash.events.MouseEvent.CLICK, this.onMouseClick);
            }
            return;
        }

        public function follow(arg1:int, arg2:Number, arg3:Number, arg4:Boolean):void
        {
            var loc1:*=(-(arg2 + 20 + (yp_page_height + 20) * arg1)) * this.pageSprite.scaleY;
            var loc2:*=(-(arg3 + 20 + (yp_page_height + 20) * arg1)) * this.pageSprite.scaleY;
            var loc3:*=this.pageSprite.y;
            var loc4:*=this.pageSprite.y - this.maskSp.height;
            if (loc1 > loc3 || loc4 > loc2) 
            {
                if (arg4) 
                {
                    com.greensock.TweenLite.to(this.pageSprite, 0.5, {"y":loc1 + 20});
                }
                else 
                {
                    this.pageSprite.y = loc1 + 20;
                }
            }
            return;
        }

        internal function onMouseDown(arg1:flash.events.MouseEvent):void
        {
            if (arg1.target is model.NoteRect) 
            {
                return;
            }
            return;
        }

        internal var maskSp:flash.display.Sprite;

        internal var pageSprite:flash.display.Sprite;

        internal var backSp:flash.display.Sprite;

        public var noteRectcallBack:Function;

        public var ypad_getNote:Function;

        internal var pageArr:Array;

        internal var nowNote:model.NoteRect;

        internal var forMouseMove:flash.display.Shape;

        internal var forSection:Array;

        internal var time:Array;

        internal var scroller:ui.sheet.IPhoneScroll;

        internal var isinited:Boolean=false;

        public static var yp_create_time:int;

        public static var yp_page_count:int;

        public static var yp_page_width:int;

        public static var yp_page_height:int;

        public static var ypad_url:String;
    }
}
