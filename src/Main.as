package 
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.events.*;
import flash.external.ExternalInterface;
import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import model.*;
    import ui.*;
    import ui.piano.*;
    import ui.sheet.*;
    import utils.*;
    
    public class Main extends MainUI implements model.YpadDelegate
    {
        //Add by Acgnu: 容器交互函数
//        {
//            ExternalInterface.addCallback("swfExtGetypURL",function(ypid:String):String
//            {
//                if(null == CLib.clib)
//                {
//                    HUD.show("模块尚未初始化",0);
//                    return null;
//                }
//                return CLib.getURL(int(ypid));
//            });
//        }

        public function Main()
        {
            this.ypad = new model.Ypad();
            this.sound = new flash.media.Sound();
            super();
            if (stage) 
            {
                this.init1();
            }
            else 
            {
                addEventListener(flash.events.Event.ADDED_TO_STAGE, this.init1);
            }
            return;
        }

        internal function init1(arg1:flash.events.Event=null):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.init1);
            stage.quality = flash.display.StageQuality.BEST;
            stage.align = flash.display.StageAlign.TOP_LEFT;
            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            stage.stageFocusRect = false;
            ui.HUD._sp = this;
            ui.HUD._stage = stage;
            utils.Func.initFlashVars(stage);
            //Add by Acgnu
            CLib.myLoadSwf();
            var loc1:*=new flash.ui.ContextMenu();
            loc1.hideBuiltInItems();
            this.contextMenu = loc1;
            initUI();
            this.ypad.delegate = this;
            stage.addEventListener(flash.events.Event.RESIZE, this.onResize111111111111);
            this.onResize111111111111(null);
            backGroundText.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            followBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            stereoBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            pedalBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            fullScreenBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            fullScreenBtn1.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            top_fullScreenBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            volumeBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            slider.addEventListener(flash.events.Event.CHANGE, this.onSpriteEvent);
            sheetPage.addEventListener(flash.events.Event.CHANGE, this.onSpriteEvent);
            volumeSlider.addEventListener(flash.events.Event.CHANGE, this.onSpriteEvent);
            slider.mouseEnabled = false;
            slider.mouseChildren = false;
            pauseBtn.visible = false;
            var loc2:*;
            volumeSlider.value = loc2 = utils.CLib.volume;
            volumeBtn.volume = loc2;
            stereoBtn.selected = utils.CLib.stereoDepth == 0.5;
            addChild(rightButtons);
            rightBtn.alpha = 1;
            addChild(rightBtn);
            rightBtn.mouseEnabled = false;
            rightBtn.mouseChildren = false;
            addChild(album);
            big_playBtn222.visible = false;
            addChild(big_playBtn222);
            addChild(views);
            ui.HUD.show("加载预览图", 0);
            onResize(null);
            prevImg.addEventListener(flash.events.Event.COMPLETE, this.onComplete1);
            prevImg.load(new flash.net.URLRequest(Config.flash_prev_yp_info_URL + "?ypid=" + utils.Func.ypadId + "&t=" + new Date().getTime()));
            utils.Func.gc();
            return;
        }

        public function init2():void
        {
            utils.CLib.stereoDepth = stereoBtn.selected ? 0.5 : 0;
            utils.CLib.volume = volumeSlider.value;
            var loc1:*;
            pedalBtn.selected = loc1 = utils.CLib.yp_is_yanyin;
            utils.CLib.pedal = loc1;
            this.ypad.loadData(utils.CLib.ypad_bArr);
            this.isPlaying = true;
            sheetPage.ypad_getNote = this.ypad.getNote;
            sheetPage.initData(1);
            sheetPage.noteRectcallBack = this.onOnteClick;
            this.sound.addEventListener(flash.events.SampleDataEvent.SAMPLE_DATA, this.onSampleData);
            this.sound.play();
            this.onResize111111111111(null);
            stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.onKeyDown);
            prevBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            nextBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            slider.mouseEnabled = true;
            slider.mouseChildren = true;
            big_playBtn.addEventListener(flash.events.MouseEvent.CLICK, this.playMusic);
            playBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            pauseBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onSpriteEvent);
            stage.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp);
            stage.doubleClickEnabled = true;
            sheetPage.addEventListener(flash.events.MouseEvent.DOUBLE_CLICK, this.onDoubleClick);
            albumBtn.visible = !(utils.Func.albumId == 0);
            album.addEventListener(flash.events.Event.CHANGE, this.onAlbumChange);
            return;
        }

        internal function onAlbumChange(arg1:flash.events.Event):void
        {
            utils.CLib.get_ypad(album.value, this.get_ypad_complete);
            return;
        }

        internal function onComplete1(arg1:flash.events.Event):void
        {
            prevImg.removeEventListener(flash.events.Event.COMPLETE, this.onComplete1);
            big_playBtn222.visible = true;
            ui.HUD.hide();
            var loc1:*=prevImg.getBmp();
            var loc2:*=stage.stageWidth;
            ui.sheet.SheetPage.yp_page_width = loc1.width;
            ui.sheet.SheetPage.yp_page_height = loc1.height;
            sheetPage.initData_1(prevImg);
            this.onResize111111111111(null);
            big_playBtn222.addEventListener(flash.events.MouseEvent.CLICK, this.onClick222);
            playBtn.addEventListener(flash.events.MouseEvent.CLICK, this.onClick222);
            stage.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp222);
            return;
        }

        internal function onKeyUp222(arg1:flash.events.KeyboardEvent):void
        {
            if (arg1.keyCode == 32) 
            {
                this.onClick222(null);
            }
            return;
        }

        internal function onClick222(arg1:flash.events.Event):void
        {
            big_playBtn222.removeEventListener(flash.events.MouseEvent.CLICK, this.onClick222);
            playBtn.removeEventListener(flash.events.MouseEvent.CLICK, this.onClick222);
            stage.removeEventListener(flash.events.KeyboardEvent.KEY_UP, this.onKeyUp222);
            big_playBtn222.alpha = 0;
            utils.CLib.loadSwf(this.onComplete222);
            return;
        }

        internal function onComplete222():void
        {
            album.addEventListener(flash.events.Event.CHANGE, this.onAlbumChange);
            utils.CLib.get_ypad(utils.Func.ypadId, this.get_ypad_complete);
            return;
        }

        internal function get_ypad_complete():void
        {
            ui.HUD.hide();
            if (big_playBtn222) 
            {
                removeChild(big_playBtn222);
                big_playBtn222 = null;
                this.init2();
            }
            else 
            {
                this.all_off();
                this.ypad.loadData(utils.CLib.ypad_bArr);
                sheetPage.initData();
                sheetPage.follow(0, 0, 0, false);
                followBtn.selected = true;
                this.follow(false);
                this.onResize111111111111(null);
            }
            utils.Func.gc();
            return;
        }

        internal function playMusic(arg1:flash.events.Event=null):void
        {
            this.isPlaying = true;
            this.follow();
            followBtn.selected = true;
            return;
        }

        internal function onSpriteEvent(arg1:flash.events.Event):void
        {
            var loc1:*=arg1.currentTarget as flash.display.DisplayObjectContainer;
            var loc2:*=loc1;
            switch (loc2) 
            {
                case stereoBtn:
                {
                    stereoBtn.selected = !stereoBtn.selected;
                    utils.CLib.stereoDepth = stereoBtn.selected ? 0.5 : 0;
                    break;
                }
                case backGroundText:
                {
                    utils.Func.navigate(Config.homePage);
                    break;
                }
                case prevBtn:
                {
                    this.all_off();
                    this.ypad.seek(0);
                    sheetPage.follow(0, 0, 0, true);
                    this.follow();
                    followBtn.selected = true;
                    break;
                }
                case nextBtn:
                {
                    this.all_off();
                    this.ypad.seek(1);
                    this.follow();
                    followBtn.selected = false;
                    this.isPlaying = false;
                    break;
                }
                case playBtn:
                {
                    this.playMusic();
                    break;
                }
                case pauseBtn:
                {
                    this.isPlaying = false;
                    break;
                }
                case volumeBtn:
                {
                    if (volumeSlider.value == 0) 
                    {
                        volumeSlider.value = volumeBtn.volume;
                        volumeBtnICO.gotoAndStop(1);
                    }
                    else 
                    {
                        volumeBtn.volume = volumeSlider.value;
                        volumeSlider.value = 0;
                        volumeBtnICO.gotoAndStop(2);
                    }
                    utils.CLib.volume = volumeSlider.value;
                    break;
                }
                case volumeSlider:
                {
                    if (volumeSlider.value > 0) 
                    {
                        volumeBtnICO.gotoAndStop(1);
                    }
                    else 
                    {
                        volumeBtnICO.gotoAndStop(2);
                    }
                    utils.CLib.volume = volumeSlider.value;
                    break;
                }
                case slider:
                {
                    followBtn.selected = true;
                    this.ypad.seek(slider.value);
                    this.all_off();
                    this.isPlaying = true;
                    this.follow();
                    break;
                }
                case followBtn:
                {
                    followBtn.selected = !followBtn.selected;
                    if (followBtn.selected) 
                    {
                        this.follow();
                    }
                    break;
                }
                case pedalBtn:
                {
                    pedalBtn.selected = loc2 = !pedalBtn.selected;
                    utils.CLib.pedal = loc2;
                    break;
                }
                case fullScreenBtn1:
                case top_fullScreenBtn:
                {
                    utils.Func.fullScreenSwitch(stage);
                    break;
                }
                case fullScreenBtn:
                {
                    utils.Func.fullScreenSwitch(stage);
                    break;
                }
                case sheetPage:
                {
                    followBtn.selected = false;
                    break;
                }
            }
            return;
        }

        public function onResize111111111111(arg1:flash.events.Event):void
        {
            onResize(arg1);
            this.follow(false);
            return;
        }

        public function set isPlaying(arg1:Boolean):void
        {
            if (arg1) 
            {
                followBtn.selected = true;
                playBtn.visible = false;
                big_playBtn.mouseEnabled = false;
                com.greensock.TweenLite.to(big_playBtn, 0.5, {"alpha":0, "ease":com.greensock.easing.Circ.easeOut});
                pauseBtn.visible = true;
                this._isPlaying = true;
            }
            else 
            {
                playBtn.visible = true;
                big_playBtn.mouseEnabled = true;
                com.greensock.TweenLite.to(big_playBtn, 0.5, {"alpha":1, "ease":com.greensock.easing.Circ.easeOut});
                pauseBtn.visible = false;
                this._isPlaying = false;
                utils.CLib.allNoteOff();
            }
            return;
        }

        public function get isPlaying():Boolean
        {
            return this._isPlaying;
        }

        internal function onSampleData(arg1:flash.events.SampleDataEvent):void
        {
            arg1.data.endian = flash.utils.Endian.LITTLE_ENDIAN;
            var loc1:*=new Date().getTime();
            var loc2:*=(loc1 - this.t) / 1000;
            loc2 = 256 / 44100;
            this.t = loc1;
            var loc3:*=0;
            while (loc3 < 8 + 1 * 5) 
            {
                if (this.isPlaying) 
                {
                    this.ypad.play(loc2);
                }
                utils.CLib.play(arg1.data, 256);
                ++loc3;
            }
            this.onFrame();
            return;
        }

        internal function all_off():void
        {
            pianoView.allKeyOff();
            utils.CLib.allNoteOff();
            sheetPage.clearNote();
            return;
        }

        internal function onDoubleClick(arg1:flash.events.Event):void
        {
            this.isPlaying = !this.isPlaying;
            return;
        }

        internal function onKeyDown(arg1:flash.events.KeyboardEvent):void
        {
            var loc1:*=arg1.keyCode;
            if (arg1.ctrlKey) 
            {
                if (loc1 == 37) 
                {
                    loc1 = 188;
                }
                if (loc1 == 39) 
                {
                    loc1 = 190;
                }
            }
            var loc2:*=loc1;
            switch (loc2) 
            {
                case 188:
                {
                    this.ypad.changeSection(-1);
                    this.all_off();
                    this.onFrame();
                    this.isPlaying = false;
                    this.ypad.play(0);
                    this.follow();
                    followBtn.selected = true;
                    break;
                }
                case 190:
                {
                    this.ypad.changeSection(1);
                    this.all_off();
                    this.onFrame();
                    this.isPlaying = false;
                    this.ypad.play(0);
                    this.follow();
                    followBtn.selected = true;
                    break;
                }
                case 37:
                {
                    this.all_off();
                    this.ypad.prevNote();
                    this.isPlaying = false;
                    this.follow();
                    followBtn.selected = true;
                    break;
                }
                case 39:
                {
                    this.ypad.nextNote();
                    this.isPlaying = false;
                    this.follow();
                    followBtn.selected = true;
                    break;
                }
            }
            this.onFrame();
            return;
        }

        internal function onKeyUp(arg1:flash.events.KeyboardEvent):void
        {
            if (arg1.keyCode == 32) 
            {
                this.isPlaying = !this.isPlaying;
            }
            return;
        }

        public function onOnteClick(arg1:model.NoteRect):void
        {
            var loc1:*=this.ypad.onOnteClick(arg1);
            this.all_off();
            this.ypad.seekToTick(loc1);
            this.isPlaying = false;
            this.onFrame();
            return;
        }

        public function onFrame():void
        {
            var loc1:*=null;
            var loc2:*=0;
            slider.value = this.ypad.progress;
            if (!(this.nowSection == this.ypad.nowSection) || !(this.isEnd == this.ypad.isEnd)) 
            {
                this.nowSection = this.ypad.nowSection;
                this.isEnd = this.ypad.isEnd;
                pianoView.allRedyOff();
                if (followBtn.selected) 
                {
                    this.follow();
                }
                if (this.isEnd) 
                {
                    sheetPage.hideSection();
                    return;
                }
                loc1 = this.ypad.getRedy();
                loc2 = 0;
                while (loc2 < loc1.length) 
                {
                    pianoView.redyColor(loc1[loc2][0] - 21, loc1[loc2][1]);
                    ++loc2;
                }
            }
            return;
        }

        internal function follow(arg1:Boolean=true):void
        {
            if (this.ypad.nowSection >= 0) 
            {
                sheetPage.follow(this.ypad.nowPage, this.ypad.y1, this.ypad.y2, arg1);
            }
            return;
        }

        public function onNoteOn(arg1:int, arg2:int, arg3:int):void
        {
            var loc1:*=arg1 - 21;
            utils.CLib.noteOn(loc1, arg2, arg3 / 128);
            pianoView.keyOn(loc1);
            return;
        }

        public function onNoteOff(arg1:int, arg2:int):void
        {
            var loc1:*=arg1 - 21;
            utils.CLib.noteOff(loc1, arg2);
            pianoView.keyOff(loc1);
            return;
        }

        public function onShowNote(arg1:model.NoteRect, arg2:int, arg3:int):void
        {
            if (arg1.visible) 
            {
                sheetPage.showNote(arg1.x1, arg1.y1, arg1.x2, arg1.y2, arg1.page, arg2, arg3);
            }
            return;
        }

        public function onPlayComplete():void
        {
            this.ypad.seek(0);
            sheetPage.follow(0, 0, 0, true);
            this.follow();
            followBtn.selected = true;
            this.isPlaying = false;
            return;
        }

        internal var ypad:model.Ypad;

        internal var sound:flash.media.Sound;

        internal var _isPlaying:Boolean=false;

        internal var t:int=0;

        internal var nowSection:int=-1;

        internal var isEnd:Boolean=false;
    }
}
