package xmd.platform.cpp;
#if cpp

import xmd.platform.cpp.RlUtil;
import cpp.vm.Thread;

@:include('./ansicolor.h')
extern class AnsiColor{    
    @:native('ansi_fputs_out') public static function out(string:cpp.ConstCharStar):Int;
    @:native('ansi_fputs_err') public static function err(string:cpp.ConstCharStar):Int;
}

class NativeConsole{
    
    public static function input():String{
		try {
            return Sys.stdin().readLine();
        }catch( e : haxe.io.Eof ) {
            return null;
        }
    }

    public static function output(data:String){
         AnsiColor.out(data);
    }

    public static function error(data:String){
         AnsiColor.err(data);
    }

}

#end