package model 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import utils.*;
    
    public class YpadData extends Object
    {
        public function YpadData()
        {
            super();
            return;
        }

        public function loadData(arg1:flash.utils.ByteArray):void
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            this.ypad_version = 0;
            this.page_count = 0;
            this.page_width = 0;
            this.page_height = 0;
            this.total_ticks = 0;
            this.ticks_per_tempo = 0;
            this.track_count = 0;
            this.time = 0;
            this.tracks = new Vector.<model.Track>();
            this.sectionRect = null;
            this.speedTick = null;
            this.speedTempo_per_minute = null;
            var loc1:*=utils.CLib.gzip_uncompress(arg1);
            arg1.position = 0;
            var loc2:*=arg1.readUTFBytes(arg1.length);
            var loc3:*=loc2.split(new RegExp("\\r\\n[a-zA-z]"));
            loc4 = 0;
            while (loc4 < 8) 
            {
                if ((loc6 = loc3[loc4].split("\t"))[0] == "pad_version")
                {
                    this.ypad_version = Number(loc6[1]);
                }
                if (loc6[0] == "age_count")
                {
                    this.page_count = Number(loc6[1]);
                }
                if (loc6[0] == "age_width") 
                {
                    this.page_width = Number(loc6[1]);
                }
                if (loc6[0] == "age_height") 
                {
                    this.page_height = Number(loc6[1]);
                }
                if (loc6[0] == "otal_ticks") 
                {
                    this.total_ticks = Number(loc6[1]);
                }
                if (loc6[0] == "icks_per_tempo") 
                {
                    this.ticks_per_tempo = Number(loc6[1]);
                }
                if (loc6[0] == "rack_count") 
                {
                    this.track_count = Number(loc6[1]);
                }
                if (loc6[0] == "ime") 
                {
                    this.time = Number(loc6[1]);
                }
                ++loc4;
            }
            loc4 = 8;
            loc5 = loc3.length;
            while (loc4 < loc5) 
            {
                this.changeIntArr(loc3[loc4]);
                if (loc3[loc4].indexOf("vent_count") != 0) 
                {
                    if (loc3[loc4].indexOf("ontainer_count") != 0) 
                    {
                        if (loc3[loc4].indexOf("rigin_measure_count") != 0) 
                        {
                            if (loc3[loc4].indexOf("empo_change_event_count") == 0) 
                            {
                                this.decodeSpeed();
                            }
                        }
                        else 
                        {
                            this.decodeSectionRect();
                        }
                    }
                    else 
                    {
                        this.decodeNoteRect();
                    }
                }
                else 
                {
                    this.track = new model.Track();
                    this.tracks.push(this.track);
                    this.decodeTrack();
                }
                ++loc4;
            }
            this.updateTickAndNote();
            this.updateY1();
            this.updateNoteRect();
            this.updateEnd();
            return;
        }

        internal function updateTickAndNote():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            loc1 = 0;
            while (loc1 < this.track_count) 
            {
                loc3 = this.tracks[loc1].tick.length;
                (loc4 = new flash.utils.ByteArray()).endian = flash.utils.Endian.LITTLE_ENDIAN;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc4.writeInt(this.tracks[loc1].tick[loc2]);
                    loc4.writeInt(this.tracks[loc1].note[loc2]);
                    ++loc2;
                }
                utils.CLib.get_array(loc4);
                loc4.position = 0;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    this.tracks[loc1].tick[loc2] = loc4.readInt();
                    this.tracks[loc1].note[loc2] = loc4.readInt();
                    ++loc2;
                }
                ++loc1;
            }
            return;
        }

        internal function updateY1():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=NaN;
            var loc9:*=NaN;
            loc1 = 0;
            while (loc1 < this.track_count) 
            {
                loc2 = 0;
                while (loc2 < this.tracks[loc1].note_rect.length) 
                {
                    loc3 = this.tracks[loc1].note_rect[loc2].section;
                    loc4 = this.tracks[loc1].note_rect[loc2].y1;
                    loc5 = this.tracks[loc1].note_rect[loc2].y2;
                    if (this.sectionRect[loc3].y1 > loc4 && this.tracks[loc1].note_rect[loc2].visible) 
                    {
                        this.sectionRect[loc3].y1 = loc4;
                    }
                    if (this.sectionRect[loc3].y2 < loc5 && this.tracks[loc1].note_rect[loc2].visible) 
                    {
                        this.sectionRect[loc3].y2 = loc5;
                    }
                    ++loc2;
                }
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < this.sectionRowEndIndex.length) 
            {
                loc6 = loc1 > 0 ? this.sectionRowEndIndex[(loc1 - 1)] + 1 : 0;
                loc7 = this.sectionRowEndIndex[loc1];
                loc8 = this.sectionRect[loc6].y1;
                loc9 = this.sectionRect[loc6].y2;
                loc2 = loc6;
                while (loc2 <= loc7) 
                {
                    if (loc8 > this.sectionRect[loc2].y1) 
                    {
                        loc8 = this.sectionRect[loc2].y1;
                    }
                    if (loc9 < this.sectionRect[loc2].y2) 
                    {
                        loc9 = this.sectionRect[loc2].y2;
                    }
                    ++loc2;
                }
                loc2 = loc6;
                while (loc2 <= loc7) 
                {
                    this.sectionRect[loc2].y1 = loc8;
                    this.sectionRect[loc2].y2 = loc9;
                    ++loc2;
                }
                ++loc1;
            }
            return;
        }

        internal function updateNoteRect():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            loc1 = 0;
            while (loc1 < this.track_count) 
            {
                loc2 = 0;
                while (loc2 < this.tracks[loc1].rect_index.length) 
                {
                    loc3 = this.tracks[loc1].rect_index[loc2];
                    if (loc3 >= 0) 
                    {
                        var loc6:*;
                        var loc7:*=((loc6 = this.tracks[loc1].note_rect[loc3]).count + 1);
                        loc6.count = loc7;
                    }
                    ++loc2;
                }
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < this.track_count) 
            {
                loc2 = 0;
                while (loc2 < this.tracks[loc1].rect_index.length) 
                {
                    loc3 = this.tracks[loc1].rect_index[loc2];
                    if (loc3 >= 0) 
                    {
                        if (this.tracks[loc1].note_rect[loc3].tick == null) 
                        {
                            loc5 = this.tracks[loc1].note_rect[loc3].count;
                            this.tracks[loc1].note_rect[loc3].tick = new Vector.<int>(loc5, true);
                            this.tracks[loc1].note_rect[loc3].note = new Vector.<int>(loc5, true);
                        }
                        loc4 = this.tracks[loc1].note_rect[loc3].pos;
                        this.tracks[loc1].note_rect[loc3].tick[loc4] = this.tracks[loc1].tick[loc2];
                        this.tracks[loc1].note_rect[loc3].note[loc4] = this.tracks[loc1].note[loc2];
                        ++loc4;
                        this.tracks[loc1].note_rect[loc3].pos = loc4;
                    }
                    ++loc2;
                }
                ++loc1;
            }
            return;
        }

        internal function updateEnd():void
        {
            var loc1:*=0;
            var loc2:*=0;
            loc1 = 0;
            while (loc1 < this.track_count) 
            {
                loc2 = 0;
                while (loc2 < this.tracks[loc1].rectSectionEndIndex.length) 
                {
                    if (this.tracks[loc1].rectSectionEndIndex[loc2] == -1) 
                    {
                        this.tracks[loc1].rectSectionEndIndex[loc2] = loc2 > 0 ? this.tracks[loc1].rectSectionEndIndex[(loc2 - 1)] : 0;
                    }
                    ++loc2;
                }
                ++loc1;
            }
            loc2 = 0;
            while (loc2 < this.sectionPageEndIndex.length) 
            {
                if (this.sectionPageEndIndex[loc2] == -1) 
                {
                    this.sectionPageEndIndex[loc2] = loc2 > 0 ? this.sectionPageEndIndex[(loc2 - 1)] : 0;
                }
                ++loc2;
            }
            loc2 = 0;
            while (loc2 < this.sectionRowEndIndex.length) 
            {
                if (this.sectionRowEndIndex[loc2] == -1) 
                {
                    this.sectionRowEndIndex[loc2] = loc2 > 0 ? this.sectionRowEndIndex[(loc2 - 1)] : 0;
                }
                ++loc2;
            }
            return;
        }

        internal function changeIntArr(arg1:String):void
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1.split("\r\n");
            this.intArr = null;
            var loc2:*=1;
            while (loc2 < loc1.length) 
            {
                loc3 = loc1[loc2].split("\t");
                if (this.intArr == null) 
                {
                    this.intArr = new Vector.<Vector.<int>>(loc3.length);
                    loc5 = 0;
                    while (loc5 < loc3.length) 
                    {
                        this.intArr[loc5] = new Vector.<int>((loc1.length - 1), true);
                        ++loc5;
                    }
                }
                loc4 = 0;
                while (loc4 < loc3.length) 
                {
                    this.intArr[loc4][(loc2 - 1)] = Number(loc3[loc4]);
                    ++loc4;
                }
                ++loc2;
            }
            if (this.intArr != null) 
            {
                this.intArrLength = this.intArr[0] ? this.intArr[0].length : 0;
            }
            else 
            {
                this.intArrLength = 0;
            }
            return;
        }

        internal function decodeTrack():void
        {
            this.track.tick = this.intArr[1];
            this.track.cmd = this.intArr[2];
            this.track.note = this.intArr[3];
            this.track.velocity = this.intArr[4];
            this.track.rect_index = this.intArr[5];
            return;
        }

        internal function decodeNoteRect():void
        {
            var loc1:*=0;
            var loc3:*=null;
            this.track.note_rect = new Vector.<model.NoteRect>(this.intArrLength, true);
            var loc2:*=0;
            loc1 = 0;
            while (loc1 < this.intArrLength) 
            {
                loc3 = new model.NoteRect();
                loc3.x1 = this.intArr[3][loc1];
                loc3.y1 = this.intArr[4][loc1];
                loc3.x2 = this.intArr[5][loc1];
                loc3.y2 = this.intArr[6][loc1];
                loc3.visible = this.intArr[7][loc1];
                loc3.page = this.intArr[1][loc1];
                loc3.section = this.intArr[2][loc1];
                loc3.track = (this.tracks.length - 1);
                if (loc2 < loc3.section) 
                {
                    loc2 = loc3.section;
                }
                this.track.note_rect[loc1] = loc3;
                ++loc1;
            }
            this.track.rectSectionEndIndex = new Vector.<int>(loc2 + 1, true);
            loc1 = 0;
            while (loc1 < this.track.rectSectionEndIndex.length) 
            {
                this.track.rectSectionEndIndex[loc1] = -1;
                ++loc1;
            }
            loc1 = 0;
            while (loc1 < this.intArrLength) 
            {
                this.track.rectSectionEndIndex[this.intArr[2][loc1]] = loc1;
                ++loc1;
            }
            return;
        }

        internal function decodeSectionRect():void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            this.sectionRect = new Vector.<model.Section>(this.intArrLength, true);
            var loc1:*=0;
            var loc2:*=0;
            loc3 = 0;
            while (loc3 < this.intArrLength) 
            {
                this.sectionRect[loc3] = new model.Section();
                this.sectionRect[loc3].x1 = this.intArr[6][loc3];
                this.sectionRect[loc3].y1 = this.intArr[7][loc3];
                this.sectionRect[loc3].x2 = this.intArr[8][loc3];
                this.sectionRect[loc3].y2 = this.intArr[9][loc3];
                loc4 = this.intArr[2][loc3];
                if (loc1 < loc4) 
                {
                    loc1 = loc4;
                }
                loc5 = this.intArr[1][loc3];
                if (loc2 < loc5) 
                {
                    loc2 = loc5;
                }
                ++loc3;
            }
            this.sectionRowEndIndex = new Vector.<int>(loc1 + 1, true);
            this.sectionPageEndIndex = new Vector.<int>(loc2 + 1, true);
            loc3 = 0;
            while (loc3 < loc1 + 1) 
            {
                this.sectionRowEndIndex[loc3] = -1;
                ++loc3;
            }
            loc3 = 0;
            while (loc3 < loc2 + 1) 
            {
                this.sectionPageEndIndex[loc3] = -1;
                ++loc3;
            }
            loc3 = 0;
            while (loc3 < this.intArrLength) 
            {
                loc4 = this.intArr[2][loc3];
                this.sectionRowEndIndex[loc4] = loc3;
                loc5 = this.intArr[1][loc3];
                this.sectionPageEndIndex[loc5] = loc3;
                ++loc3;
            }
            return;
        }

        internal function decodeSpeed():void
        {
            this.speedTick = new Vector.<int>(this.intArrLength, true);
            this.speedTempo_per_minute = new Vector.<int>(this.intArrLength, true);
            var loc1:*=0;
            while (loc1 < this.intArrLength) 
            {
                this.speedTick[loc1] = this.intArr[0][loc1];
                this.speedTempo_per_minute[loc1] = this.intArr[1][loc1];
                ++loc1;
            }
            return;
        }

        protected var ypad_version:int;

        protected var page_count:int;

        protected var page_width:int;

        protected var page_height:int;

        protected var total_ticks:int;

        protected var ticks_per_tempo:int;

        protected var track_count:int;

        protected var time:int;

        protected var tracks:__AS3__.vec.Vector.<model.Track>;

        protected var sectionRect:__AS3__.vec.Vector.<model.Section>;

        protected var sectionRowEndIndex:__AS3__.vec.Vector.<int>;

        protected var sectionPageEndIndex:__AS3__.vec.Vector.<int>;

        protected var speedTick:__AS3__.vec.Vector.<int>;

        protected var speedTempo_per_minute:__AS3__.vec.Vector.<int>;

        internal var track:model.Track;

        internal var intArr:__AS3__.vec.Vector.<__AS3__.vec.Vector.<int>>;

        internal var intArrLength:int;
    }
}
