package xmd.platform.cpp;
#if cpp

@:include('./RlUtilMod.h')
extern class RlUtil{

    /// Function: getch
    /// Get character without waiting for Return to be pressed.
    /// Windows has this in conio.h
    @:native('getch')
    public static function getch():Int;

    /// Function: kbhit
    /// Determines if keyboard has been hit.
    /// Windows has this in conio.h
    @:native('kbhit')
    public static function kbhit():Int;

    /// Function: getkey
    /// Reads a key press (blocking) and returns a key code.
    ///
    /// See <Key codes for keyhit()>
    ///
    /// Note:
    /// Only Arrows, Esc, Enter and Space are currently working properly.
    @:native('rlutil::getkey')
    public static function getkey():Int;

    /// Function: nb_getch
    /// Non-blocking getch(). Returns 0 if no key was pressed.
    @:native('rlutil::nb_getch')
    public static function nb_getch():Int;

    /// Function: getANSIColor
    /// Return ANSI color escape sequence for specified number 0-15.
    ///
    /// See <Color Codes>
    @:native('rlutil::getANSIColor')
    public static function getANSIColor(c:Int):cpp.ConstCharStar;

    /// Function: getANSIBackgroundColor
    /// Return ANSI background color escape sequence for specified number 0-15.
    ///
    /// See <Color Codes>
    @:native('rlutil::getANSIBackgroundColor')
    public static function getANSIBackgroundColor(c:Int):cpp.ConstCharStar;

    /// Function: setColor
    /// Change color specified by number (Windows / QBasic colors).
    /// Don't change the background color
    ///
    /// See <Color Codes>
    @:native('rlutil::setColor')
    public static function setColor(c:Int):Void;

    /// Function: setBackgroundColor
    /// Change background color specified by number (Windows / QBasic colors).
    /// Don't change the foreground color
    ///
    /// See <Color Codes>
    @:native('rlutil::setBackgroundColor')
    public static function setBackgroundColor(c:Int):Void;

    /// Function: saveDefaultColor
    /// Call once to preserve colors for use in resetColor()
    /// on Windows without ANSI, no-op otherwise
    ///
    /// See <Color Codes>
    /// See <resetColor>
    @:native('rlutil::saveDefaultColor')
    public static function saveDefaultColor():Int;

    /// Function: resetColor
    /// Reset color to default
    /// Requires a call to saveDefaultColor() to set the defaults
    ///
    /// See <Color Codes>
    /// See <setColor>
    /// See <saveDefaultColor>
    @:native('rlutil::resetColor')
    public static function resetColor():Void;

    /// Function: cls
    /// Clears screen, resets all attributes and moves cursor home.
    @:native('rlutil::cls')
    public static function cls():Void;

    /// Function: locate
    /// Sets the cursor position to 1-based x,y.
    @:native('rlutil::locate')
    public static function locate(x:Int, y:Int):Void;

    /// Function: xpos
    /// Gets the cursor 1-based x position.
    @:native('rlutil::xpos')
    public static function xpos():Int;

    /// Function: ypos
    /// Gets the cursor 1-based y position.
    @:native('rlutil::ypos')
    public static function ypos():Int;

    /// Function: setString
    /// Prints the supplied string without advancing the cursor
    @:native('rlutil::setString')
    public static function setString(str:cpp.ConstCharStar):Void;

    /// Function: setChar
    /// Sets the character at the cursor without advancing the cursor
    @:native('rlutil::setChar')
    public static function setChar(x:cpp.Char):Void;

    /// Function: setCursorVisibility
    /// Shows/hides the cursor.
    @:native('rlutil::setCursorVisibility')
    public static function setCursorVisibility(visible:cpp.Char):Void;

    /// Function: hidecursor
    /// Hides the cursor.
    @:native('rlutil::hidecursor')
    public static function hidecursor():Void;

    /// Function: showcursor
    /// Shows the cursor.
    @:native('rlutil::showcursor')
    public static function showcursor():Void;

    /// Function: msleep
    /// Waits given number of milliseconds before continuing.
    @:native('rlutil::msleep')
    public static function msleep(ms:UInt):Void;

    /// Function: trows
    /// Get the number of rows in the terminal window or -1 on error.
    @:native('rlutil::trows')
    public static function trows():Int;

    /// Function: tcols
    /// Get the number of columns in the terminal window or -1 on error.
    @:native('rlutil::tcols')
    public static function tcols():Int;

    /// Function: anykey
    /// Waits until a key is pressed.
    /// In C++, it either takes no arguments
    /// or a template-type-argument-deduced
    /// argument.
    /// In C, it takes a const char* representing
    /// the message to be displayed, or NULL
    /// for no message.
    @:native('rlutil::anykey')
    public static function anykey(msg:cpp.ConstCharStar):Void;

    @:native('rlutil::setConsoleTitle')
    public static function setConsoleTitle(title:cpp.ConstCharStar):Void;
    
}
#end