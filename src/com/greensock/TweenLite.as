package com.greensock 
{
    import com.greensock.core.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class TweenLite extends com.greensock.core.TweenCore
    {
        public function TweenLite(arg1:Object, arg2:Number, arg3:Object)
        {
            var loc2:*=null;
            super(arg2, arg3);
            if (arg1 == null) 
            {
                throw new Error("Cannot tween a null object.");
            }
            this.target = arg1;
            if (this.target is com.greensock.core.TweenCore && this.vars.timeScale) 
            {
                this.cachedTimeScale = 1;
            }
            this.propTweenLookup = {};
            this._ease = defaultEase;
            this._overwrite = !(Number(arg3.overwrite) > -1) || !overwriteManager.enabled && arg3.overwrite > 1 ? overwriteManager.mode : int(arg3.overwrite);
            var loc1:*;
            if (loc1 == masterList[arg1]) 
            {
                if (this._overwrite != 1) 
                {
                    loc1[loc1.length] = this;
                }
                else 
                {
                    var loc3:*=0;
                    var loc4:*=loc1;
                    for each (loc2 in loc4) 
                    {
                        if (loc2.gc) 
                        {
                            continue;
                        }
                        loc2.setEnabled(false, false);
                    }
                    masterList[arg1] = [this];
                }
            }
            else 
            {
                masterList[arg1] = [this];
            }
            if (this.active || this.vars.immediateRender) 
            {
                this.renderTime(0, false, true);
            }
            return;
        }

        protected function easeProxy(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            return this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams));
        }

        public static function initClass():void
        {
            rootFrame = 0;
            rootTimeline = new com.greensock.core.SimpleTimeline(null);
            rootFramesTimeline = new com.greensock.core.SimpleTimeline(null);
            rootTimeline.cachedStartTime = flash.utils.getTimer() * 0.001;
            rootFramesTimeline.cachedStartTime = rootFrame;
            rootTimeline.autoRemoveChildren = true;
            rootFramesTimeline.autoRemoveChildren = true;
            _shape.addEventListener(flash.events.Event.ENTER_FRAME, updateAll, false, 0, true);
            if (overwriteManager == null) 
            {
                overwriteManager = {"mode":1, "enabled":false};
            }
            return;
        }

        protected static function easeOut(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*;
            arg1 = loc1 = 1 - arg1 / arg4;
            return 1 - loc1 * arg1;
        }

        
        {
            plugins = {};
            fastEaseLookup = new flash.utils.Dictionary(false);
            killDelayedCallsTo = TweenLite.killTweensOf;
            defaultEase = TweenLite.easeOut;
            masterList = new flash.utils.Dictionary(false);
            _shape = new flash.display.Shape();
            _reservedProps = {"ease":1, "delay":1, "overwrite":1, "onComplete":1, "onCompleteParams":1, "useFrames":1, "runBackwards":1, "startAt":1, "onUpdate":1, "onUpdateParams":1, "onStart":1, "onStartParams":1, "onInit":1, "onInitParams":1, "onReverseComplete":1, "onReverseCompleteParams":1, "onRepeat":1, "onRepeatParams":1, "proxiedEase":1, "easeParams":1, "yoyo":1, "onCompleteListener":1, "onUpdateListener":1, "onStartListener":1, "onReverseCompleteListener":1, "onRepeatListener":1, "orientToBezier":1, "timeScale":1, "immediateRender":1, "repeat":1, "repeatDelay":1, "timeline":1, "data":1, "paused":1, "reversed":1};
        }

        public static function to(arg1:Object, arg2:Number, arg3:Object):com.greensock.TweenLite
        {
            return new TweenLite(arg1, arg2, arg3);
        }

        public static function from(arg1:Object, arg2:Number, arg3:Object):com.greensock.TweenLite
        {
            if (arg3.isGSVars) 
            {
                arg3 = arg3.vars;
            }
            arg3.runBackwards = true;
            if (!("immediateRender" in arg3)) 
            {
                arg3.immediateRender = true;
            }
            return new TweenLite(arg1, arg2, arg3);
        }

        public static function delayedCall(arg1:Number, arg2:Function, arg3:Array=null, arg4:Boolean=false):com.greensock.TweenLite
        {
            return new TweenLite(arg2, 0, {"delay":arg1, "onComplete":arg2, "onCompleteParams":arg3, "immediateRender":false, "useFrames":arg4, "overwrite":0});
        }

        protected static function updateAll(arg1:flash.events.Event=null):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            rootTimeline.renderTime((flash.utils.getTimer() * 0.001 - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale, false, false);
            rootFrame = rootFrame + 1;
            rootFramesTimeline.renderTime((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale, false, false);
            if (!(rootFrame % 60)) 
            {
                loc1 = masterList;
                var loc5:*=0;
                var loc6:*=loc1;
                for (loc2 in loc6) 
                {
                    loc4 = (loc3 = loc1[loc2]).length;
                    while (--loc4 > -1) 
                    {
                        if (!TweenLite(loc3[loc4]).gc) 
                        {
                            continue;
                        }
                        loc3.splice(loc4, 1);
                    }
                    if (loc3.length != 0) 
                    {
                        continue;
                    }
                    delete loc1[loc2];
                }
            }
            return;
        }

        public static function killTweensOf(arg1:Object, arg2:Boolean=false, arg3:Object=null):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            if (arg1 in masterList) 
            {
                loc2 = (loc1 = masterList[arg1]).length;
                while (--loc2 > -1) 
                {
                    if ((loc3 = loc1[loc2]).gc) 
                    {
                        continue;
                    }
                    if (arg2) 
                    {
                        loc3.complete(false, false);
                    }
                    if (arg3 != null) 
                    {
                        loc3.killVars(arg3);
                    }
                    if (!(arg3 == null || loc3.cachedPT1 == null && loc3.initted)) 
                    {
                        continue;
                    }
                    loc3.setEnabled(false, false);
                }
                if (arg3 == null) 
                {
                    delete masterList[arg1];
                }
            }
            return;
        }

        protected function init():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=undefined;
            var loc4:*=false;
            var loc5:*=null;
            var loc6:*=null;
            if (this.vars.onInit) 
            {
                this.vars.onInit.apply(null, this.vars.onInitParams);
            }
            if (typeof this.vars.ease == "function") 
            {
                this._ease = this.vars.ease;
            }
            if (this.vars.easeParams) 
            {
                this.vars.proxiedEase = this._ease;
                this._ease = this.easeProxy;
            }
            this.cachedPT1 = null;
            this.propTweenLookup = {};
            var loc7:*=0;
            var loc8:*=this.vars;
            for (loc1 in loc8) 
            {
                if (loc1 in _reservedProps && !(loc1 == "timeScale" && this.target is com.greensock.core.TweenCore)) 
                {
                    continue;
                }
                if (loc1 in plugins) 
                {
                    loc1 in plugins;
                    var loc9:*;
                    loc3 = loc9 = new (plugins[loc1] as Class)();
                }
                if (loc1 in plugins) 
                {
                    this.cachedPT1 = new com.greensock.core.PropTween(loc3, "changeFactor", 0, 1, loc3.overwriteProps.length != 1 ? "_MULTIPLE_" : loc3.overwriteProps[0], true, this.cachedPT1);
                    if (this.cachedPT1.name != "_MULTIPLE_") 
                    {
                        this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
                    }
                    else 
                    {
                        loc2 = loc3.overwriteProps.length;
                        while (--loc2 > -1) 
                        {
                            this.propTweenLookup[loc3.overwriteProps[loc2]] = this.cachedPT1;
                        }
                    }
                    if (loc3.priority) 
                    {
                        this.cachedPT1.priority = loc3.priority;
                        loc4 = true;
                    }
                    if (loc3.onDisable || loc3.onEnable) 
                    {
                        this._notifyPluginsOfEnabled = true;
                    }
                    this._hasPlugins = true;
                    continue;
                }
                this.cachedPT1 = new com.greensock.core.PropTween(this.target, loc1, Number(this.target[loc1]), typeof this.vars[loc1] != "number" ? Number(this.vars[loc1]) : Number(this.vars[loc1]) - this.target[loc1], loc1, false, this.cachedPT1);
                this.propTweenLookup[loc1] = this.cachedPT1;
            }
            if (loc4) 
            {
                onPluginEvent("onInitAllProps", this);
            }
            if (this.vars.runBackwards) 
            {
                loc6 = this.cachedPT1;
                while (loc6) 
                {
                    loc6.start = loc6.start + loc6.change;
                    loc6.change = -loc6.change;
                    loc6 = loc6.nextNode;
                }
            }
            _hasUpdate = Boolean(!(this.vars.onUpdate == null));
            if (this._overwrittenProps) 
            {
                this.killVars(this._overwrittenProps);
                if (this.cachedPT1 == null) 
                {
                    this.setEnabled(false, false);
                }
            }
            if (this._overwrite > 1 && this.cachedPT1) 
            {
                this._overwrite > 1 && this.cachedPT1;
                loc5 = loc7 = masterList[this.target];
            }
            if (this._overwrite > 1 && this.cachedPT1 && loc5.length > 1) 
            {
                if (overwriteManager.manageOverwrites(this, this.propTweenLookup, loc5, this._overwrite)) 
                {
                    this.init();
                }
            }
            this.initted = true;
            return;
        }

        public override function renderTime(arg1:Number, arg2:Boolean=false, arg3:Boolean=false):void
        {
            var loc1:*=false;
            var loc2:*=this.cachedTime;
            if (arg1 >= this.cachedDuration) 
            {
                var loc4:*;
                this.cachedTime = loc4 = this.cachedDuration;
                this.cachedTotalTime = loc4;
                this.ratio = 1;
                loc1 = !this.cachedReversed;
                if (this.cachedDuration == 0) 
                {
                    if ((arg1 == 0 || _rawPrevTime < 0) && !(_rawPrevTime == arg1)) 
                    {
                        arg3 = true;
                    }
                    _rawPrevTime = arg1;
                }
            }
            else if (arg1 <= 0) 
            {
                this.ratio = loc4 = 0;
                this.cachedTime = loc4 = loc4;
                this.cachedTotalTime = loc4;
                if (arg1 < 0) 
                {
                    this.active = false;
                    if (this.cachedDuration == 0) 
                    {
                        if (_rawPrevTime >= 0) 
                        {
                            arg3 = true;
                            loc1 = _rawPrevTime > 0;
                        }
                        _rawPrevTime = arg1;
                    }
                }
                if (this.cachedReversed && !(loc2 == 0)) 
                {
                    loc1 = true;
                }
            }
            else 
            {
                this.cachedTime = loc4 = arg1;
                this.cachedTotalTime = loc4;
                this.ratio = this._ease(arg1, 0, 1, this.cachedDuration);
            }
            if (this.cachedTime == loc2 && !arg3) 
            {
                return;
            }
            if (!this.initted) 
            {
                this.init();
                if (!loc1 && this.cachedTime) 
                {
                    this.ratio = this._ease(this.cachedTime, 0, 1, this.cachedDuration);
                }
            }
            if (!this.active && !this.cachedPaused) 
            {
                this.active = true;
            }
            if (loc2 == 0 && this.vars.onStart && (!(this.cachedTime == 0) || this.cachedDuration == 0) && !arg2) 
            {
                this.vars.onStart.apply(null, this.vars.onStartParams);
            }
            var loc3:*=this.cachedPT1;
            while (loc3) 
            {
                loc3.target[loc3.property] = loc3.start + this.ratio * loc3.change;
                loc3 = loc3.nextNode;
            }
            if (_hasUpdate && !arg2) 
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            if (loc1 && !this.gc) 
            {
                if (this._hasPlugins && this.cachedPT1) 
                {
                    onPluginEvent("onComplete", this);
                }
                complete(true, arg2);
            }
            return;
        }

        public function killVars(arg1:Object, arg2:Boolean=true):Boolean
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            if (this._overwrittenProps == null) 
            {
                this._overwrittenProps = {};
            }
            var loc4:*=0;
            var loc5:*=arg1;
            for (loc1 in loc5) 
            {
                if (loc1 in this.propTweenLookup) 
                {
                    if ((loc2 = this.propTweenLookup[loc1]).isPlugin && loc2.name == "_MULTIPLE_") 
                    {
                        loc2.target.killProps(arg1);
                        if (loc2.target.overwriteProps.length == 0) 
                        {
                            loc2.name = "";
                        }
                        if (!(loc1 == loc2.target.propName) || loc2.name == "") 
                        {
                            delete this.propTweenLookup[loc1];
                        }
                    }
                    if (loc2.name != "_MULTIPLE_") 
                    {
                        if (loc2.nextNode) 
                        {
                            loc2.nextNode.prevNode = loc2.prevNode;
                        }
                        if (loc2.prevNode) 
                        {
                            loc2.prevNode.nextNode = loc2.nextNode;
                        }
                        else if (this.cachedPT1 == loc2) 
                        {
                            this.cachedPT1 = loc2.nextNode;
                        }
                        if (loc2.isPlugin && loc2.target.onDisable) 
                        {
                            loc2.target.onDisable();
                            if (loc2.target.activeDisable) 
                            {
                                loc3 = true;
                            }
                        }
                        delete this.propTweenLookup[loc1];
                    }
                }
                if (!(arg2 && !(arg1 == this._overwrittenProps))) 
                {
                    continue;
                }
                this._overwrittenProps[loc1] = 1;
            }
            return loc3;
        }

        public override function invalidate():void
        {
            if (this._notifyPluginsOfEnabled && this.cachedPT1) 
            {
                onPluginEvent("onDisable", this);
            }
            this.cachedPT1 = null;
            this._overwrittenProps = null;
            var loc1:*;
            this._notifyPluginsOfEnabled = loc1 = false;
            this.active = loc1 = loc1;
            this.initted = loc1 = loc1;
            _hasUpdate = loc1;
            this.propTweenLookup = {};
            return;
        }

        public override function setEnabled(arg1:Boolean, arg2:Boolean=false):Boolean
        {
            var loc1:*=null;
            if (arg1) 
            {
                loc1 = com.greensock.TweenLite.masterList[this.target];
                if (loc1) 
                {
                    if (loc1.indexOf(this) == -1) 
                    {
                        loc1[loc1.length] = this;
                    }
                }
                else 
                {
                    com.greensock.TweenLite.masterList[this.target] = [this];
                }
            }
            super.setEnabled(arg1, arg2);
            if (this._notifyPluginsOfEnabled && this.cachedPT1) 
            {
                return onPluginEvent(arg1 ? "onEnable" : "onDisable", this);
            }
            return false;
        }

        public static const version:Number=11.698;

        public var target:Object;

        public var propTweenLookup:Object;

        public var ratio:Number=0;

        public var cachedPT1:com.greensock.core.PropTween;

        protected var _ease:Function;

        protected var _overwrite:int;

        protected var _overwrittenProps:Object;

        protected var _hasPlugins:Boolean;

        protected var _notifyPluginsOfEnabled:Boolean;

        public static var rootTimeline:com.greensock.core.SimpleTimeline;

        public static var rootFramesTimeline:com.greensock.core.SimpleTimeline;

        public static var masterList:flash.utils.Dictionary;

        internal static var _shape:flash.display.Shape;

        protected static var _reservedProps:Object;

        public static var fastEaseLookup:flash.utils.Dictionary;

        public static var onPluginEvent:Function;

        public static var killDelayedCallsTo:Function;

        public static var defaultEase:Function;

        public static var overwriteManager:Object;

        public static var rootFrame:Number;

        public static var plugins:Object;
    }
}
