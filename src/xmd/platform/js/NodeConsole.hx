package xmd.platform.js;
#if js

class NodeConsole{
    
    public static function input():String{
        var buf = new StringBuf();
        var readbuf = js.node.Buffer.alloc(1);
		var last : Int;
		var s;        
        while(js.node.Fs.readSync(untyped __js__('process.stdin.fd'),readbuf,0,readbuf.length,0) > 0 ){
            last = readbuf.readUInt8(0);
            if(last == 10)
                break;
            buf.addChar( last );
        }
        s = buf.toString();
        if( s.length == 0 )
            return null;
		if( s.charCodeAt(s.length-1) == 13 ) s = s.substr(0,-1);
		return s;	
    }

    public static function output(data:String){
        js.Node.process.stdout.write(data);
    }
    public static function error(data:String){
        js.Node.process.stderr.write(data);     
    }

}

#end