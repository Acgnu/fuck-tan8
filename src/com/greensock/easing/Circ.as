package com.greensock.easing 
{
    public class Circ extends Object
    {
        public function Circ()
        {
            super();
            return;
        }

        public static function easeIn(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*;
            arg1 = loc1 = arg1 / arg4;
            return (-arg3) * (Math.sqrt(1 - loc1 * arg1) - 1) + arg2;
        }

        public static function easeOut(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*;
            arg1 = loc1 = (arg1 / arg4 - 1);
            return arg3 * Math.sqrt(1 - loc1 * arg1) + arg2;
        }

        public static function easeInOut(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*;
            arg1 = loc1 = arg1 / (arg4 * 0.5);
            if (loc1 < 1) 
            {
                return (-arg3) * 0.5 * (Math.sqrt(1 - arg1 * arg1) - 1) + arg2;
            }
            arg1 = loc1 = arg1 - 2;
            return arg3 * 0.5 * (Math.sqrt(1 - loc1 * arg1) + 1) + arg2;
        }
    }
}
