#ifndef WIN_WATCH_H_
#define WIN_WATCH_H_

#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <tchar.h>
#include <string>

#include <iostream>
#include <string>
#include <locale>
#include <codecvt>
#include <vector>

struct WinChange {
    bool error;
    DWORD action;
    std::string filename;
};

static inline std::wstring s2ws(const std::string& str) {
    using convert_typeX = std::codecvt_utf8<wchar_t>;
    std::wstring_convert<convert_typeX, wchar_t> converterX;
    return converterX.from_bytes(str);
}

static inline std::string ws2s(const std::wstring& wstr) {
    using convert_typeX = std::codecvt_utf8<wchar_t>;
    std::wstring_convert<convert_typeX, wchar_t> converterX;
    return converterX.to_bytes(wstr);
}

static inline std::string to_utf8(const wchar_t* buffer, int len) {
    int nChars =
        ::WideCharToMultiByte(CP_UTF8, 0, buffer, len, NULL, 0, NULL, NULL);
    if (nChars == 0) return "";

    std::string newbuffer;
    newbuffer.resize(nChars);
    ::WideCharToMultiByte(CP_UTF8, 0, buffer, len,
                          const_cast<char*>(newbuffer.c_str()), nChars, NULL,
                          NULL);

    return newbuffer;
}

class WinWatch {
   public:
    WinWatch(const char* path, bool recursive) {
        dir =
            CreateFileW(s2ws(path).c_str(), FILE_LIST_DIRECTORY,
                        FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
                        NULL, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
        next = NULL;
    }

    void stop() { CancelIoEx(dir, NULL); }

    WinChange wait() {
        WinChange c;
        c.error = true;
        DWORD bytesReturned;

        if (next == NULL && ReadDirectoryChangesW(
                dir,            /* handle to directory */
                &buffer,        /* read results buffer */
                sizeof(buffer), /* length of buffer */
                TRUE,           /* monitoring option */
                FILE_NOTIFY_CHANGE_SECURITY | FILE_NOTIFY_CHANGE_CREATION |
                    FILE_NOTIFY_CHANGE_LAST_ACCESS |
                    FILE_NOTIFY_CHANGE_LAST_WRITE | FILE_NOTIFY_CHANGE_SIZE |
                    FILE_NOTIFY_CHANGE_ATTRIBUTES |
                    FILE_NOTIFY_CHANGE_DIR_NAME |
                    FILE_NOTIFY_CHANGE_FILE_NAME, /* filter conditions */
                &bytesReturned,                   /* bytes returned */
                NULL,                             /* overlapped buffer */
                NULL)) {
            // Cast the buffer as Notification Struct.
            next = (FILE_NOTIFY_INFORMATION*)(buffer);            
        }

        if(next != NULL){
            
            // null terminate`
            std::wstring newbuffer;
            newbuffer.resize(next->FileNameLength + 2);
            memcpy(const_cast<wchar_t*>(newbuffer.c_str()),next->FileName,next->FileNameLength);
            // next->FileName[next->FileNameLength] = 0;
            // next->FileName[next->FileNameLength + 1] = 0;

            c.error = false;
            c.action = next->Action;
            // c.filename = to_utf8(info->FileName, info->FileNameLength);
            c.filename = ws2s(newbuffer);

            if(next->NextEntryOffset == 0)
                next = NULL;
            else
                next = (FILE_NOTIFY_INFORMATION*)(buffer + next->NextEntryOffset);
        }

        return c;
    }

   private:
    HANDLE dir;
    BYTE buffer[sizeof(FILE_NOTIFY_INFORMATION) + MAX_PATH];
    FILE_NOTIFY_INFORMATION* next;
};

#endif  // WIN_WATCH_H_