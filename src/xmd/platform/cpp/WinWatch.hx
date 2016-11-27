package xmd.platform.cpp;

#if cpp

import xmd.platform.File;

@:include('./WinWatch.h')
@:native('WinChange')
@:structAccess
extern class WinChange{
    public var error:Bool;
    public var action:cpp.UInt32;
    public var filename:cpp.StdString;
}

@:include('./WinWatch.h')
@:native('WinWatch')
@:unreflective
@:structAccess
extern class WinWatch{
    @:native('new WinWatch')
    public static function create(path:cpp.ConstCharStar, recursive:Bool):cpp.Pointer<WinWatch>;
    public function wait():WinChange;
    public function stop():Void;

}

class Watch{

    public function new(path:String, recursive:Bool){
        _w = WinWatch.create(path,recursive);
    }
    public function watch(onChange:FileAction->String->Void) {
        var error:Bool = false;
        while(!error){
            var c:WinChange = _w.value.wait();
            error = c.error;
            if(!error){
                var cstr:cpp.ConstCharStar = untyped __cpp__('c.filename.c_str()');
                var action:FileAction = Modified;
                switch(c.action){
                    case 1: // ADDED
                        action = Added;
                    case 2: // REMOVED
                        action = Removed;
                    case 3: // MODIFIED
                        action = Modified;
                    case 4: // RENAMED OLD NAME
                        action = RenameOld;
                    case 5: // RENAMED NEW NAME
                        action = RenameNew;
                }
                onChange(action,cstr.toString());
            }
        }
    }
    public function stop(){
        if(_destroyed) return;
        _w.value.stop();
    }
    public function destroy(){
        _destroyed = true;
        _w.destroy();
    }

    private var _destroyed = false;
    private var _w:cpp.Pointer<WinWatch>;
}

#end