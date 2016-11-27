package;

import xmd.platform.Terminal;
import arguable.ArgParser;

class Main{

    public static function main() {

        // Parse input arguments
        ArgParser.delimiter = '-';
        var args = ArgParser.parse( Sys.args() );

        // run script from file        
        var fileInput = false;

        // ...

        // watch callbacks
        // File.watch('C:/Xhi/test',
        //     function(action,path){
        //         try{
        //             tty.output('$action on $path changed!\n');
        //         }catch(e:Dynamic){
        //             tty.error('$e\n');
        //         }
        //     }
        // );

        
        // Initialize built-in commands
        var terminal = new Terminal();
        terminal.echoCommands = fileInput;


        //tty.clear();
        //tty.output('Hello world!\n');

        // read loop
        #if js
        js.Node.setInterval(function(){
        #else
        while(true){
        #end
            terminal.query();
        }
        #if js
        ,0);
        #end
    }

}