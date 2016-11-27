package xmd.platform;

enum FileAction{
    Added;
    Removed;
    Modified;
    RenameOld;
    RenameNew;
}

#if cpp
typedef File = xmd.platform.cpp.NativeFile;
#elseif js
typedef File = xmd.platform.js.NodeFile;
#end
