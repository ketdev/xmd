package xmd.platform;

import xmd.utils.Color;

// ANSI escape codes
@:remove
abstract AnsiCode(Void){    

    /**
        Cursor Positioning
    **/

    public static function cursorUp(n:Int):String           return '\033[${n}A';
    public static function cursorDown(n:Int):String         return '\033[${n}B';
    public static function cursorForward(n:Int):String      return '\033[${n}C';
    public static function cursorBackward(n:Int):String     return '\033[${n}D';
    public static function cursorNextLine(n:Int):String     return '\033[${n}E';
    public static function cursorPrevLine(n:Int):String     return '\033[${n}F';
    public static function cursorXPos(n:Int):String         return '\033[${n}G';
    public static function cursorYPos(n:Int):String         return '\033[${n}d';
    public static function cursorPos(x:Int,y:Int):String    return '\033[${x};${y}H';
    public static function cursorXYPos(x:Int,y:Int):String  return '\033[${x};${y}f';
    public static function cursorSave():String              return '\033[s';
    public static function cursorLoad():String              return '\033[u';
    public static function cursorHome():String              return '\033[H';
    
    /**
        Cursor Visibility
    **/

    public static function cursorStartBlink():String        return '\033[?12h';
    public static function cursorStopBlink():String         return '\033[?12l';
    public static function cursorShow():String              return '\033[?25h';
    public static function cursorHide():String              return '\033[?25l';

    /**
        Viewport Positioning
    **/

    public static function scrollUp(n:Int):String           return '\033[${n}S';
    public static function scrollDown(n:Int):String         return '\033[${n}T';

    /**
        Text Modification
    **/

    public static function insertChars(n:Int):String        return '\033[${n}@';
    public static function deleteChars(n:Int):String        return '\033[${n}P';
    public static function eraseChars(n:Int):String         return '\033[${n}X';
    public static function insertLine(n:Int):String         return '\033[${n}L';
    public static function deleteLine(n:Int):String         return '\033[${n}M';

    public static function eraseDisplayToCursor():String    return '\033[0J';
    public static function eraseDisplayFromCursor():String  return '\033[1J';
    public static function eraseDisplay():String            return '\033[2J';
    public static function eraseLineToCursor():String       return '\033[0K';
    public static function eraseLineFromCursor():String     return '\033[1K';
    public static function eraseLine():String               return '\033[2K';

    /**
        Text Formatting
    **/

    public static function textReset():String               return '\033[0m';
    public static function bright():String                  return '\033[1m';
    public static function dim():String                     return '\033[22m';
    public static function underline():String               return '\033[4m';
    public static function noUnderline():String             return '\033[24m';
    public static function negative():String                return '\033[7m';
    public static function positive():String                return '\033[27m';
    public static function foregroundBlack():String         return '\033[30m';
    public static function foregroundRed():String           return '\033[31m';
    public static function foregroundGreen():String         return '\033[32m';
    public static function foregroundYellow():String        return '\033[33m';
    public static function foregroundBlue():String          return '\033[34m';
    public static function foregroundMagenta():String       return '\033[35m';
    public static function foregroundCyan():String          return '\033[36m';
    public static function foregroundWhite():String         return '\033[37m';
    public static function foregroundDefault():String       return '\033[39m';

    public static function backgroundBlack():String         return '\033[40m';
    public static function backgroundRed():String           return '\033[41m';
    public static function backgroundGreen():String         return '\033[42m';
    public static function backgroundYellow():String        return '\033[43m';
    public static function backgroundBlue():String          return '\033[44m';
    public static function backgroundMagenta():String       return '\033[45m';
    public static function backgroundCyan():String          return '\033[46m';
    public static function backgroundWhite():String         return '\033[47m';
    public static function backgroundDefault():String       return '\033[49m';

    public static function foregroundExtend(r:Int,g:Int,b:Int):String{
        return '\033[38;2;${r};${g};${b}m';
    }
    public static function backgroundExtend(r:Int,g:Int,b:Int):String{
        return '\033[48;2;${r};${g};${b}m';
    }
    public static function foregroundColor(rgb:RGB):String {
        var hsl = ColorConverter.rgb2hsl(rgb);

        // Hue
        var hue:String;
        switch(Math.round(hsl.h / 60)){
            case 1: hue = foregroundYellow();
            case 2: hue = foregroundGreen(); 
            case 3: hue = foregroundCyan();
            case 4: hue = foregroundBlue();
            case 5: hue = foregroundMagenta(); 
            default: hue = foregroundRed();
        }
        // black and white
        if(hsl.l > 0.75) hue = foregroundWhite();
        if(hsl.l < 0.25) hue = foregroundBlack();

        // Luminosity
        var lum:String = (hsl.l >= 0.5) ? bright() : dim();

        return lum+hue;
    }
    public static function backgroundColor(rgb:RGB):String {
        var hsl = ColorConverter.rgb2hsl(rgb);

        // Hue
        var hue:String;
        switch(Math.round(hsl.h / 60)){
            case 1: hue =  backgroundYellow();
            case 2: hue =  backgroundGreen(); 
            case 3: hue =  backgroundCyan();
            case 4: hue =  backgroundBlue();
            case 5: hue =  backgroundMagenta(); 
            default: hue = backgroundRed();
        }
        // black and white
        if(hsl.l > 0.75) hue = backgroundWhite();
        if(hsl.l < 0.25) hue = backgroundBlack();

        return hue;
    }
    
    /**
        Query State
    **/

    public static function getCursorPos():String            return '\033[6n';
    public static function getDeviceAttrib():String         return '\033[0c';

    /**
        Tabs
    **/

    public static function tabSetColumn():String            return '\033H';
    public static function tabForward(n:Int):String         return '\033[${n}l';
    public static function tabBackward(n:Int):String        return '\033[${n}Z';
    public static function tabClearColumn():String          return '\033[0g';
    public static function tabClear():String                return '\033[3g';

    /**
        Scrolling Margins
    **/

    public static function setScrollingRegion(t:Int,b:Int):String return '\033[${t};${b}r';

    /**
        Operating system command
    **/

    public static function windowTitle(title:String):String return '\033]0;${title}\007';
    public static function windowWidth132():String          return '\033[?3h';
    public static function windowWidth80():String           return '\033[?3l';
    public static function softReset():String               return '\033[!p';

}