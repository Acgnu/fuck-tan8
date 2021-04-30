package com.greensock.core 
{
    public final class PropTween extends Object
    {
        public function PropTween(arg1:Object, arg2:String, arg3:Number, arg4:Number, arg5:String, arg6:Boolean, arg7:com.greensock.core.PropTween=null, arg8:int=0)
        {
            super();
            this.target = arg1;
            this.property = arg2;
            this.start = arg3;
            this.change = arg4;
            this.name = arg5;
            this.isPlugin = arg6;
            if (arg7) 
            {
                arg7.prevNode = this;
                this.nextNode = arg7;
            }
            this.priority = arg8;
            return;
        }

        public var target:Object;

        public var property:String;

        public var start:Number;

        public var change:Number;

        public var name:String;

        public var priority:int;

        public var isPlugin:Boolean;

        public var nextNode:com.greensock.core.PropTween;

        public var prevNode:com.greensock.core.PropTween;
    }
}
