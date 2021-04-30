package com.greensock.core 
{
    public class SimpleTimeline extends com.greensock.core.TweenCore
    {
        public function SimpleTimeline(arg1:Object=null)
        {
            super(0, arg1);
            return;
        }

        public function insert(arg1:com.greensock.core.TweenCore, arg2:*=0):com.greensock.core.TweenCore
        {
            var loc1:*=arg1.timeline;
            if (!arg1.cachedOrphan && loc1) 
            {
                loc1.remove(arg1, true);
            }
            arg1.timeline = this;
            arg1.cachedStartTime = Number(arg2) + arg1.delay;
            if (arg1.gc) 
            {
                arg1.setEnabled(true, true);
            }
            if (arg1.cachedPaused && !(loc1 == this)) 
            {
                arg1.cachedPauseTime = arg1.cachedStartTime + (this.rawTime - arg1.cachedStartTime) / arg1.cachedTimeScale;
            }
            if (this._lastChild) 
            {
                this._lastChild.nextNode = arg1;
            }
            else 
            {
                this._firstChild = arg1;
            }
            arg1.prevNode = this._lastChild;
            this._lastChild = arg1;
            arg1.nextNode = null;
            arg1.cachedOrphan = false;
            return arg1;
        }

        public function remove(arg1:com.greensock.core.TweenCore, arg2:Boolean=false):void
        {
            if (arg1.cachedOrphan) 
            {
                return;
            }
            if (!arg2) 
            {
                arg1.setEnabled(false, true);
            }
            if (arg1.nextNode) 
            {
                arg1.nextNode.prevNode = arg1.prevNode;
            }
            else if (this._lastChild == arg1) 
            {
                this._lastChild = arg1.prevNode;
            }
            if (arg1.prevNode) 
            {
                arg1.prevNode.nextNode = arg1.nextNode;
            }
            else if (this._firstChild == arg1) 
            {
                this._firstChild = arg1.nextNode;
            }
            arg1.cachedOrphan = true;
            return;
        }

        public override function renderTime(arg1:Number, arg2:Boolean=false, arg3:Boolean=false):void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc1:*=this._firstChild;
            this.cachedTotalTime = arg1;
            this.cachedTime = arg1;
            while (loc1) 
            {
                loc3 = loc1.nextNode;
                if (loc1.active || arg1 >= loc1.cachedStartTime && !loc1.cachedPaused && !loc1.gc) 
                {
                    if (loc1.cachedReversed) 
                    {
                        loc2 = loc1.cacheIsDirty ? loc1.totalDuration : loc1.cachedTotalDuration;
                        loc1.renderTime(loc2 - (arg1 - loc1.cachedStartTime) * loc1.cachedTimeScale, arg2, false);
                    }
                    else 
                    {
                        loc1.renderTime((arg1 - loc1.cachedStartTime) * loc1.cachedTimeScale, arg2, false);
                    }
                }
                loc1 = loc3;
            }
            return;
        }

        public function get rawTime():Number
        {
            return this.cachedTotalTime;
        }

        protected var _firstChild:com.greensock.core.TweenCore;

        protected var _lastChild:com.greensock.core.TweenCore;

        public var autoRemoveChildren:Boolean;
    }
}
