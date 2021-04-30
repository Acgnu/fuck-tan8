package 
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import ui.*;
    import ui.listview.*;
    import ui.panels.*;
    import ui.piano.*;
    import ui.sheet.*;
    import utils.*;
    
    public class MainUI extends flash.display.Sprite
    {
        public function MainUI()
        {
            this.prevImg = new ui.sheet.BitmapLoader();
            this.big_playBtn222 = new UI_PlayBtn();
            this.backGroundSp = new flash.display.Sprite();
            this.pvLeft = new flash.display.Sprite();
            this.pvRight = new flash.display.Sprite();
            this.pianoView = new ui.piano.PianoView();
            this.sheetPage = new ui.sheet.SheetPage();
            this.big_playBtn = new UI_PlayBtn();
            super();
            return;
        }

        public function onResize(arg1:flash.events.Event):void
        {
            this.w = stage.stageWidth;
            this.h = stage.stageHeight;
            this.g = this.backGroundSp.graphics;
            if (this.big_playBtn222) 
            {
                this.big_playBtn222.x = this.w / 2;
                this.big_playBtn222.y = this.h / 2;
            }
            this.albumBtn.x = this.w - 128;
            this.album.x = this.w - this.album.width;
            this.album.y = 33;
            this.album.h = this.h - 33 - 52;
            this.views.x = this.w / 2;
            this.views.y = this.h / 2;
            this.rightButtons.x = this.w - this.rightButtons.width + 2;
            this.rightButtons.y = (this.h - this.rightButtons.height) / 2;
            this.rightBtn.x = this.w - this.rightBtn.width / 2 - 10;
            this.rightBtn.y = this.h / 2;
            if (this.w < 540)
            {
                this.w = 540;
            }
            if (this.h < 300)
            {
                this.h = 300;
            }
            this.big_playBtn.x = 60;
            this.big_playBtn.y = this.h - 100;
            this.top_fullScreenBtn.x = this.w - 48;
            this.g.clear();
            this.dr(9145227, 0, 0, 0, 0);
            this.dr(7631988, 1, 0, 1, 1);
            this.dr(13816530, 1, 1, 1, 1);
            this.dr(11974326, 2, 1, 2, 1);
            this.dr(15066597, 8, 7, 33, 51);
            this.dr(6710886, 8, 8, 33, 52);
            this.dr(11250603, 9, 9, 34, 53);
            this.dr(14474460, 10, 9, 35, 53);
            var loc1:*=30 * 52;
            var loc2:*=133;
            this.pianoView.width = this.w - 32 > loc1 ? loc1 : this.w - 32;
            this.pianoView.height = this.pianoView.width * loc2 / loc1;
            this.pianoView.x = (this.w - this.pianoView.width) / 2;
            this.pianoView.x = Math.floor(this.pianoView.x);
            this.pianoView.y = 45;
            var loc3:*=this.pianoView.height + this.pianoView.y + 10;
            this.dr(6710886, 9, 9, loc3, 53);
            this.dr(4737096, 9, 9, loc3 + 1, 53);
            this.dr(5658198, 9, 9, loc3 + 2, 53);
            this.dr(6250335, 9, 9, loc3 + 3, 53);
            this.dr(6710886, 9, 9, loc3 + 4, 53);
            this.sheetPage.x = 11;
            this.sheetPage.y = loc3 + 2;
            this.sheetPage.setSize(this.w - 22, this.h - loc3 - 53 - 2);
            this.slider.w = this.w - 8 * 2;
            this.pvRight.x = this.w;
            var loc4:*;
            this.pvLeft.y = loc4 = this.h - 32;
            this.pvRight.y = loc4;
            this.followBtn.selected = true;
            return;
        }

        public function initUI():void
        {
            this.slider = new ui.Slider(800, 6);
            this.volumeBtnICO = new UI_Volume();
            this.volumeSlider = new ui.Slider(80, 6);
            this.views = new ui.panels.Views();
            this.album = new ui.listview.Album();
            this.rightButtons = new ui.RightButtons();
            this.rightBtn = new RightBtn();
            addChild(this.backGroundSp);
            this.backGroundText = new ui.UIButton(this, null, Config.title, 8, 5, 280);
            var loc2:*;
            var loc3:*=((loc2 = this.backGroundText.labelText).y + 1);
            loc2.y = loc3;
            var loc1:*=new flash.text.TextFormat(null, 12);
            loc1.align = flash.text.TextFormatAlign.LEFT;
            this.backGroundText.labelText.setTextFormat(loc1);
            this.albumBtn = new ui.UIButton(this, null, "专辑列表", 0, 5, 80);
            this.albumBtn.visible = false;
            this.album.visible = false;
            this.albumBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onAlbumBtnClick);
            this.slider.x = 8;
            this.slider.y = -14;
            this.pvLeft.addChild(this.slider);
            this.playBtn = new ui.UIButton(this.pvLeft, new UI_Play(), "", 58, -3, 50, 31);
            this.pauseBtn = new ui.UIButton(this.pvLeft, new UI_Pause(), "", 58, -3, 50, 31);
            this.prevBtn = new ui.UIButton(this.pvLeft, new UI_Prev(), "", 8);
            this.prevBtn.tishi = "回到开头";
            this.nextBtn = new ui.UIButton(this.pvLeft, new UI_Next(), "", 58 + 50);
            this.nextBtn.tishi = "到末尾";
            this.fullScreenBtn = new ui.UIButton(this.pvRight, new UI_FullScreen(), "全屏", -60 - 8, 0, 60);
            this.fullScreenBtn1 = new ui.UIButton(this.pvRight, new UI_Full2(), "还原", -60 - 8, 0, 60);
            this.fullScreenBtn1.visible = false;
            this.top_fullScreenBtn = new ui.UIButton(this, new UI_Full2(), "", 0, 5, 40);
            this.top_fullScreenBtn.visible = false;
            this.volumeBtn = new ui.UIButton(this.pvRight, this.volumeBtnICO, "", -198, 0, 25);
            this.volumeBtnICO.gotoAndStop(1);
            this.volumeSlider.x = -170;
            this.volumeSlider.y = 10;
            this.pvRight.addChild(this.volumeSlider);
            this.stereoBtn = new ui.UIButton(this.pvRight, null, "立体声", -260 - 0 * 50);
            this.pedalBtn = new ui.UIButton(this.pvRight, null, "延音", -260 - 1 * 50);
            this.followBtn = new ui.UIButton(this.pvRight, null, "跟踪", -260 - 2 * 50);
            this.followBtn.selected = true;
            addChild(this.pvRight);
            addChild(this.pianoView);
            addChild(this.sheetPage);
            addChild(this.pvLeft);
            this.big_playBtn.alpha = 0;
            this.big_playBtn.mouseEnabled = false;
            addChild(this.big_playBtn);
            this.sheetPage.y = this.pianoView.height + 20;
            stage.addEventListener(flash.events.FullScreenEvent.FULL_SCREEN, this.fullScreenHandler);
            this.backGroundSp.doubleClickEnabled = true;
            this.backGroundSp.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onBackGroundSpDoubleClick);
            this.rightButtons.addEventListener(flash.events.Event.CHANGE, this.onRightButtonsChange);
            this.rightButtons.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onRightButtonsMouseOver);
            this.rightButtons.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onRightButtonsMouseOut);
            this.rightButtons.alpha = 0;
            return;
        }

        internal function onAlbumBtnClick(arg1:flash.events.Event):void
        {
            this.album.visible = !this.album.visible;
            return;
        }

        internal function fullScreenHandler(arg1:flash.events.FullScreenEvent):void
        {
            var loc1:*;
            this.top_fullScreenBtn.visible = loc1 = arg1.fullScreen;
            this.fullScreenBtn1.visible = loc1;
            this.fullScreenBtn.visible = !arg1.fullScreen;
            return;
        }

        internal function onBackGroundSpDoubleClick(arg1:flash.events.Event):void
        {
            utils.Func.fullScreenSwitch(stage);
            return;
        }

        internal function onRightButtonsMouseOver(arg1:flash.events.Event):void
        {
            com.greensock.TweenLite.to(this.rightButtons, 0.5, {"alpha":1, "ease":com.greensock.easing.Circ.easeOut});
            com.greensock.TweenLite.to(this.rightBtn, 0.5, {"alpha":0, "ease":com.greensock.easing.Circ.easeOut});
            return;
        }

        internal function onRightButtonsMouseOut(arg1:flash.events.Event):void
        {
            com.greensock.TweenLite.to(this.rightButtons, 0.5, {"alpha":0, "ease":com.greensock.easing.Circ.easeOut});
            com.greensock.TweenLite.to(this.rightBtn, 0.5, {"alpha":1, "ease":com.greensock.easing.Circ.easeOut});
            return;
        }

        internal function onRightButtonsChange(arg1:flash.events.Event):void
        {
            if (this.rightButtons.value != 0) 
            {
                this.views.show((this.rightButtons.value - 1));
            }
            else 
            {
                utils.Func.switch_flash_width(stage);
            }
            return;
        }

        internal function dr(arg1:int, arg2:int, arg3:int, arg4:int, arg5:int):void
        {
            this.g.beginFill(arg1);
            this.g.drawRect(arg2, arg4, this.w - arg2 - arg3, this.h - arg4 - arg5);
            this.g.endFill();
            return;
        }

        public var playBtn:ui.UIButton;

        public var pauseBtn:ui.UIButton;

        public var prevBtn:ui.UIButton;

        public var nextBtn:ui.UIButton;

        public var followBtn:ui.UIButton;

        public var pedalBtn:ui.UIButton;

        public var stereoBtn:ui.UIButton;

        public var fullScreenBtn:ui.UIButton;

        public var fullScreenBtn1:ui.UIButton;

        public var top_fullScreenBtn:ui.UIButton;

        public var slider:ui.Slider;

        public var volumeBtn:ui.UIButton;

        public var pvLeft:flash.display.Sprite;

        public var volumeSlider:ui.Slider;

        public var views:ui.panels.Views;

        public var album:ui.listview.Album;

        public var rightButtons:ui.RightButtons;

        public var rightBtn:RightBtn;

        public var albumBtn:ui.UIButton;

        public var prevImg:ui.sheet.BitmapLoader;

        internal var ______Album________________________________________________________________________________________:int;

        public var big_playBtn222:flash.display.SimpleButton;

        internal var ______fullScreen________________________________________________________________________________________:int;

        public var backGroundSp:flash.display.Sprite;

        public var backGroundText:ui.UIButton;

        internal var ______rightButtons________________________________________________________________________________________:int;

        public var pvRight:flash.display.Sprite;

        public var pianoView:ui.piano.PianoView;

        public var sheetPage:ui.sheet.SheetPage;

        public var volumeBtnICO:UI_Volume;

        internal var w:Number;

        internal var h:Number;

        internal var g:flash.display.Graphics;

        public var big_playBtn:flash.display.SimpleButton;

        internal var ________buju_____________________________________________________________________________________:int;
    }
}
