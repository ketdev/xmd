package xmd.platform.js;
#if js

import xmd.platform.File;
import haxe.ds.StringMap;

class NodeFile{
    public static function readContent(path:String):String{
        return js.node.Fs.readFileSync(path,{encoding:'utf8'});
    }
    public static function writeContent(path:String, content:String){
        js.node.Fs.writeFileSync(path,content);
    }
    public static function addContent(path:String, content:String){
        writeContent(path,readContent(path)+content);
    }
    public static function watch(path:String, onChange:FileAction->String->Void){
        var watcher = js.node.Fs.watch(path,function(event,path){
            switch(event){
                case 'rename':
                    onChange(FileAction.RenameOld,path);
                case 'change':
                    onChange(FileAction.Modified,path);
                case _:
                    trace(event);
            }
        });
        _watchers.set(path,watcher);
    }
    public static function unwatch(path:String){
        var watcher = _watchers.get(path);
        if(watcher != null){
            watcher.close();
            _watchers.remove(path);
        }
    }
    private static var _watchers = new StringMap<js.node.fs.FSWatcher>();
}

#end