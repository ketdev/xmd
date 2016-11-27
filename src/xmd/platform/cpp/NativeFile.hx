package xmd.platform.cpp;
#if cpp

import xmd.platform.File;
import haxe.ds.StringMap;
import xmd.platform.cpp.WinWatch;
import cpp.vm.Thread;


class NativeFile{
    public static function readContent(path:String):String{
        return sys.io.File.getContent(path);
    }
    public static function writeContent(path:String, content:String){
        sys.io.File.saveContent(path,content);
    }
    public static function addContent(path:String, content:String){
        writeContent(path,readContent(path)+content);
    }
    public static function watch(path:String, onChange:FileAction->String->Void):Bool{
        // make sure it's not already watched
        if(_watchers.exists(path))
            return false;
                
        // create
        var w = new Watch(path,true);     
        _watchers.set(path,w);

        // create watcher thread
        var t = Thread.create(_watcherWork.bind(w,onChange));

        return true;
    }
    public static function unwatch(path:String){
        var w = _watchers.get(path);
        if(w != null){
            w.stop();
            _watchers.remove(path);
        }
    }

    private static var _watchers = new StringMap<Watch>();
    private static function _watcherWork(w:Watch,onChange:FileAction->String->Void){
        // watch
        w.watch(onChange);
        // free internal pointer
        w.destroy();
    }

}



#end