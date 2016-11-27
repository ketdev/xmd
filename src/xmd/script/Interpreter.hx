package xmd.script;

import hscript.Parser;
import hscript.Interp;
import hscript.Expr;

@:access(hscript.Interp)
class Interpreter{

    private var _parser = new Parser();
    private var _interp = new Interp();
    
	public var variables(get,set):Map<String,Dynamic>;
    function get_variables() return _interp.variables;
    function set_variables(o) return (_interp.variables = o);

    public function new(){
        _parser.allowJSON = true;
        _parser.allowTypes = true;
        // remove build-in trace
        _interp.variables.remove('trace');
    }

    public function isFullExpr(expr:String):Bool{
        var inBlock:Bool = false;
        var inExpr:Bool = false;
        for(i in 0...expr.length){
            var c = expr.charAt(i);
            switch(c){
                case '{':
                    inBlock = true;
                case '}':
                    inExpr = false;
                    inBlock = false;
                case ';':
                    inExpr = false;
                default:
                    inExpr = true;
                case ' ' | '\t':
            }
        }
        return !inBlock && !inExpr;
    }

    public function eval(expr:String):Dynamic{
        var ast = _parser.parseString(expr);
        return _interp.exprReturn(ast);
    }

}