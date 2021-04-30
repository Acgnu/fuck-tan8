package model 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import utils.*;
    
    public class Ypad extends model.YpadData
    {
        public function Ypad()
        {
            super();
            return;
        }

        public override function loadData(arg1:flash.utils.ByteArray):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            this.speedPos = 0;
            this.nowTick = 0;
            this.nowSection = -1;
            this.isEnd = false;
            this.nowPage = 0;
            super.loadData(arg1);
            this.tracksPos = new Vector.<int>(track_count, true);
            this.nowSpeed = speedTempo_per_minute[0];
            var loc1:*=0;
            while (loc1 < 2) 
            {
                loc2 = tracks[loc1];
                loc3 = "";
                loc4 = 0;
                while (loc4 < loc2.tick.length) 
                {
                    if (loc2.velocity[loc4] != 0) 
                    {
                        loc3 = loc3 + ("{" + loc2.tick[loc4] + "," + loc2.note[loc4] + "," + loc2.velocity[loc4] + "},");
                    }
                    ++loc4;
                }
                ++loc1;
            }
            return;
        }

        public function play(arg1:Number):void
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            this.nowTick = this.nowTick + arg1 * this.nowSpeed / 60 * ticks_per_tempo;
            this.updateSpeed(false);
            this.isEnd = false;
            var loc1:*=0;
            var loc2:*=0;
            while (loc2 < track_count) 
            {
                loc3 = tracks[loc2];
                if ((loc4 = this.tracksPos[loc2]) == (loc3.note.length - 1)) 
                {
                    ++loc1;
                }
                while (loc4 < loc3.tick.length && loc3.tick[loc4] <= this.nowTick) 
                {
                    if ((loc5 = loc3.rect_index[loc4]) >= 0) 
                    {
                        this.nowSection = loc3.note_rect[loc5].section;
                        this.nowPage = loc3.note_rect[loc5].page;
                    }
                    if (loc3.cmd[loc4] != 0) 
                    {
                        if (loc3.cmd[loc4] == 1 || loc3.cmd[loc4] == 2) 
                        {
                            this.delegate.onNoteOn(loc3.note[loc4], loc2, loc3.velocity[loc4]);
                            this.delegate.onShowNote(loc3.note_rect[loc3.rect_index[loc4]], loc2, loc3.tick[loc4]);
                        }
                    }
                    else 
                    {
                        this.delegate.onNoteOff(loc3.note[loc4], loc2);
                    }
                    ++loc4;
                }
                if (loc4 >= loc3.note.length) 
                {
                    loc4 = (loc3.note.length - 1);
                    this.isEnd = true;
                }
                this.tracksPos[loc2] = loc4;
                ++loc2;
            }
            if (loc1 == track_count) 
            {
                this.delegate.onPlayComplete();
            }
            return;
        }

        public function seek(arg1:Number):void
        {
            var loc1:*=0;
            if (arg1 != 0) 
            {
                if (arg1 != 1) 
                {
                    this.seekToTick(total_ticks * arg1);
                }
                else 
                {
                    loc1 = 0;
                    while (loc1 < track_count) 
                    {
                        this.tracksPos[loc1] = (tracks[loc1].note.length - 1);
                        ++loc1;
                    }
                    this.nowTick = total_ticks;
                    this.nowPage = (page_count - 1);
                    this.nowSection = (sectionRect.length - 1);
                }
            }
            else 
            {
                loc1 = 0;
                while (loc1 < track_count) 
                {
                    this.tracksPos[loc1] = 0;
                    ++loc1;
                }
                this.nowTick = 0;
                this.nowPage = 0;
                this.nowSection = 0;
            }
            this.updateSpeed();
            return;
        }

        public function seekToTick(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            this.nowTick = arg1;
            var loc1:*=0;
            while (loc1 < track_count) 
            {
                loc2 = tracks[loc1];
                this.tracksPos[loc1] = 0;
                loc3 = this.tracksPos[loc1];
                while (loc2.tick[loc3] < this.nowTick) 
                {
                    ++loc3;
                    if ((loc4 = loc2.rect_index[loc3]) >= 0) 
                    {
                        this.nowSection = loc2.note_rect[loc4].section;
                        this.nowPage = loc2.note_rect[loc4].page;
                    }
                    if (!(loc3 >= (loc2.note.length - 1))) 
                    {
                        continue;
                    }
                    break;
                }
                this.tracksPos[loc1] = loc3;
                ++loc1;
            }
            this.updateSpeed();
            this.play(0);
            return;
        }

        public function prevNote():void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc1:*=-1;
            loc2 = 0;
            while (loc2 < track_count) 
            {
                loc5 = tracks[loc2];
                loc4 = this.tracksPos[loc2];
                while (loc4 > 0) 
                {
                    loc3 = loc5.rect_index[loc4];
                    if (!(loc3 == -1) && loc5.note_rect[loc3].visible && loc5.tick[loc4] < this.nowTick) 
                    {
                        if (loc1 == -1 || loc1 < loc5.tick[loc4]) 
                        {
                            loc1 = loc5.tick[loc4];
                        }
                        break;
                    }
                    --loc4;
                }
                ++loc2;
            }
            if (loc1 == -1) 
            {
                loc1 = this.nowTick;
            }
            loc2 = 0;
            while (loc2 < track_count) 
            {
                loc5 = tracks[loc2];
                loc4 = this.tracksPos[loc2];
                while (loc4 > 0 && (loc5.tick[loc4] >= loc1 || loc5.rect_index[loc4] == -1)) 
                {
                    --loc4;
                }
                this.tracksPos[loc2] = loc4;
                ++loc2;
            }
            this.nowTick = loc1;
            this.updateSpeed();
            this.play(0);
            return;
        }

        public function nextNote():void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc1:*=-1;
            loc2 = 0;
            while (loc2 < track_count) 
            {
                loc5 = tracks[loc2];
                loc4 = this.tracksPos[loc2];
                while (loc4 < loc5.rect_index.length) 
                {
                    loc3 = loc5.rect_index[loc4];
                    if (!(loc3 == -1) && loc5.note_rect[loc3].visible && loc5.tick[loc4] > this.nowTick) 
                    {
                        if (loc1 == -1 || loc1 > loc5.tick[loc4]) 
                        {
                            loc1 = loc5.tick[loc4];
                        }
                        break;
                    }
                    ++loc4;
                }
                ++loc2;
            }
            if (loc1 == -1) 
            {
                loc1 = total_ticks;
            }
            this.nowTick = loc1;
            this.play(0);
            return;
        }

        public function changeSection(arg1:int):void
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            if (arg1 == 0) 
            {
                return;
            }
            if (this.nowSection + arg1 < 0) 
            {
                return;
            }
            if (this.nowSection + arg1 >= sectionRect.length) 
            {
                return;
            }
            this.nowSection = this.nowSection + arg1;
            var loc1:*=-1;
            var loc2:*=0;
            while (loc2 < track_count) 
            {
                loc3 = tracks[loc2];
                this.tracksPos[loc2] = 0;
                loc4 = this.tracksPos[loc2];
                while (loc3.rect_index[loc4] == -1 || loc3.note_rect[loc3.rect_index[loc4]].section < this.nowSection) 
                {
                    ++loc4;
                }
                if (loc1 == -1 || loc1 > loc3.tick[loc4]) 
                {
                    loc1 = loc3.tick[loc4];
                }
                if ((loc5 = loc3.rect_index[loc4]) >= 0) 
                {
                    this.nowPage = loc3.note_rect[loc5].page;
                }
                this.tracksPos[loc2] = loc4;
                ++loc2;
            }
            this.nowTick = loc1;
            this.updateSpeed();
            return;
        }

        internal function updateSpeed(arg1:Boolean=true):void
        {
            if (arg1) 
            {
                this.speedPos = 0;
            }
            while (this.speedPos < speedTick.length && this.nowTick > speedTick[this.speedPos]) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this).speedPos + 1);
                loc1.speedPos = loc2;
            }
            this.nowSpeed = speedTempo_per_minute[this.speedPos > 0 ? (this.speedPos - 1) : 0];
            return;
        }

        public function getRedy():Array
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=0;
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < track_count) 
            {
                loc3 = tracks[loc2];
                loc4 = this.nowSection > 0 ? loc3.rectSectionEndIndex[(this.nowSection - 1)] + 1 : 0;
                loc5 = loc3.rectSectionEndIndex[this.nowSection];
                loc6 = loc4;
                while (loc6 <= loc5) 
                {
                    loc7 = loc3.note_rect[loc6].note;
                    loc8 = 0;
                    while (loc8 < loc7.length) 
                    {
                        loc1.push([loc7[loc8], utils.Func.getColor(loc2)]);
                        ++loc8;
                    }
                    ++loc6;
                }
                ++loc2;
            }
            return loc1;
        }

        public function getNote(arg1:int, arg2:Number, arg3:Number):model.NoteRect
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc1:*=arg1 > 0 ? sectionPageEndIndex[(arg1 - 1)] + 1 : 0;
            var loc2:*=sectionPageEndIndex[arg1];
            loc5 = loc1;
            while (loc5 <= loc2) 
            {
                if (sectionRect[loc5].x1 < arg2 && sectionRect[loc5].x2 > arg2 && sectionRect[loc5].y1 < arg3 && sectionRect[loc5].y2 > arg3) 
                {
                    loc6 = 0;
                    while (loc6 < track_count) 
                    {
                        loc3 = loc5 > 0 ? tracks[loc6].rectSectionEndIndex[(loc5 - 1)] + 1 : 0;
                        loc4 = tracks[loc6].rectSectionEndIndex[loc5];
                        loc7 = loc3;
                        while (loc7 <= loc4) 
                        {
                            if ((loc8 = tracks[loc6].note_rect[loc7]).x1 < arg2 && loc8.x2 > arg2 && loc8.y1 < arg3 && loc8.y2 > arg3) 
                            {
                                return loc8;
                            }
                            ++loc7;
                        }
                        ++loc6;
                    }
                }
                ++loc5;
            }
            return null;
        }

        public function onOnteClick(arg1:model.NoteRect):int
        {
            var loc4:*=0;
            var loc1:*=Math.abs(this.nowTick - arg1.tick[0]);
            var loc2:*=0;
            var loc3:*=0;
            while (loc3 < arg1.tick.length) 
            {
                loc4 = Math.abs(this.nowTick - arg1.tick[loc3]);
                if (loc1 > loc4) 
                {
                    loc1 = loc4;
                    loc2 = loc3;
                }
                ++loc3;
            }
            return arg1.tick[loc2];
        }

        public function get x1():Number
        {
            return sectionRect[this.nowSection].x1;
        }

        public function get y1():Number
        {
            return sectionRect[this.nowSection].y1;
        }

        public function get x2():Number
        {
            return sectionRect[this.nowSection].x2;
        }

        public function get y2():Number
        {
            return sectionRect[this.nowSection].y2;
        }

        public function get progress():Number
        {
            if (total_ticks != 0) 
            {
                return this.nowTick / total_ticks;
            }
            return 0;
        }

        internal var speedPos:int=0;

        internal var tracksPos:__AS3__.vec.Vector.<int>;

        internal var nowSpeed:int;

        internal var nowTick:Number=0;

        public var nowSection:int=-1;

        public var isEnd:Boolean=false;

        public var nowPage:int=0;

        public var delegate:model.YpadDelegate;
    }
}
