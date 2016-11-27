package xmd.platform;

interface IPlatform{
    
	/**
		Get the number of columns in the terminal window or -1 on error.
	**/
    var width(get,null):Int;
    
	/**
		Get the number of rows in the terminal window or -1 on error.
	**/
    var height(get,null):Int;

	/**
		Get the cursor x position
	**/
    var x(get,null):Int;

	/**
		Get the cursor y position
	**/
    var y(get,null):Int;

	/**
		Reads a key press (blocking) and returns a key code.
	**/
	function getKey():Int;
    	
	/**
		Sets the character at the cursor without advancing the cursor.
	**/
	function setChar(c:Int, ?color:Int, ?background:Int):Void;

	/**
		Reads a line (blocking) from the user.
	**/
	function input():String;

	/**
		Prints the characters at the cursor and advances the cursor.
        Colors are rgba, but might be adjusted by the platform.
	**/
    function output(str:String, ?color:Int, ?background:Int):Void;

	/**
		Prints the characters to the error stream, or standard if not available.
	**/
    function error(str:String, ?color:Int, ?background:Int):Void;

	/**
		Sets the position of the cursor.
        The position is clamped to the console dimensions.
	**/
    function setCursor(x:Int, y:Int):Void;


}