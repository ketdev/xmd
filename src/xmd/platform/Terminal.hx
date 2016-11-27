package xmd.platform;

import xmd.script.Interpreter;
import hscript.Expr;

#if cpp
typedef Console = xmd.platform.cpp.NativeConsole;
#elseif js
typedef Console = xmd.platform.js.NodeConsole;
#end

class Terminal{

	// Settings
    public var prompt:String = '> ';
    public var multilinePrompt:String = '. ';
	public var disabled:Bool = false;
	public var echoCommands:Bool = true;

	// Internal state
	private var _interpreter = new Interpreter();
	private var _expr:String = '';

	//// Features
    // typedef Command = Void->Void;
    // typedef Keycode = Int;
	// public var shortcuts:IntMap<Command>;
	// private var _history = new Array<String>();
	// private var _completion:Array<String>;

    public function new(){
    }
    
	public function query() {
		if(disabled) return;

		// prompt for user input
		output(if(_expr.length>0) multilinePrompt else prompt);
		var line = input();
		
		// echo command
		if(_expr.length == 0 && echoCommands)
			output('$_expr\n');

		// combine strings until we get end of block '}' or end of expression ';'
        if(line != null)
		    _expr += line + ' ';
		if(_interpreter.isFullExpr(_expr)){
			// pass to hscript interpreter
			try {
				var result = _interpreter.eval(_expr);
				if(result != null)
					output('$result\n');
			} catch (e:Error) {
				_errorReport(e);
			} catch (e:Dynamic) {
				error('ERROR: ',0xFF0000FF);
				error('$e\n');
			} 
			_expr = '';
		}
    }

    public function clear(){
        Console.output(AnsiCode.eraseDisplay());
        Console.output(AnsiCode.cursorHome());
    }
    
    public function input():String{
        return Console.input();
    }

    public function output(data:Dynamic, ?color:Int, ?background:Int){
        if(color != null){
            var fg = xmd.utils.Color.ColorConverter.toRGB(color >> 8); // ignore alpha
            Console.output(AnsiCode.foregroundColor(fg));
        }
        if(background != null){
            var bg = xmd.utils.Color.ColorConverter.toRGB(background >> 8); // ignore alpha
            Console.output(AnsiCode.backgroundColor(bg));
        }
        Console.output(data);
        if(color != null || background != null)
            Console.output(AnsiCode.textReset());
    }

    public function error(data:Dynamic, ?color:Int, ?background:Int){
        if(color != null){
            var fg = xmd.utils.Color.ColorConverter.toRGB(color >> 8); // ignore alpha
            Console.error(AnsiCode.foregroundColor(fg));
        }
        if(background != null){
            var bg = xmd.utils.Color.ColorConverter.toRGB(background >> 8); // ignore alpha
            Console.error(AnsiCode.backgroundColor(bg));
        }        
        Console.error(data);
        if(color != null || background != null)
            Console.error(AnsiCode.textReset());
    }

    private function _errorReport(e:Error):Void {
        if(error == null) 
            return null;
        
        error('ERROR: ',0xFF0000FF);
        error('characters ${e.pmin}-${e.pmax} : ');
        switch(e.e){
            case EInvalidChar(c):
                error('Invalid character \'${String.fromCharCode(c)}\'\n');
            case EUnexpected(s):
                error('EUnexpected $s\n'); ////////////////
            case EUnterminatedString:
                error('EUnterminatedString\n'); ////////////////
            case EUnterminatedComment:
                error('EUnterminatedComment\n'); ////////////////
            case EUnknownVariable(v):
                error('Unknown identifier : $v\n');
            case EInvalidIterator(v):
                error('EInvalidIterator $v\n'); ////////////////
            case EInvalidOp(op):
                error('EInvalidOp $op\n'); ////////////////
            case EInvalidAccess(f):
                error('EInvalidAccess $f\n'); ////////////////
        }
    }

}