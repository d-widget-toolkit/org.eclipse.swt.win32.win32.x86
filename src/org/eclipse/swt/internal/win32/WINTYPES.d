/*
 * This module declared types required by SWT but not in std.c.windows.windows
 */

module org.eclipse.swt.internal.win32.WINTYPES;

public import tango.sys.win32.Types;

// missing in tango
//alias TLOGFONTA* LPLOGFONTA;
//alias TLOGFONTA LOGFONTA;
//alias char CHAR;
alias OPENFILENAME OPENFILENAMEW;
alias OPENFILENAME OPENFILENAMEA;
//alias WNDCLASS_T   WNDCLASS;

//alias TCLSID *REFCLSID;

//interface IUnknown{}
//alias IUnknown LPUNKNOWN;


struct SCRIPT_DIGITSUBSTITUTE {
  ushort NationalDigitLanguage;
  ushort TraditionalDigitLanguage;
  DWORD DigitSubstitute;
  DWORD dwReserved;
}

struct BUTTON_IMAGELIST {
    HIMAGELIST himl;
    RECT margin;
    UINT uAlign;
}

alias HANDLE HTHEME;

struct NMREBARCHILDSIZE {
    NMHDR hdr;
    UINT uBand;
    UINT wID;
    RECT rcChild;
    RECT rcBand;
}
const int MAX_LINKID_TEXT = 48;
const int L_MAX_URL_LENGTH = 2084;
struct LITEM {
    UINT mask;
    int iLink;
    UINT state;
    UINT stateMask;
    WCHAR szID[MAX_LINKID_TEXT];
    WCHAR szUrl[L_MAX_URL_LENGTH];
}
struct NMLINK {
    NMHDR hdr;
    LITEM item;
}
struct NMLVODSTATECHANGE {
  NMHDR hdr;
  int iFrom;
  int iTo;
  UINT uNewState;
  UINT uOldState;
}
struct NMTBHOTITEM {
    NMHDR hdr;
    int idOld;
    int idNew;
    DWORD dwFlags;
}
struct NMTVDISPINFO {
    NMHDR hdr;
    TVITEM item;
}

// only on Vista
struct NMTVITEMCHANGE {
    NMHDR hdr;
    UINT uChanged;
    HTREEITEM hItem;
    UINT uStateNew;
    UINT uStateOld;
    LPARAM lParam;
}

struct ACTCTXA {
  ULONG cbSize;
  DWORD dwFlags;
  LPCSTR lpSource;
  USHORT wProcessorArchitecture;
  LANGID wLangId;
  LPCTSTR lpAssemblyDirectory;
  LPCTSTR lpResourceName;
  LPCTSTR lpApplicationName;
  HMODULE hModule;
}
struct ACTCTXW {
  ULONG cbSize;
  DWORD dwFlags;
  LPCWSTR lpSource;
  USHORT wProcessorArchitecture;
  LANGID wLangId;
  LPCTSTR lpAssemblyDirectory;
  LPCTSTR lpResourceName;
  LPCTSTR lpApplicationName;
  HMODULE hModule;
}
version(Win32SansUnicode) alias ACTCTXA ACTCTX;
else          alias ACTCTXW ACTCTX;
alias HANDLE HACTCTX;

struct OSVERSIONINFOEX
{
  DWORD dwOSVersionInfoSize;
  DWORD dwMajorVersion;
  DWORD dwMinorVersion;
  DWORD dwBuildNumber;
  DWORD dwPlatformId;
  TCHAR szCSDVersion[128];
  WORD wServicePackMajor;
  WORD wServicePackMinor;
  WORD wSuiteMask;
  BYTE wProductType;
  BYTE wReserved;
}



// ....
//--------------------------------------------------------------------------------

// const int LF_FACESIZE = 32;
// const int LF_FULLFACESIZE = 64;

alias HANDLE HIMC;
// alias HANDLE HTREEITEM;
//alias HANDLE HDWP;
//alias HANDLE HIMAGELIST;
//alias HANDLE HMONITOR;
//alias HANDLE HHOOK;
//alias HANDLE HDROP;
//alias HANDLE *LPHANDLE;

alias HRESULT WINOLEAPI;
// alias LPRECT LPCRECT;
// alias LPRECT LPCRECTL;
alias DWORD LGRPID;
//alias LONG LONG_PTR;
//alias ULONG ULONG_PTR;
//alias DWORD DWORD_PTR;
//alias int INT_PTR;
//alias uint UINT_PTR;
// alias DWORD LCID;
// alias DWORD LCTYPE;
alias USHORT COLOR16;

//alias POINT POINTL;

//alias long LONGLONG;
//alias ulong DWORDLONG;

//alias LONGLONG  *PLONGLONG;
//alias DWORDLONG *PDWORDLONG;
alias size_t    SIZE_T;
//alias int       WPARAM_I;

extern(Windows){

/**
 * Since Eclipse/SWT uses int as (msg, wparam, lparam) and some times check the value against (-1),
 * but WNDPROC_I declared in windows header the (msg, wparam) is UINT which will never be -1 but 0xFFFF or
 * something else. This made some SWT API failed. to fix the problem, it better to declare (msg, wparam)
 * as int like Eclispe/SWT does. and we alias int to WPARAM_I.
 */
// alias LRESULT function(HWND, uint, uint, int) WNDPROC_I;
// alias LRESULT function(int code, int wParam, LPARAM lParam) HOOKPROC_I;
//
// // Windows CALLBACK declaration here
// alias WNDPROC_I BFFCALLBACK;        // browse for fold
// alias WNDPROC_I LPCCHOOKPROC_I;     // choose color
// alias WNDPROC_I LPCFHOOKPROC_I;     // choose font
// alias WNDPROC_I LPPRINTHOOKPROC_I;  // print hook
// alias WNDPROC_I LPSETUPHOOKPROC_I;  // print setup
// alias WNDPROC_I TIMERPROC_I;        // timer

alias LRESULT function (
    int code,       // hook code
    int wParam,  // undefined
    int lParam   // address of structure with message data
) MESSAGEPROC;


//alias BOOL function (
//  HMONITOR hMonitor,  // handle to display monitor
//  HDC hdcMonitor,     // handle to monitor-appropriate device context
//  LPRECT lprcMonitor, // pointer to monitor intersection rectangle
//  LPARAM dwData       // data passed from EnumDisplayMonitors
//) MONITORENUMPROC;

//alias int function(
//  ENUMLOGFONT *lpelf,    // logical-font data
//  NEWTEXTMETRIC *lpntm,  // physical-font data
//  DWORD FontType,        // type of font
//  LPARAM lParam          // application-defined data
//)FONTENUMPROC;

//alias int function(
//  ENUMLOGFONTEX *lpelfe,    // logical-font data
//  NEWTEXTMETRICEX *lpntme,  // physical-font data
//  DWORD FontType,           // type of font
//  LPARAM lParam             // application-defined data
//)FONTENUMEXPROC;

alias BOOL function (
  LGRPID LanguageGroup,             // language-group identifier
  TCHAR* lpLanguageGroupString,     // language-group identifier string
  TCHAR* lpLanguageGroupNameString, // language-group name string
  DWORD dwFlags,                    // options
  LONG_PTR  lParam                  // callback parameter
)LANGUAGEGROUP_ENUMPROC;

//alias BOOL function (
//  TCHAR* lpLocaleString   // locale identifier string
//)LOCALE_ENUMPROC;


// end of Windows CALLBACK declaration



//struct ABC {
//    int     abcA;
//    UINT    abcB;
//    int     abcC;
//}
//alias ABC* PABC, LPABC;

// declared in tango
//struct ACCEL {
//    align(1):
//    BYTE   fVirt;
//    WORD   key;
//    WORD   cmd;
//}
//alias ACCEL* PACCEL, LPACCEL;

// declared in phobos
//struct BITMAP {
//  int bmType;
//  int bmWidth;
//  int bmHeight;
//  int bmWidthBytes;
//  short bmPlanes;
//  short bmBitsPixel;
//  void* bmBits;
//}

//struct RGBQUAD { // rgbq
//    byte    rgbBlue;
//    byte    rgbGreen;
//    byte    rgbRed;
//    byte    rgbReserved;
//}

// declared in phobos
//struct BITMAPINFO { // bmi
//    BITMAPINFOHEADER bmiHeader;
//    RGBQUAD          bmiColors[1];
//}

//struct BITMAPINFOHEADER {
//  int biSize;
//  int biWidth;
//  int biHeight;
//  short biPlanes;
//  short biBitCount;
//  int biCompression;
//  int biSizeImage;
//  int biXPelsPerMeter;
//  int biYPelsPerMeter;
//  int biClrUsed;
//  int biClrImportant;
//}



//struct CHARSETINFO {
//    UINT ciCharset;
//    UINT ciACP;
//    FONTSIGNATURE fs;
//}alias CHARSETINFO* PCHARSETINFO, LPCHARSETINFO;




struct COMBOBOXINFO {
    DWORD cbSize;
    RECT rcItem;
    RECT rcButton;
    DWORD stateButton;
    HWND hwndCombo;
    HWND hwndItem;
    HWND hwndList;
} alias COMBOBOXINFO* PCOMBOBOXINFO, LPCOMBOBOXINFO;

//struct COMPOSITIONFORM {
//    DWORD dwStyle;
//    POINT ptCurrentPos;
//    RECT rcArea;
//}
//alias COMPOSITIONFORM* LPCOMPOSITIONFORM;

// const uint CCHDEVICENAME = 32;
// const uint CCHFORMNAME = 32;

struct DEVMODEA {    // dvmd
    BYTE   dmDeviceName[CCHDEVICENAME];
    WORD   dmSpecVersion;
    WORD   dmDriverVersion;
    WORD   dmSize;
    WORD   dmDriverExtra;
    DWORD  dmFields;
//    union {
//      struct {
//        short dmOrientation;
//        short dmPaperSize;
//        short dmPaperLength;
//        short dmPaperWidth;
//      };
//      POINTL dmPosition;
//    };
    POINT  dmPosition;
    short  dmScale;
    short  dmCopies;
    short  dmDefaultSource;
    short  dmPrintQuality;
    short  dmColor;
    short  dmDuplex;
    short  dmYResolution;
    short  dmTTOption;
    short  dmCollate;
    BYTE  dmFormName[CCHFORMNAME];
    WORD  dmLogPixels;
    DWORD  dmBitsPerPel;
    DWORD  dmPelsWidth;
    DWORD  dmPelsHeight;
    DWORD  dmDisplayFlags;
    DWORD  dmDisplayFrequency;
//#if(WINVER >= 0x0400)
    DWORD  dmICMMethod;
    DWORD  dmICMIntent;
    DWORD  dmMediaType;
    DWORD  dmDitherType;
    DWORD  dmReserved1;
    DWORD  dmReserved2;
//#if (WINVER >= 0x0500) || (_WIN32_WINNT >= 0x0400)
    DWORD  dmPanningWidth;
    DWORD  dmPanningHeight;
//#endif
//#endif /* WINVER >= 0x0400 */
}

struct DEVMODEW {    // dvmd
    WCHAR  dmDeviceName[CCHDEVICENAME];
    WORD   dmSpecVersion;
    WORD   dmDriverVersion;
    WORD   dmSize;
    WORD   dmDriverExtra;
    DWORD  dmFields;
//    union {
//      struct {
//        short dmOrientation;
//        short dmPaperSize;
//        short dmPaperLength;
//        short dmPaperWidth;
//      };
      POINTL dmPosition;
//    };
    short  dmScale;
    short  dmCopies;
    short  dmDefaultSource;
    short  dmPrintQuality;
    short  dmColor;
    short  dmDuplex;
    short  dmYResolution;
    short  dmTTOption;
    short  dmCollate;
    WCHAR dmFormName[CCHFORMNAME];
    WORD  dmLogPixels;
    DWORD  dmBitsPerPel;
    DWORD  dmPelsWidth;
    DWORD  dmPelsHeight;
    DWORD  dmDisplayFlags;
    DWORD  dmDisplayFrequency;
//#if(WINVER >= 0x0400)
    DWORD  dmICMMethod;
    DWORD  dmICMIntent;
    DWORD  dmMediaType;
    DWORD  dmDitherType;
    DWORD  dmReserved1;
    DWORD  dmReserved2;
//#if (WINVER >= 0x0500) || (_WIN32_WINNT >= 0x0400)
    DWORD  dmPanningWidth;
    DWORD  dmPanningHeight;
//#endif
//#endif /* WINVER >= 0x0400 */
}

//PORTING_TODO: defined in tango
//version(Win32SansUnicode){
//    alias DEVMODEA DEVMODE;
//}else{
//    alias DEVMODEW DEVMODE;
//}

//struct DIBSECTION {
//    // BITMAP
//    int bmType;
//    int bmWidth;
//    int bmHeight;
//    int bmWidthBytes;
//    short bmPlanes;
//    short bmBitsPixel;
//    void* bmBits;
//    // end BITMAP
//    int biSize;
//    int biWidth;
//    int biHeight;
//    short biPlanes;
//    short biBitCount;
//    int biCompression;
//    int biSizeImage;
//    int biXPelsPerMeter;
//    int biYPelsPerMeter;
//    int biClrUsed;
//    int biClrImportant;
//    int dsBitfields0;
//    int dsBitfields1;
//    int dsBitfields2;
//    int dshSection;
//    int dsOffset;
//}

struct DLLVERSIONINFO {
    DWORD cbSize;
    DWORD dwMajorVersion;
    DWORD dwMinorVersion;
    DWORD dwBuildNumber;
    DWORD dwPlatformID;
}



struct DROPFILES {
    DWORD  pFiles; // Offset of the file list from the beginning of this structure, in bytes.
    POINT pt; // Drop point. The coordinates depend on fNC.
    BOOL fNC;   // Nonclient area flag. If this member is TRUE, pt specifies the screen
                      // coordinates of a point in a window's nonclient area. If it is FALSE,
                      // pt specifies the client coordinates of a point in the client area.
    BOOL fWide; // Value that indicates whether the file contains ANSI or Unicode
                      // characters. If it is zero, it contains ANSI characters. Otherwise, it
                      // contains Unicode characters.

}


// struct ENUMLOGFONTA {
//   LOGFONTA elfLogFont;
//   CHAR   elfFullName[LF_FULLFACESIZE];
//   CHAR   elfStyle[LF_FACESIZE];
// }
// struct ENUMLOGFONTW {
//   LOGFONTW elfLogFont;
//   WCHAR   elfFullName[LF_FULLFACESIZE];
//   WCHAR   elfStyle[LF_FACESIZE];
// }
// struct ENUMLOGFONTEXA {
//     LOGFONTA  elfLogFont;
//     BYTE  elfFullName[LF_FULLFACESIZE];
//     BYTE  elfStyle[LF_FACESIZE];
//     BYTE  elfScript[LF_FACESIZE];
// }
// struct ENUMLOGFONTEXW {
//     LOGFONTW  elfLogFont;
//     WCHAR  elfFullName[LF_FULLFACESIZE];
//     WCHAR  elfStyle[LF_FACESIZE];
//     WCHAR  elfScript[LF_FACESIZE];
// }
// version(Win32SansUnicode){
//     alias ENUMLOGFONTA ENUMLOGFONT;
//     alias ENUMLOGFONTEXA ENUMLOGFONTEX;
// }else {
//     alias ENUMLOGFONTW ENUMLOGFONT;
//     alias ENUMLOGFONTEXW ENUMLOGFONTEX;
// }

// in phobos aready
//struct FILETIME {
//    DWORD dwLowDateTime;
//    DWORD dwHighDateTime;
//}



struct GOFFSET {
  LONG  du;
  LONG  dv;
}

struct GRADIENT_RECT {
  ULONG    UpperLeft;
  ULONG    LowerRight;
}

struct GUITHREADINFO {
    DWORD cbSize;
    DWORD flags;
    HWND hwndActive;
    HWND hwndFocus;
    HWND hwndCapture;
    HWND hwndMenuOwner;
    HWND hwndMoveSize;
    HWND hwndCaret;
    RECT rcCaret;
}alias GUITHREADINFO* PGUITHREADINFO, LPGUITHREADINFO;

struct HDITEMA {
    UINT    mask;
    int     cxy;
    LPSTR  pszText;
    HBITMAP hbm;
    int     cchTextMax;
    int     fmt;
    LPARAM  lParam;
//#if (_WIN32_IE >= 0x0300)
    int     iImage;
    int     iOrder;
//#endif
//#if (_WIN32_IE >= 0x0500)
    UINT    type;
    void    *pvFilter;
//#endif
//#if _WIN32_WINNT >= 0x0600
//    UINT   state;
//#endif
}
struct HDITEMW {
    UINT    mask;
    int     cxy;
    LPWSTR  pszText;
    HBITMAP hbm;
    int     cchTextMax;
    int     fmt;
    LPARAM  lParam;
//#if (_WIN32_IE >= 0x0300)
    int     iImage;
    int     iOrder;
//#endif
//#if (_WIN32_IE >= 0x0500)
    UINT    type;
    void    *pvFilter;
//#endif
//#if _WIN32_WINNT >= 0x0600
//    UINT   state;
//#endif
}
version(Win32SansUnicode){
    alias HDITEMA HDITEM;
}else{
    alias HDITEMW HDITEM;
}
alias HDITEM* LPHDITEM;


//struct ICONINFO {
//   BOOL    fIcon;
//   DWORD   xHotspot;
//   DWORD   yHotspot;
//   HBITMAP hbmMask;
//   HBITMAP hbmColor;
//}
//alias ICONINFO*  PICONINFO, LPICONINFO;

struct INITCOMMONCONTROLSEX {
    DWORD dwSize;
    DWORD dwICC;
}alias INITCOMMONCONTROLSEX* PINITCOMMONCONTROLSEX, LPINITCOMMONCONTROLSEX;

struct INPUT {
    // Note: <Shawn> sizeof = 28
    int type;
  union {
        MOUSEINPUT mi;
        KEYBDINPUT ki;
//        HARDWAREINPUT hi;
    }
}alias INPUT* PINPUT, LPINPUT;

//struct ITEMIDLIST {
//    SHITEMID mkid;
//}
//alias ITEMIDLIST* PITEMIDLIST, LPITEMIDLIST, LPCITEMIDLIST;

struct KEYBDINPUT {
    WORD wVk;
    WORD wScan;
    DWORD dwFlags;
    DWORD time;
    ULONG_PTR dwExtraInfo;
}


// struct LOGBRUSH {
//   UINT     lbStyle;
//   COLORREF lbColor;
//   LONG     lbHatch;
// }



struct LVFINDINFOA {
    UINT flags;
    LPCSTR psz;
    LPARAM lParam;
    POINT pt;
    UINT vkDirection;
}
alias LVFINDINFOA* LPFINDINFOA;
struct LVFINDINFOW {
    UINT flags;
    LPCWSTR psz;
    LPARAM lParam;
    POINT pt;
    UINT vkDirection;
}
alias LVFINDINFOW* LPFINDINFOW;

version(Win32SansUnicode){
    alias LVFINDINFOA LVFINDINFO;
}else{
    alias LVFINDINFOW LVFINDINFO;
}


struct MARGINS {
    int cxLeftWidth;
    int cxRightWidth;
    int cyTopHeight;
    int cyBottomHeight;
}

struct MENUBARINFO {
  DWORD cbSize;
  RECT  rcBar;
  HMENU hMenu;
  HWND  hwndMenu;
  BOOL  flags;
    //fBarFocused : 1;
    //fFocused    : 1;
}
alias MENUBARINFO* PMENUBARINFO;
alias MENUBARINFO* LPMENUBARINFO;

struct MENUINFO {
  DWORD   cbSize;
  DWORD   fMask;
  DWORD   dwStyle;
  UINT    cyMax;
  HBRUSH  hbrBack;
  DWORD   dwContextHelpID;
  ULONG_PTR  dwMenuData;
}
alias MENUINFO* PCMENUINFO, LPCMENUINFO, LPCCMENUINFO;

/*
* Feature in Windows.  The hbmpItem field requires Windows 4.10
* or greater.  On Windows NT 4.0, passing in a larger struct size
* in the cbSize field does nothing.  On Windows 95, the MENUITEMINFO
* calls fail when the struct size is too large.  The fix is to ensure
* that the correct struct size is used for the Windows platform.
*/
// struct MENUITEMINFOA
// {
//     UINT    cbSize;
//     UINT    fMask;
//     UINT    fType;          // used if MIIM_TYPE
//     UINT    fState;         // used if MIIM_STATE
//     UINT    wID;            // used if MIIM_ID
//     HMENU   hSubMenu;       // used if MIIM_SUBMENU
//     HBITMAP hbmpChecked;    // used if MIIM_CHECKMARKS
//     HBITMAP hbmpUnchecked;  // used if MIIM_CHECKMARKS
//     DWORD   dwItemData;     // used if MIIM_DATA
//     LPSTR   dwTypeData;     // used if MIIM_TYPE
//     UINT    cch;            // used if MIIM_TYPE
//     HBITMAP hbmpItem;
// }
// alias MENUITEMINFOA* PMENUITEMINFOA, LPMENUITEMINFOA;
// struct MENUITEMINFOW
// {
//     UINT    cbSize;
//     UINT    fMask;
//     UINT    fType;          // used if MIIM_TYPE
//     UINT    fState;         // used if MIIM_STATE
//     UINT    wID;            // used if MIIM_ID
//     HMENU   hSubMenu;       // used if MIIM_SUBMENU
//     HBITMAP hbmpChecked;    // used if MIIM_CHECKMARKS
//     HBITMAP hbmpUnchecked;  // used if MIIM_CHECKMARKS
//     DWORD   dwItemData;     // used if MIIM_DATA
//     LPWSTR  dwTypeData;     // used if MIIM_TYPE
//     UINT    cch;            // used if MIIM_TYPE
//     HBITMAP hbmpItem;
// }   alias MENUITEMINFOW* PMENUITEMINFOW, LPMENUITEMINFOW;
//version(Win32SansUnicode){
//    alias MENUITEMINFOA MENUITEMINFO;
//}else{
//    alias MENUITEMINFOW MENUITEMINFO;
//}
//alias MENUITEMINFO * LPMENUITEMINFO;


//struct MONITORINFO {
//    DWORD  cbSize;
//    RECT   rcMonitor;
//    RECT   rcWork;
//    DWORD  dwFlags;
//}
//alias MONITORINFO* PMONITORINFO, LPMONITORINFO;

struct MOUSEINPUT {
    LONG      dx;
    LONG      dy;
    DWORD     mouseData;
    DWORD     dwFlags;
    DWORD     time;
    ULONG_PTR dwExtraInfo;
}

//struct MSG {
//  int hwnd;
//  int message;
//  int wParam;
//  int lParam;
//  int time;
////    POINT pt;
//  int x, y;
//}
/+
struct NEWTEXTMETRICA { // ntm
    LONG   tmHeight;
    LONG   tmAscent;
    LONG   tmDescent;
    LONG   tmInternalLeading;
    LONG   tmExternalLeading;
    LONG   tmAveCharWidth;
    LONG   tmMaxCharWidth;
    LONG   tmWeight;
    LONG   tmOverhang;
    LONG   tmDigitizedAspectX;
    LONG   tmDigitizedAspectY;
    BYTE  tmFirstChar;
    BYTE  tmLastChar;
    BYTE  tmDefaultChar;
    BYTE  tmBreakChar;
    BYTE   tmItalic;
    BYTE   tmUnderlined;
    BYTE   tmStruckOut;
    BYTE   tmPitchAndFamily;
    BYTE   tmCharSet;
    DWORD  ntmFlags;
    UINT   ntmSizeEM;
    UINT   ntmCellHeight;
    UINT   ntmAvgWidth;
}
struct NEWTEXTMETRICW { // ntm
    LONG   tmHeight;
    LONG   tmAscent;
    LONG   tmDescent;
    LONG   tmInternalLeading;
    LONG   tmExternalLeading;
    LONG   tmAveCharWidth;
    LONG   tmMaxCharWidth;
    LONG   tmWeight;
    LONG   tmOverhang;
    LONG   tmDigitizedAspectX;
    LONG   tmDigitizedAspectY;
    WCHAR  tmFirstChar;
    WCHAR  tmLastChar;
    WCHAR  tmDefaultChar;
    WCHAR  tmBreakChar;
    BYTE   tmItalic;
    BYTE   tmUnderlined;
    BYTE   tmStruckOut;
    BYTE   tmPitchAndFamily;
    BYTE   tmCharSet;
    DWORD  ntmFlags;
    UINT   ntmSizeEM;
    UINT   ntmCellHeight;
    UINT   ntmAvgWidth;
}
struct NEWTEXTMETRICEXA {
    NEWTEXTMETRICA  ntmentm;
    FONTSIGNATURE  ntmeFontSignature;
}
struct NEWTEXTMETRICEXW {
    NEWTEXTMETRICW  ntmentm;
    FONTSIGNATURE  ntmeFontSignature;
}
version(Win32SansUnicode){
    alias NEWTEXTMETRICA NEWTEXTMETRIC;
    alias NEWTEXTMETRICEXA NEWTEXTMETRICEX;
}else{
    alias NEWTEXTMETRICW NEWTEXTMETRIC;
    alias NEWTEXTMETRICEXW NEWTEXTMETRICEX;
}
+/

struct NMCUSTOMDRAW {
    NMHDR  hdr;
    DWORD  dwDrawStage;
    HDC    hdc;
    RECT   rc;
    DWORD_PTR dwItemSpec;
    UINT   uItemState;
    LPARAM lItemlParam;
}

struct NMHEADER {
    NMHDR    hdr;
    int      iItem;
    int      iButton;
    HDITEM  *pitem;
}

struct NMLISTVIEW {
    NMHDR   hdr;
    int     iItem;
    int     iSubItem;
    UINT    uNewState;
    UINT    uOldState;
    UINT    uChanged;
    POINT   ptAction;
    LPARAM  lParam;
}

struct NMLVCUSTOMDRAW {
    NMCUSTOMDRAW nmcd;
    COLORREF clrText;
    COLORREF clrTextBk;
//#if (_WIN32_IE >= 0x0400)
    int iSubItem;
//#endif
//if (_WIN32_IE >= 0x560)
    DWORD dwItemType;
    // Item Custom Draw	
    COLORREF clrFace;
    int iIconEffect;
    int iIconPhase;
    int iPartId;
    int iStateId;
    // Group Custom Draw
    RECT rcText;
    UINT uAlign;
//endif
}

struct NMLVDISPINFOA {
    NMHDR hdr;
    LVITEMA item;
}
struct NMLVDISPINFOW {
    NMHDR hdr;
    LVITEMW item;
}
version(Win32SansUnicode){
    alias NMLVDISPINFOA NMLVDISPINFO;
}else{
    alias NMLVDISPINFOW NMLVDISPINFO;
}

struct NMLVFINDITEMA {
    NMHDR hdr;
    int iStart;
    LVFINDINFOA lvfi;
}

struct NMLVFINDITEMW {
    NMHDR hdr;
    int iStart;
    LVFINDINFOW lvfi;
}
version(Win32SansUnicode){
    alias NMLVFINDITEMA NMLVFINDITEM;
}else{
    alias NMLVFINDITEMW NMLVFINDITEM;
}

struct NMREBARCHEVRON {
    NMHDR hdr;
    UINT uBand;
    UINT wID;
    LPARAM lParam;
    RECT rc;
    LPARAM lParamNM;
}

struct NMRGINFO {
    // NMHDR
    HWND hwndFrom;
    int idFrom;
    int code;
    // -end- NMHDR
//  POINT ptAction;
    int x;
    int y;
    int dwItemSpec;
}


struct NMTVCUSTOMDRAW {
    NMCUSTOMDRAW nmcd;
    COLORREF clrText;
    COLORREF clrTextBk;
//#if (_WIN32_IE &gt;= 0x0400)
    int iLevel; // the iLevel field does not appear on WinCE
//#endif
}


struct NOTIFYICONDATAA {
    DWORD cbSize;
    HWND hWnd;
    UINT uID;
    UINT uFlags;
    UINT uCallbackMessage;
    HICON hIcon;
    char szTip[128] = '\0';
    DWORD dwState;
    DWORD dwStateMask;
    char szInfo[256] = '\0';
    union {
        UINT uTimeout;
        UINT uVersion;
    };
    char szInfoTitle[64] = '\0';
    DWORD dwInfoFlags;
    GUID guidItem;
    HICON hBalloonIcon;
} alias NOTIFYICONDATAA* PNOTIFYICONDATAA, LPNOTIFYICONDATAA;

struct NOTIFYICONDATAW {
    DWORD cbSize;
    HWND hWnd;
    UINT uID;
    UINT uFlags;
    UINT uCallbackMessage;
    HICON hIcon;
    WCHAR szTip[128] = '\0';
    DWORD dwState;
    DWORD dwStateMask;
    WCHAR szInfo[256] = '\0';
    union {
        UINT uTimeout;
        UINT uVersion;
    }
    WCHAR szInfoTitle[64] = '\0';
    DWORD dwInfoFlags;
    GUID guidItem;
    HICON hBalloonIcon;
}

alias NOTIFYICONDATAW* PNOTIFYICONDATAW, LPNOTIFYICONDATAW;
version(Win32SansUnicode){
    alias NOTIFYICONDATAA NOTIFYICONDATA;
}else{
    alias NOTIFYICONDATAW NOTIFYICONDATA;
}

/* already in phobos now

struct OPENFILENAMEA {
   DWORD        lStructSize;
   HWND         hwndOwner;
   HINSTANCE    hInstance;
   LPCSTR       lpstrFilter;
   LPSTR        lpstrCustomFilter;
   DWORD        nMaxCustFilter;
   DWORD        nFilterIndex;
   LPSTR        lpstrFile;
   DWORD        nMaxFile;
   LPSTR        lpstrFileTitle;
   DWORD        nMaxFileTitle;
   LPCSTR       lpstrInitialDir;
   LPCSTR       lpstrTitle;
   DWORD        Flags;
   WORD         nFileOffset;
   WORD         nFileExtension;
   LPCSTR       lpstrDefExt;
   LPARAM       lCustData;
   LPOFNHOOKPROC lpfnHook;
   LPCSTR       lpTemplateName;
}

struct OPENFILENAMEW {
   DWORD        lStructSize;
   HWND         hwndOwner;
   HINSTANCE    hInstance;
   LPCWSTR      lpstrFilter;
   LPWSTR       lpstrCustomFilter;
   DWORD        nMaxCustFilter;
   DWORD        nFilterIndex;
   LPWSTR       lpstrFile;
   DWORD        nMaxFile;
   LPWSTR       lpstrFileTitle;
   DWORD        nMaxFileTitle;
   LPCWSTR      lpstrInitialDir;
   LPCWSTR      lpstrTitle;
   DWORD        Flags;
   WORD         nFileOffset;
   WORD         nFileExtension;
   LPCWSTR      lpstrDefExt;
   LPARAM       lCustData;
   LPOFNHOOKPROC lpfnHook;
   LPCWSTR      lpTemplateName;
}
*/

//PORTING_TODO: is needed?
//version(Win32SansUnicode){
//    alias OPENFILENAMEA OPENFILENAME;
//}else{
//    alias OPENFILENAMEW OPENFILENAME;
//}


//struct PAINTSTRUCT {
//  int hdc;
//  int fErase;
////    RECT rcPaint;
//  public int left, top, right, bottom;
//  int fRestore;
//  int fIncUpdate;
//  byte rgbReserved[32];
//}
//alias windows.PAINTSTRUCT PAINTSTRUCT;

//struct POINT {
//  LONG x, y;
//}


struct REBARBANDINFOA {
    UINT        cbSize;
    UINT        fMask;
    UINT        fStyle;
    COLORREF    clrFore;
    COLORREF    clrBack;
    LPSTR      lpText;
    UINT        cch;
    int         iImage;
    HWND        hwndChild;
    UINT        cxMinChild;
    UINT        cyMinChild;
    UINT        cx;
    HBITMAP     hbmBack;
    UINT        wID;
//if (_WIN32_IE >= 0x0400)
    UINT        cyChild;
    UINT        cyMaxChild;
    UINT        cyIntegral;
    UINT        cxIdeal;
    LPARAM      lParam;
    UINT        cxHeader;
    /* Note in WinCE.  The field cxHeader is not defined. */
//endif
//if (_WIN32_WINNT >= 0x0600)
//    RECT        rcChevronLocation;  
//    UINT        uChevronState; 
//endif
}
struct REBARBANDINFOW {
    UINT        cbSize;
    UINT        fMask;
    UINT        fStyle;
    COLORREF    clrFore;
    COLORREF    clrBack;
    LPWSTR      lpText;
    UINT        cch;
    int         iImage;
    HWND        hwndChild;
    UINT        cxMinChild;
    UINT        cyMinChild;
    UINT        cx;
    HBITMAP     hbmBack;
    UINT        wID;
//if (_WIN32_IE >= 0x0400)
    UINT        cyChild;
    UINT        cyMaxChild;
    UINT        cyIntegral;
    UINT        cxIdeal;
    LPARAM      lParam;
    UINT        cxHeader;
    /* Note in WinCE.  The field cxHeader is not defined. */
//endif
//if (_WIN32_WINNT >= 0x0600)
//    RECT        rcChevronLocation;  
//    UINT        uChevronState; 
//endif
}
version(Win32SansUnicode){
    alias REBARBANDINFOA REBARBANDINFO;
}else{
    alias REBARBANDINFOW REBARBANDINFO;
}

//struct RECT {
//  int left;
//  int top;
//  int right;
//  int bottom;
//}

//struct RGNDATA {
//    RGNDATAHEADER rdh;
//    char          Buffer[1];
//} alias RGNDATA* PRGNDATA, LPRGNDATA;



template BITWISE(T)
{
    // bit value set
    void btvs(T* pData, uint bitnum, uint val){
        *pData &=  ~(0x01 << bitnum);
        if(val) *pData |= (0x01 << bitnum);
    }
    // bit value get
    T btvg(T* pData, uint bitnum){
        return cast(T)((*pData >> bitnum) & 0x01);
    }
}
alias BITWISE!(BYTE).btvs btvs;
alias BITWISE!(WORD).btvs btvs;
alias BITWISE!(DWORD).btvs btvs;
alias BITWISE!(BYTE).btvg btvg;
alias BITWISE!(WORD).btvg btvg;
alias BITWISE!(DWORD).btvg btvg;


struct SCRIPT_ANALYSIS {
    WORD BITS;
    SCRIPT_STATE s;

    // getter
    uint eScript()      { return BITS & 0x03FFU; }
    uint fRTL()         { return btvg(&BITS, 10); }
    uint fLayoutRTL()   { return btvg(&BITS, 11); }
    uint fLinkBefore()  { return btvg(&BITS, 12); }
    uint fLinkAfter()   { return btvg(&BITS, 13); }
    uint fLogicalOrder(){ return btvg(&BITS, 14); }
    uint fNoGlyphIndex(){ return btvg(&BITS, 15); }
    // setter
    void eScript(uint val)      { BITS &= 0xFC00; BITS |= (val & 0x03FF); }
    void fRTL(uint val)         { btvs(&BITS, 10, val); }
    void fLayoutRTL(uint val)   { btvs(&BITS, 11, val); }
    void fLinkBefore(uint val)  { btvs(&BITS, 12, val); }
    void fLinkAfter(uint val)   { btvs(&BITS, 13, val); }
    void fLogicalOrder(uint val){ btvs(&BITS, 14, val); }
    void fNoGlyphIndex(uint val){ btvs(&BITS, 15, val); }
}

alias void *SCRIPT_CACHE;

struct SCRIPT_CONTROL {
    align(1):
    WORD uDefaultLanguage;
    BYTE BITS;
    BYTE fReserved;

    // getter
    uint fContextDigits()       { return btvg(&BITS, 0); }
    uint fInvertPreBoundDir()   { return btvg(&BITS, 1); }
    uint fInvertPostBoundDir()  { return btvg(&BITS, 2); }
    uint fLinkStringBefore()    { return btvg(&BITS, 3); }
    uint fLinkStringAfter()     { return btvg(&BITS, 4); }
    uint fNeutralOverride()     { return btvg(&BITS, 5); }
    uint fNumericOverride()     { return btvg(&BITS, 6); }
    uint fLegacyBidiClass()     { return btvg(&BITS, 7); }

    void fContextDigits(uint val)       { btvs(&BITS, 0, val); }
    void fInvertPreBoundDir(uint val)   { btvs(&BITS, 1, val); }
    void fInvertPostBoundDir(uint val)  { btvs(&BITS, 2, val); }
    void fLinkStringBefore(uint val)    { btvs(&BITS, 3, val); }
    void fLinkStringAfter(uint val)     { btvs(&BITS, 4, val); }
    void fNeutralOverride(uint val)     { btvs(&BITS, 5, val); }
    void fNumericOverride(uint val)     { btvs(&BITS, 6, val); }
    void fLegacyBidiClass(uint val)     { btvs(&BITS, 7, val); }
}

struct SCRIPT_FONTPROPERTIES {
  int   cBytes;
  WORD  wgBlank;
  WORD  wgDefault;
  WORD  wgInvalid;
  WORD  wgKashida;
  int   iKashidaWidth;
}

struct SCRIPT_ITEM {
    int iCharPos;
    SCRIPT_ANALYSIS a;
}

struct SCRIPT_LOGATTR {
    align(1):
    BYTE BITS;

    // gettter
    uint fSoftBreak()   { return btvg(&BITS, 0); }
    uint fWhiteSpace()  { return btvg(&BITS, 1); }
    uint fCharStop()    { return btvg(&BITS, 2); }
    uint fWordStop()    { return btvg(&BITS, 3); }
    uint fInvalid()     { return btvg(&BITS, 4); }
    uint fReserved()    { return cast(BYTE)(BITS>>5); }

    void fSoftBreak(uint val)   { btvs(&BITS, 0, val); }
    void fWhiteSpace(uint val)  { btvs(&BITS, 1, val); }
    void fCharStop(uint val)    { btvs(&BITS, 2, val); }
    void fWordStop(uint val)    { btvs(&BITS, 3, val); }
    void fInvalid(uint val)     { btvs(&BITS, 4, val); }
    void fReserved(uint val)    { BITS &= 0x1F; BITS |= (val & 0x07)<<5; }
}


struct SCRIPT_PROPERTIES {
    DWORD   BITS1;
    DWORD   BITS2;

    uint langid()   { return BITS1 >> 16; }
    uint fNumeric() { return btvg(&BITS1, 16); }
    uint fComplex() { return btvg(&BITS1, 17); }
    uint fNeedsWordBreaking()   { return btvg(&BITS1, 18); }
    uint fNeedsCaretInfo()      { return btvg(&BITS1, 19); }
    uint bCharSet()             { return (BITS1 >> 20) & 0xFF; }
    uint fControl()             { return btvg(&BITS1, 28); }
    uint fPrivateUseArea()      { return btvg(&BITS1, 29); }
    uint fNeedsCharacterJustify(){ return btvg(&BITS1, 30); }
    uint fInvalidGlyph()        { return btvg(&BITS1, 31); }
    uint fInvalidLogAttr()      { return btvg(&BITS2, 0); }
    uint fCDM()                 { return btvg(&BITS2, 1); }
    uint fAmbiguousCharSet()    { return btvg(&BITS2, 2); }
    uint fClusterSizeVaries()   { return btvg(&BITS2, 3); }
    uint fRejectInvalid()       { return btvg(&BITS2, 4); }

    void langid(uint val)       { BITS1 &= 0xFFFF0000; BITS1 |= (val & 0xFFFF); }
    void fNumeric(uint val)             { btvs(&BITS1, 16, val); }
    void fComplex(uint val)             { btvs(&BITS1, 17, val); }
    void fNeedsWordBreaking(uint val)   { btvs(&BITS1, 18, val); }
    void fNeedsCaretInfo(uint val)      { btvs(&BITS1, 19, val); }
    void bCharSet(uint val)             { BITS1 &= 0xF00FFFFF; BITS1 |= (val & 0xFF)<<20; }
    void fControl(uint val)             { btvs(&BITS1, 28, val); }
    void fPrivateUseArea(uint val)      { btvs(&BITS1, 29, val); }
    void fNeedsCharacterJustify(uint val){ btvs(&BITS1, 30, val); }
    void fInvalidGlyph(uint val)        { btvs(&BITS1, 31, val); }
    void fInvalidLogAttr(uint val)      { btvs(&BITS2, 0, val); }
    void fCDM(uint val)                 { btvs(&BITS2, 1, val); }
    void fAmbiguousCharSet(uint val)    { btvs(&BITS2, 2, val); }
    void fClusterSizeVaries(uint val)   { btvs(&BITS2, 3, val); }
    void fRejectInvalid(uint val)       { btvs(&BITS2, 4, val); }
}


struct SCRIPT_STATE {
    WORD BITS;
    // getter
    uint uBidiLevel()           { return (BITS & 0x1F);}
    uint fOverrideDirection()   { return btvg(&BITS, 5); }
    uint fInhibitSymSwap()      { return btvg(&BITS, 6); }
    uint fCharShape()           { return btvg(&BITS, 7); }
    uint fDigitSubstitute()     { return btvg(&BITS, 8); }
    uint fInhibitLigate()       { return btvg(&BITS, 9); }
    uint fDisplayZWG()          { return btvg(&BITS, 10); }
    uint fArabicNumContext()    { return btvg(&BITS, 11); }
    uint fGcpClusters()         { return btvg(&BITS, 12); }
    uint fReserved()            { return btvg(&BITS, 13); }
    uint fEngineReserved()      { return (BITS >> 14) & 0x03;}
    // setter
    void uBidiLevel(uint val)           { BITS &= 0xFFE0; BITS |= (val & 0x1F); }
    void fOverrideDirection(uint val)   { btvs(&BITS, 5, val); }
    void fInhibitSymSwap(uint val)      { btvs(&BITS, 6, val); }
    void fCharShape(uint val)           { btvs(&BITS, 7, val); }
    void fDigitSubstitute(uint val)     { btvs(&BITS, 8, val); }
    void fInhibitLigate(uint val)       { btvs(&BITS, 9, val); }
    void fDisplayZWG(uint val)          { btvs(&BITS, 10, val); }
    void fArabicNumContext(uint val)    { btvs(&BITS, 11, val); }
    void fGcpClusters(uint val)         { btvs(&BITS, 12, val); }
    void fReserved(uint val)            { btvs(&BITS, 13, val); }
    void fEngineReserved(uint val)      { BITS &= 0x3FFF; BITS |= ((val & 0x03) << 14); }
}


struct SCRIPT_VISATTR {
    align(1):
    BYTE BITS;
    BYTE fShapeReserved;

    // getter
    uint uJustification()   { return BITS & 0x0F; }
    uint fClusterStart()    { return btvg(&BITS, 4); }
    uint fDiacritic()       { return btvg(&BITS, 5); }
    uint fZeroWidth()       { return btvg(&BITS, 6); }
    uint fReserved()        { return btvg(&BITS, 7); }

    // setter
    void uJustification(uint val)   { BITS &= 0xF0; BITS |= (val & 0x0F); }
    void fClusterStart(uint val)    { btvs(&BITS, 4, val); }
    void fDiacritic(uint val)       { btvs(&BITS, 5, val); }
    void fZeroWidth(uint val)       { btvs(&BITS, 6, val); }
    void fReserved(uint val)        { btvs(&BITS, 7, val); }
}

//struct SCROLLINFO {
//    UINT cbSize;
//    UINT fMask;
//    int  nMin;
//    int  nMax;
//    UINT nPage;
//    int  nPos;
//    int  nTrackPos;
//}
//alias SCROLLINFO* PSCROLLINFO, LPSCROLLINFO, LPCSCROLLINFO;

version(WinCE)
{
struct SHACTIVATEINFO {
    int cbSize;
    HWND hwndLastFocus;
    int fSipUp;
    int fSipOnDeactivation;
    int fActive;
    int fReserved;
}
}

struct SHELLEXECUTEINFOA {
    DWORD cbSize;
    ULONG fMask;
    HWND hwnd;
    LPCSTR lpVerb;
    LPCSTR lpFile;
    LPCSTR lpParameters;
    LPCSTR lpDirectory;
    int nShow;
    HINSTANCE hInstApp;

    // Optional members
    LPVOID lpIDList;
    LPCSTR lpClass;
    HKEY hkeyClass;
    DWORD dwHotKey;
    HANDLE hIcon;
    HANDLE hProcess;
} alias SHELLEXECUTEINFOA* PSHELLEXECUTEINFOA, LPSHELLEXECUTEINFOA;
struct SHELLEXECUTEINFOW {
    DWORD cbSize;
    ULONG fMask;
    HWND hwnd;
    LPCWSTR lpVerb;
    LPCWSTR lpFile;
    LPCWSTR lpParameters;
    LPCWSTR lpDirectory;
    int nShow;
    HINSTANCE hInstApp;

    // Optional members
    LPVOID lpIDList;
    LPCWSTR lpClass;
    HKEY hkeyClass;
    DWORD dwHotKey;
    HANDLE hIcon;
    HANDLE hProcess;
} alias SHELLEXECUTEINFOW* PSHELLEXECUTEINFOW, LPSHELLEXECUTEINFOW;
version(Win32SansUnicode){
    alias SHELLEXECUTEINFOA SHELLEXECUTEINFO;
}else{
    alias SHELLEXECUTEINFOW SHELLEXECUTEINFO;
}
alias SHELLEXECUTEINFO* LPSHELLEXECUTEINFO;


//version(WinCE)
//{
    struct SHMENUBARINFO {
        int cbSize;
        HWND hwndParent;
        int dwFlags;
        int nToolBarId;
        HINSTANCE hInstRes;
        int nBmpId;
        int cBmpImages;
        HWND hwndMB;
    }

    struct SHRGINFO {
        DWORD cbSize;
        HWND hwndClient;
        POINT ptDown;
        DWORD dwFlags;
    }

    struct SIPINFO {
        DWORD cbSize;
        DWORD fdwFlags;
        RECT rcVisibleDesktop;
        RECT rcSipRect;
        DWORD dwImDataSize;
        VOID *pvImData;
    }
//} // end of version WinCE

//struct SIZE {
//  LONG cx;
//  LONG cy;
//}
//alias SIZE* LPSIZE, LPSIZEL;
//alias SIZE SIZEL;


struct TBBUTTONINFOA{
    align(2):
    UINT cbSize;
    DWORD dwMask;
    int idCommand;
    int iImage;
    BYTE fsState;
    BYTE fsStyle;
    WORD cx;
    DWORD_PTR lParam;
    LPSTR pszText;
    int cchText;
}
struct TBBUTTONINFOW{
    align(2):
    UINT cbSize;
    DWORD dwMask;
    int idCommand;
    int iImage;
    BYTE fsState;
    BYTE fsStyle;
    WORD cx;
    DWORD_PTR lParam;
    LPWSTR pszText;
    int cchText;
}
version(Win32SansUnicode){
    alias TBBUTTONINFOA TBBUTTONINFO;
}else{
    alias TBBUTTONINFOW TBBUTTONINFO;
}
alias TBBUTTONINFO* LPTBBUTTONINFO;


struct TCITEMA {
    UINT mask;
    DWORD dwState;
    DWORD dwStateMask;
    LPSTR pszText;
    int cchTextMax;
    int iImage;
    LPARAM lParam;
}
struct TCITEMW {
    UINT mask;
    DWORD dwState;
    DWORD dwStateMask;
    LPWSTR pszText;
    int cchTextMax;
    int iImage;
    LPARAM lParam;
}
version(Win32SansUnicode){
    alias TCITEMA TCITEM;
}else{
    alias TCITEMW TCITEM;
}


// struct TOOLINFOA {
//     UINT cbSize;
//     UINT uFlags;
//     HWND hwnd;
//     UINT uId;
//     RECT rect;
//     HINSTANCE hinst;
//     LPSTR lpszText;
//     LPARAM lParam;
// }
// struct TOOLINFOW {
//     UINT cbSize;
//     UINT uFlags;
//     HWND hwnd;
//     UINT uId;
//     RECT rect;
//     HINSTANCE hinst;
//     LPWSTR lpszText;
//     LPARAM lParam;
// }
// version(Win32SansUnicode){
//     alias TOOLINFOA TOOLINFO;
// }else{
//     alias TOOLINFOW TOOLINFO;
// }

struct TRACKMOUSEEVENT {
    DWORD cbSize;
    DWORD dwFlags;
    HWND hwndTrack;
    DWORD dwHoverTime;
}
alias TRACKMOUSEEVENT* PTRACKMOUSEEVENT, LPTRACKMOUSEEVENT;

struct TRIVERTEX {
  LONG        x;
  LONG        y;
  COLOR16     Red;
  COLOR16     Green;
  COLOR16     Blue;
  COLOR16     Alpha;
}
alias TRIVERTEX* PTRIVERTEX, LPTRIVERTEX;


struct TVHITTESTINFO {
    POINT pt;
    UINT flags;
    HTREEITEM hItem;
}






//alias extern(Windows) int (*PFNTVCOMPARE)(LPARAM, LPARAM, LPARAM);
struct TVSORTCB {
    HTREEITEM hParent;
    PFNTVCOMPARE lpfnCompare;
    LPARAM lParam;
}




//struct WINDOWPLACEMENT {
//    UINT length;
//    UINT flags;
//    UINT showCmd;
//    POINT ptMinPosition;
//    POINT ptMaxPosition;
//    RECT rcNormalPosition;
//}
//
// struct WINDOWPOS {
//     HWND hwnd;
//     HWND hwndInsertAfter;
//     int x;
//     int y;
//     int cx;
//     int cy;
//     UINT flags;
// }

// WNDCLASSA is declared in phobos
// struct WNDCLASSW {
//     UINT        style;
//     WNDPROC_I     lpfnWndProc;
//     int         cbClsExtra;
//     int         cbWndExtra;
//     HINSTANCE   hInstance;
//     HICON       hIcon;
//     HCURSOR     hCursor;
//     HBRUSH      hbrBackground;
//     LPCWSTR     lpszMenuName;
//     LPCWSTR     lpszClassName;
// }alias WNDCLASSW* PWNDCLASSW, LPWNDCLASSW;
//
// // since phobos has alias WNDCLASSA to WNDCLASS, we have to alias it another name
// version(Win32SansUnicode){
//     alias WNDCLASSA WNDCLASS_T;
// }else{
//     alias WNDCLASSW WNDCLASS_T;
// }

enum TF_DA_COLORTYPE {
  TF_CT_NONE = 0,
  TF_CT_SYSCOLOR = 1,
  TF_CT_COLORREF = 2
}

enum TF_DA_LINESTYLE {
  TF_LS_NONE = 0,
  TF_LS_SOLID = 1,
  TF_LS_DOT = 2,
  TF_LS_DASH = 3,
  TF_LS_SQUIGGLE = 4
}

enum TF_DA_ATTR_INFO {
  TF_ATTR_INPUT = 0,
  TF_ATTR_TARGET_CONVERTED = 1,
  TF_ATTR_CONVERTED = 2,
  TF_ATTR_TARGET_NOTCONVERTED = 3,
  TF_ATTR_INPUT_ERROR = 4,
  TF_ATTR_FIXEDCONVERTED = 5,
  TF_ATTR_OTHER = -1
}

struct TF_DA_COLOR {
  TF_DA_COLORTYPE type;
  union {
    int nIndex;
    COLORREF cr;
  };
}

struct TF_DISPLAYATTRIBUTE{
  TF_DA_COLOR crText;
  TF_DA_COLOR crBk;
  TF_DA_LINESTYLE lsStyle;
  BOOL fBoldLine;
  TF_DA_COLOR crLine;
  TF_DA_ATTR_INFO bAttr;
}

struct NMTTCUSTOMDRAW {
    NMCUSTOMDRAW nmcd;
    UINT uDrawFlags;
}
alias NMTTCUSTOMDRAW* LPNMTTCUSTOMDRAW;

struct SHDRAGIMAGE {
    SIZE sizeDragImage;
    POINT ptOffset;
    HBITMAP hbmpDragImage;
    COLORREF crColorKey;
}

const CCHILDREN_SCROLLBAR = 5;
struct SCROLLBARINFO {
    DWORD cbSize;
    RECT rcScrollBar;
    int dxyLineButton;
    int xyThumbTop;
    int xyThumbBottom;
    int reserved;
    DWORD rgstate[CCHILDREN_SCROLLBAR+1];
}
alias SCROLLBARINFO* PSCROLLBARINFO;

}   // end of extern(Windows)





// shlwapi.h
enum {ASSOCF_INIT_BYEXENAME,
    ASSOCF_OPEN_BYEXENAME,
    ASSOCF_INIT_DEFAULTTOSTAR,
    ASSOCF_INIT_DEFAULTTOFOLDER,
    ASSOCF_NOUSERSETTINGS,
    ASSOCF_NOTRUNCATE,
    ASSOCF_VERIFY,
    ASSOCF_REMAPRUNDLL,
    ASSOCF_NOFIXUPS,
    ASSOCF_IGNOREBASECLASS
};

alias DWORD ASSOCF;

// usp10
alias void* SCRIPT_STRING_ANALYSIS;
struct SCRIPT_TABDEF {
  int cTabStops;
  int iScale;
  int* pTabStops;
  int iTabOrigin;
}

//struct SCRIPT_ANALYSIS {
//    mixin(bitfields!(
//        ushort, "eScript", 10,
//        bool, "fRTL", 1,
//        bool, "fLayoutRTL", 1,
//        bool, "fLinkBefore", 1,
//        bool, "fLinkAfter", 1,
//        bool, "fLogicalOrder", 1,
//        bool, "fNoGlyphIndex", 1));
//    SCRIPT_STATE s ;
//}
//struct SCRIPT_STATE {
//    mixin(bitfields!(
//        ubyte, "uBidiLevel",  5,
//        bool, "fOverrideDirection", 1,
//        bool, "fInhibitSymSwap", 1,
//        bool, "fCharShape", 1,
//        bool, "fDigitSubstitute", 1,
//        bool, "fInhibitLigate", 1,
//        bool, "fDisplayZWG", 1,
//        bool, "fArabicNumContext", 1,
//        bool, "fGcpClusters", 1,
//        bool, "fReserved", 1,
//        ubyte, "fEngineReserved", 2));
//}
//
//struct SCRIPT_CONTROL {
//    mixin(bitfields!(
//        ushort, "uDefaultLanguage", 16,
//        bool, "fContextDigits", 1,
//        bool, "fInvertPreBoundDir", 1,
//        bool, "fInvertPostBoundDir", 1,
//        bool, "fLinkStringBefore", 1,
//        bool, "fLinkStringAfter", 1,
//        bool, "fNeutralOverride", 1,
//        bool, "fNumericOverride", 1,
//        bool, "fLegacyBidiClass", 1,
//        ubyte, "fReserved", 8));
//}
//
