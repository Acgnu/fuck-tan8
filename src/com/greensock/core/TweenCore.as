package com.greensock.core 
{
    import com.greensock.*;
    
    public class TweenCore extends Object
    {
        public function TweenCore(arg1:Number=0, arg2:Object=null)
        {
            super();
            this.vars = arg2 == null ? {} : arg2;
            if (this.vars.isGSVars) 
            {
                this.vars = this.vars.vars;
            }
            var loc2:*;
            this.cachedTotalDuration = loc2 = arg1;
            this.cachedDuration = loc2;
            this._delay = this.vars.delay ? Number(this.vars.delay) : 0;
            this.cachedTimeScale = this.vars.timeScale ? Number(this.vars.timeScale) : 1;
            this.active = Boolean(arg1 == 0 && this._delay == 0 && !(this.vars.immediateRender == false));
            this.cachedTime = loc2 = 0;
            this.cachedTotalTime = loc2;
            this.data = this.vars.data;
            if (!_classInitted) 
            {
                if (isNaN(com.greensock.TweenLite.rootFrame)) 
                {
                    com.greensock.TweenLite.initClass();
                    _classInitted = true;
                }
                else 
                {
                    return;
                }
            }
            var loc1:*=this.vars.timeline is com.greensock.core.SimpleTimeline ? this.vars.timeline : this.vars.useFrames ? com.greensock.TweenLite.rootFramesTimeline : com.greensock.TweenLite.rootTimeline;
            loc1.insert(this, loc1.cachedTotalTime);
            if (this.vars.reversed) 
            {
                this.cachedReversed = true;
            }
            if (this.vars.paused) 
            {
                this.paused = true;
            }
            return;
        }

        public function complete(arg1:Boolean=false, arg2:Boolean=false):void
        {
            if (!arg1) 
            {
                this.renderTime(this.totalDuration, arg2, false);
                return;
            }
            if (this.timeline.autoRemoveChildren) 
            {
                this.setEnabled(false, false);
            }
            else 
            {
                this.active = false;
            }
            if (!arg2) 
            {
                if (this.vars.onComplete && this.cachedTotalTime >= this.cachedTotalDuration && !this.cachedReversed) 
                {
                    this.vars.onComplete.apply(null, this.vars.onCompleteParams);
                }
                else if (this.cachedReversed && this.cachedTotalTime == 0 && this.vars.onReverseComplete) 
                {
                    this.vars.onReverseComplete.apply(null, this.vars.onReverseCompleteParams);
                }
            }
            return;
        }

        public function invalidate():void
        {
            return;
        }

        public function setEnabled(arg1:Boolean, arg2:Boolean=false):Boolean
        {
            this.gc = !arg1;
            if (arg1) 
            {
                this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
                if (!arg2 && this.cachedOrphan) 
                {
                    this.timeline.insert(this, this.cachedStartTime - this._delay);
                }
            }
            else 
            {
                this.active = false;
                if (!arg2 && !this.cachedOrphan) 
                {
                    this.timeline.remove(this, true);
                }
            }
            return false;
        }

        protected function setDirtyCache(arg1:Boolean=true):void
        {
            var loc1:*=arg1 ? this : this.timeline;
            while (loc1) 
            {
                loc1.cacheIsDirty = true;
                loc1 = loc1.timeline;
            }
            return;
        }

        protected function setTotalTime(arg1:Number, arg2:Boolean=false):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (this.timeline) 
            {
                loc1 = this.cachedPaused ? this.cachedPauseTime : this.timeline.cachedTotalTime;
                if (this.cachedReversed) 
                {
                    loc2 = this.cacheIsDirty ? this.totalDuration : this.cachedTotalDuration;
                    this.cachedStartTime = loc1 - (loc2 - arg1) / this.cachedTimeScale;
                }
                else 
                {
                    this.cachedStartTime = loc1 - arg1 / this.cachedTimeScale;
                }
                if (!this.timeline.cacheIsDirty) 
                {
                    this.setDirtyCache(false);
                }
                if (this.cachedTotalTime != arg1) 
                {
                    this.renderTime(arg1, arg2, false);
                }
            }
            return;
        }

        public function kill():void
        {
            this.setEnabled(false, false);
            return;
        }

        public function get delay():Number
        {
            return this._delay;
        }

        public function set delay(arg1:Number):void
        {
            this.startTime = this.startTime + (arg1 - this._delay);
            this._delay = arg1;
            return;
        }

        public function get duration():Number
        {
            return this.cachedDuration;
        }

        public function set duration(arg1:Number):void
        {
            var loc1:*=arg1 / this.cachedDuration;
            var loc2:*;
            this.cachedTotalDuration = loc2 = arg1;
            this.cachedDuration = loc2;
            this.setDirtyCache(true);
            if (this.active && !this.cachedPaused && !(arg1 == 0)) 
            {
                this.setTotalTime(this.cachedTotalTime * loc1, true);
            }
            return;
        }

        public function get totalDuration():Number
        {
            return this.cachedTotalDuration;
        }

        public function set totalDuration(arg1:Number):void
        {
            this.duration = arg1;
            return;
        }

        public function get currentTime():Number
        {
            return this.cachedTime;
        }

        public function set currentTime(arg1:Number):void
        {
            this.setTotalTime(arg1, false);
            return;
        }

        public function get totalTime():Number
        {
            return this.cachedTotalTime;
        }

        public function set totalTime(arg1:Number):void
        {
            this.setTotalTime(arg1, false);
            return;
        }

        public function get startTime():Number
        {
            return this.cachedStartTime;
        }

        public function get reversed():Boolean
        {
            return this.cachedReversed;
        }

        public function set reversed(arg1:Boolean):void
        {
            if (arg1 != this.cachedReversed) 
            {
                this.cachedReversed = arg1;
                this.setTotalTime(this.cachedTotalTime, true);
            }
            return;
        }

        public function restart(arg1:Boolean=false, arg2:Boolean=true):void
        {
            this.reversed = false;
            this.paused = false;
            this.setTotalTime(arg1 ? -this._delay : 0, arg2);
            return;
        }

        public function get paused():Boolean
        {
            return this.cachedPaused;
        }

        public function set paused(arg1:Boolean):void
        {
            if (!(arg1 == this.cachedPaused) && this.timeline) 
            {
                if (arg1) 
                {
                    this.cachedPauseTime = this.timeline.rawTime;
                }
                else 
                {
                    this.cachedStartTime = this.cachedStartTime + (this.timeline.rawTime - this.cachedPauseTime);
                    this.cachedPauseTime = NaN;
                    this.setDirtyCache(false);
                }
                this.cachedPaused = arg1;
                this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
            }
            if (!arg1 && this.gc) 
            {
                this.setEnabled(true, false);
            }
            return;
        }

        public function play():void
        {
            this.reversed = false;
            this.paused = false;
            return;
        }

        public function pause():void
        {
            this.paused = true;
            return;
        }

        public function resume():void
        {
            this.paused = false;
            return;
        }

        public function set startTime(arg1:Number):void
        {
            if (!(this.timeline == null) && (!(arg1 == this.cachedStartTime) || this.gc)) 
            {
                this.timeline.insert(this, arg1 - this._delay);
            }
            else 
            {
                this.cachedStartTime = arg1;
            }
            return;
        }

        public function reverse(arg1:Boolean=true):void
        {
            this.reversed = true;
            if (arg1) 
            {
                this.paused = false;
            }
            else if (this.gc) 
            {
                this.setEnabled(true, false);
            }
            return;
        }

        public function renderTime(arg1:Number, arg2:Boolean=false, arg3:Boolean=false):void
        {
            return;
        }

        public static const version:Number=1.693;

        protected var _delay:Number;

        protected var _hasUpdate:Boolean;

        protected var _rawPrevTime:Number=-1;

        public var vars:Object;

        public var active:Boolean;

        public var initted:Boolean;

        public var timeline:com.greensock.core.SimpleTimeline;

        public var cachedStartTime:Number;

        public var cachedTime:Number;

        public var cachedTotalTime:Number;

        public var cachedDuration:Number;

        public var cachedTotalDuration:Number;

        public var cachedTimeScale:Number;

        public var cachedPauseTime:Number;

        public var cachedReversed:Boolean;

        public var nextNode:com.greensock.core.TweenCore;

        public var prevNode:com.greensock.core.TweenCore;

        public var cachedOrphan:Boolean;

        public var cachedPaused:Boolean;

        public var data:*;

        public var cacheIsDirty:Boolean;

        public var gc:Boolean;

        protected static var _classInitted:Boolean;
    }
}
