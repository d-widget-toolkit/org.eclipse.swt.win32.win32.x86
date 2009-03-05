/**
 * This module declared window APIs required by SWT but not in std.c.windows.windows,
 * The one in the std.c.windows.windows module are aliased
 */


module org.eclipse.swt.internal.win32.WINAPI;

public import org.eclipse.swt.internal.win32.WINTYPES;

import tango.sys.win32.Types;

////////////////////////////////////////////////////////////////////////////////////////
// org.eclipse.swt
////////////////////////////////////////////////////////////////////////////////////////

alias HANDLE HPAINTBUFFER;

extern (Windows){
HRESULT AssocQueryStringA(ASSOCF flags, int str, LPCSTR pszAssoc, LPCSTR pszExtra, LPSTR pszOut, DWORD *pcchOut);
HRESULT AssocQueryStringW(ASSOCF flags, int str, LPCWSTR pszAssoc, LPCWSTR pszExtra, LPWSTR pszOut, DWORD *pcchOut);
int AddFontResourceExA(char* lpszFilename, int fl, void* pdv);
int AddFontResourceExW(wchar* lpszFilename, int fl, void* pdv);

BOOL AlphaBlend(
  HDC hdcDest,                 // handle to destination DC
  int nXOriginDest,            // x-coord of upper-left corner
  int nYOriginDest,            // y-coord of upper-left corner
  int nWidthDest,              // destination width
  int nHeightDest,             // destination height
  HDC hdcSrc,                  // handle to source DC
  int nXOriginSrc,             // x-coord of upper-left corner
  int nYOriginSrc,             // y-coord of upper-left corner
  int nWidthSrc,               // source width
  int nHeightSrc,              // source height
  BLENDFUNCTION blendFunction  // alpha-blending function
);
BOOL TransparentBlt(
  HDC hdcDest,        // handle to destination DC
  int nXOriginDest,   // x-coord of destination upper-left corner
  int nYOriginDest,   // y-coord of destination upper-left corner
  int nWidthDest,     // width of destination rectangle
  int hHeightDest,    // height of destination rectangle
  HDC hdcSrc,         // handle to source DC
  int nXOriginSrc,    // x-coord of source upper-left corner
  int nYOriginSrc,    // y-coord of source upper-left corner
  int nWidthSrc,      // width of source rectangle
  int nHeightSrc,     // height of source rectangle
  UINT crTransparent  // color to make transparent
);
int IIDFromString (wchar* lpsz, byte* lpiid);
HRESULT ScriptJustify(
  SCRIPT_VISATTR* psva,
  int* piAdvance,
  int cGlyphs,
  int iDx,
  int iMinKashida,
  int* piJustify
);

HRESULT ScriptRecordDigitSubstitution(
  LCID Locale,
  SCRIPT_DIGITSUBSTITUTE* psds
);
HRESULT ScriptApplyDigitSubstitution(
  SCRIPT_DIGITSUBSTITUTE* psds,
  SCRIPT_CONTROL* psc,
  SCRIPT_STATE* pss
);

// UxTheme.dll
BOOL IsAppThemed();

HRESULT DrawThemeBackground(
    HTHEME hTheme,
    HDC hdc,
    int iPartId,
    int iStateId,
    RECT *pRect,
    RECT *pClipRect
);
HRESULT DrawThemeEdge(
    HTHEME hTheme,
    HDC hdc,
    int iPartId,
    int iStateId,
    LPCRECT pDestRect,
    UINT uEdge,
    UINT uFlags,
    LPRECT pContentRect
);
HRESULT DrawThemeIcon(
    HTHEME hTheme,
    HDC hdc,
    int iPartId,
    int iStateId,
    LPCRECT pRect,
    HIMAGELIST himl,
    int iImageIndex
);
HRESULT DrawThemeParentBackground(
    HWND hwnd,
    HDC hdc,
    RECT *prc
);
HRESULT DrawThemeText(
    HTHEME hTheme,
    HDC hdc,
    int iPartId,
    int iStateId,
    LPCWSTR pszText,
    int iCharCount,
    DWORD dwTextFlags,
    DWORD dwTextFlags2,
    LPCRECT pRect
);

HTHEME OpenThemeData(
    HWND hwnd,
    LPCWSTR pszClassList
);
HRESULT BufferedPaintInit();
HRESULT CloseThemeData(
    HTHEME hTheme
);
HRESULT BufferedPaintUnInit();
//BOOL IsHungAppWindow(
//    HWND hWnd
//);
HPAINTBUFFER BeginBufferedPaint(
    HDC hdcTarget,
    RECT *prcTarget,
    uint/+BP_BUFFERFORMAT+/ dwFormat,
    void*/+BP_PAINTPARAMS+/ pPaintParams,
    HDC *phdc
);
HRESULT EndBufferedPaint(
    HPAINTBUFFER hBufferedPaint,
    BOOL fUpdateTarget
);


HRESULT GetThemeTextExtent(
    HTHEME hTheme,
    HDC hdc,
    int iPartId,
    int iStateId,
    LPCWSTR pszText,
    int iCharCount,
    DWORD dwTextFlags,
    LPCRECT pBoundingRect,
    LPRECT pExtentRect
);
HRESULT SetWindowTheme(
    HWND hwnd,
    LPCWSTR pszSubAppName,
    LPCWSTR pszSubIdList
);

//Kernel32.lib
//LANGID GetSystemDefaultUILanguage();

// Macro from winnt.h/windows.h
WORD PRIMARYLANGID(
  WORD lgid
);

//Gdi32.lib
int IntersectClipRect(
  HDC hdc,         // handle to DC
  int nLeftRect,   // x-coord of upper-left corner
  int nTopRect,    // y-coord of upper-left corner
  int nRightRect,  // x-coord of lower-right corner
  int nBottomRect  // y-coord of lower-right corner
);

LRESULT CoCreateInstance(
    byte* rclsid, void* pUnkOuter, int dwClsContext, byte* riid, void* ppv
);
/+
// kernel32 winxp/vista
version(ANSI){
HANDLE CreateActCtxA(
  ACTCTXA* pActCtx
);
}
else{
HANDLE CreateActCtxW(
  ACTCTXW* pActCtx
);
}
BOOL ActivateActCtx(
  HACTCTX hActCtx,
  uint* lpCookie
);
+/
}
//--------------------------------------------------------------------------------------

// Windows API
extern (Windows){
int AbortDoc(HDC hdc);
HKL ActivateKeyboardLayout(
    HKL hkl,     // handle to keyboard layout
    UINT Flags   // keyboard layout flags
);
BOOL AdjustWindowRectEx(
    LPRECT lpRect,    // pointer to client-rectangle structure
    DWORD dwStyle,    // window styles
    BOOL bMenu,       // menu-present flag
    DWORD dwExStyle   // extended style
);
BOOL Arc(
    HDC hdc,         // handle to device context
    int nLeftRect,   // x-coord of bounding rectangle's upper-left corner
    int nTopRect,    // y-coord of bounding rectangle's upper-left corner
    int nRightRect,  // x-coord of bounding rectangle's lower-right corner
    int nBottomRect, // y-coord of bounding rectangle's lower-right corner
    int nXStartArc,  // first radial ending point
    int nYStartArc,  // first radial ending point
    int nXEndArc,    // second radial ending point
    int nYEndArc     // second radial ending point
);
HDWP BeginDeferWindowPos(
    int nNumWindows
);
//alias STDWIN.BeginPaint BeginPaint;
BOOL BitBlt(
    HDC hdcDest, // handle to destination device context
    int nXDest,  // x-coordinate of destination rectangle's upper-left corner
    int nYDest,  // y-coordinate of destination rectangle's upper-left corner
    int nWidth,  // width of destination rectangle
    int nHeight, // height of destination rectangle
    HDC hdcSrc,  // handle to source device context
    int nXSrc,   // x-coordinate of source rectangle's upper-left corner
    int nYSrc,   // y-coordinate of source rectangle's upper-left corner
    DWORD dwRop  // raster operation code
);
    BOOL BringWindowToTop(
    HWND hWnd   // handle to window
);
LRESULT CallNextHookEx(
    HHOOK hhk,      // handle to current hook
    int nCode,      // hook code passed to hook procedure
    WPARAM wParam,  // value passed to hook procedure
    LPARAM lParam   // value passed to hook procedure
);
LRESULT CallWindowProcA(
    WNDPROC lpPrevWndFunc,  // pointer to previous procedure
    HWND hWnd,              // handle to window
    UINT Msg,               // message
    WPARAM wParam,          // first message parameter
    LPARAM lParam           // second message parameter
);
LRESULT CallWindowProcW(
    WNDPROC lpPrevWndFunc,  // pointer to previous procedure
    HWND hWnd,              // handle to window
    UINT Msg,               // message
    WPARAM wParam,          // first message parameter
    LPARAM lParam           // second message parameter
);
LPSTR CharLowerA(
    LPSTR lpsz   // single character or pointer to string
);
LPWSTR CharLowerW(
    LPWSTR lpsz   // single character or pointer to string
);
LPSTR CharUpperA(
    LPSTR lpsz   // single character or pointer to string
);
LPWSTR CharUpperW(
    LPWSTR lpsz   // single character or pointer to string
);
DWORD CheckMenuItem(
    HMENU hmenu,        // handle to menu
    UINT uIDCheckItem,  // menu item to check or uncheck
    UINT uCheck         // menu item flags
);
BOOL ChooseColorA(
    LPCHOOSECOLORA lpcc   // pointer to structure with initialization data
);
BOOL ChooseColorW(
    LPCHOOSECOLORW lpcc   // pointer to structure with initialization data
);
BOOL ChooseFontA(
    LPCHOOSEFONTA lpcf   // pointer to structure with initialization data
);
BOOL ChooseFontW(
    LPCHOOSEFONTW lpcf   // pointer to structure with initialization data
);
//alias STDWIN.ClientToScreen ClientToScreen;
BOOL CloseClipboard();
int CombineRgn(
    HRGN hrgnDest,      // handle to destination region
    HRGN hrgnSrc1,      // handle to source region
    HRGN hrgnSrc2,      // handle to source region
    int fnCombineMode   // region combining mode
);
//alias STDWIN.CloseHandle CloseHandle;
DWORD CommDlgExtendedError();

version(WinCE){
BOOL CommandBar_AddAdornments(HWND hwndCB, DWORD dwFlags, DWORD dwReserved);
HWND CommandBar_Create(HINSTANCE hInst, HWND hwndParent, int idCmdBar);
void CommandBar_Destroy(HWND hwndCB);
BOOL CommandBar_DrawMenuBar(HWND hwndCB, int iButton);
int CommandBar_Height(HWND hwndCB);
int CommandBar_InsertMenubarEx(HWND hwndCB, HINSTANCE hInst, int pszMenu, int iButton);
int CommandBar_Show(HWND hwndCB, int fShow);
}

HANDLE CopyImage(
    HANDLE hImage,  // handle to the image to copy
    UINT uType,     // type of image to copy
    int cxDesired,  // desired width of new image
    int cyDesired,  // desired height of new image
    UINT fuFlags    // copy flags
);
HACCEL CreateAcceleratorTableA(
    LPACCEL lpaccl,  // pointer to structure array with accelerator data
    int cEntries     // number of structures in the array
);
HACCEL CreateAcceleratorTableW(
    LPACCEL lpaccl,  // pointer to structure array with accelerator data
    int cEntries     // number of structures in the array
);
HBITMAP CreateBitmap(
    int nWidth,         // bitmap width, in pixels
    int nHeight,        // bitmap height, in pixels
    UINT cPlanes,       // number of color planes used by device
    UINT cBitsPerPel,   // number of bits required to identify a color
    VOID *lpvBits // pointer to array containing color data
);
//alias STDWIN.CreateCaret CreateCaret;
HBITMAP CreateCompatibleBitmap(
    HDC hdc,        // handle to device context
    int nWidth,     // width of bitmap, in pixels
    int nHeight     // height of bitmap, in pixels
);
//alias STDWIN.CreateCompatibleDC CreateCompatibleDC;
HCURSOR CreateCursor(
    HINSTANCE hInst,         // handle to application instance
    int xHotSpot,            // horizontal position of hot spot
    int yHotSpot,            // vertical position of hot spot
    int nWidth,              // cursor width
    int nHeight,             // cursor height
    VOID *pvANDPlane,  // pointer to AND bitmask array
    VOID *pvXORPlane   // pointer to XOR bitmask array
);
HDC CreateDCA(
    LPCSTR lpszDriver,  // pointer to string specifying driver name
    LPCSTR lpszDevice,  // pointer to string specifying device name
    LPCSTR lpszOutput,  // do not use; set to NULL
    DEVMODE *lpInitData
                   // pointer to optional printer data
);
HDC CreateDCW(
    LPCWSTR lpszDriver,  // pointer to string specifying driver name
    LPCWSTR lpszDevice,  // pointer to string specifying device name
    LPCWSTR lpszOutput,  // do not use; set to NULL
    DEVMODE *lpInitData
                   // pointer to optional printer data
);
HBITMAP CreateDIBSection(
    HDC hdc,           // handle to device context
    BITMAPINFO *pbmi,  // pointer to structure containing bitmap size,
                       // format, and color data
    UINT iUsage,       // color data type indicator: RGB values or
                       // palette indexes
    VOID **ppvBits,    // pointer to variable to receive a pointer to
                       // the bitmap's bit values
    HANDLE hSection,   // optional handle to a file mapping object
    DWORD dwOffset     // offset to the bitmap bit values within the
                       // file mapping object
);
HANDLE CreateEventA(
  LPSECURITY_ATTRIBUTES lpEventAttributes,
                      // pointer to security attributes
  BOOL bManualReset,  // flag for manual-reset event
  BOOL bInitialState, // flag for initial state
  LPCSTR lpName      // pointer to event-object name
);
HANDLE CreateEventW(
  LPSECURITY_ATTRIBUTES lpEventAttributes,
                      // pointer to security attributes
  BOOL bManualReset,  // flag for manual-reset event
  BOOL bInitialState, // flag for initial state
  LPCWSTR lpName      // pointer to event-object name
);

//alias STDWIN.CreateFileA CreateFileA;
//alias STDWIN.CreateFileW CreateFileW;
HFONT CreateFontIndirectA(LOGFONTA* lplf );
HFONT CreateFontIndirectW(LOGFONTW* lplf );
HICON CreateIconIndirect(
    PICONINFO piconinfo   // pointer to icon information structure
);
HMENU CreateMenu();
HPALETTE CreatePalette(
    LOGPALETTE *lplgpl   // pointer to logical color palette
);
HBRUSH CreatePatternBrush(
    HBITMAP hbmp   // handle to bitmap
);
//alias STDWIN.CreatePen CreatePen;
HRGN CreatePolygonRgn(
    POINT *lppt,  // pointer to array of points
    int cPoints,        // number of points in array
    int fnPolyFillMode  // polygon-filling mode
);
HMENU CreatePopupMenu();
//alias STDWIN.CreateRectRgn CreateRectRgn;
HBRUSH CreateSolidBrush(
    COLORREF crColor   // brush color value
);

//alias STDWIN.CreateWindowExA CreateWindowExA;
HWND CreateWindowExW(
    DWORD dwExStyle,      // extended window style
    LPCWSTR lpClassName,  // pointer to registered class name
    LPCWSTR lpWindowName, // pointer to window name
    DWORD dwStyle,        // window style
    int x,                // horizontal position of window
    int y,                // vertical position of window
    int nWidth,           // window width
    int nHeight,          // window height
    HWND hWndParent,      // handle to parent or owner window
    HMENU hMenu,          // handle to menu, or child-window identifier
    HINSTANCE hInstance,  // handle to application instance
    LPVOID lpParam        // pointer to window-creation data
);

LRESULT DefFrameProcA(
    HWND hWnd,           // handle to MDI frame window
    HWND hWndMDIClient,  // handle to MDI client window
    UINT uMsg,           // message
    WPARAM wParam,       // first message parameter
    LPARAM lParam        // second message parameter
);
LRESULT DefFrameProcW(
    HWND hWnd,           // handle to MDI frame window
    HWND hWndMDIClient,  // handle to MDI client window
    UINT uMsg,           // message
    WPARAM wParam,       // first message parameter
    LPARAM lParam        // second message parameter
);
LRESULT DefMDIChildProcA(
    HWND hWnd,      // handle to MDI child window
    UINT uMsg,      // message
    WPARAM wParam,  // first message parameter
    LPARAM lParam   // second message parameter
);
LRESULT DefMDIChildProcW(
    HWND hWnd,      // handle to MDI child window
    UINT uMsg,      // message
    WPARAM wParam,  // first message parameter
    LPARAM lParam   // second message parameter
);
//alias STDWIN.DefWindowProcA DefWindowProcA;
LRESULT DefWindowProcW(
    HWND hWnd,      // handle to window
    UINT Msg,       // message identifier
    WPARAM wParam,  // first message parameter
    LPARAM lParam   // second message parameter
);

HDWP DeferWindowPos(
    HDWP hWinPosInfo,      // handle to internal structure
    HWND hWnd,             // handle to window to position
    HWND hWndInsertAfter,  // placement-order handle
    int x,                 // horizontal position
    int y,                 // vertical position
    int cx,                // width
    int cy,                // height
    UINT uFlags            // window-positioning flags
);

//alias STDWIN.DeleteDC DeleteDC;
//alias STDWIN.DeleteFileA DeleteFileA;
BOOL DeleteMenu(
    HMENU hMenu,     // handle to menu
    UINT uPosition,  // menu item identifier or position
    UINT uFlags      // menu item flag
);
//alias STDWIN.DeleteObject DeleteObject;
BOOL DestroyAcceleratorTable(
    HACCEL hAccel   // handle to accelerator table
);
int DestroyCaret();
BOOL DestroyCursor(
    HCURSOR hCursor   // handle to cursor to destroy
);
BOOL DestroyIcon(
    HICON hIcon   // handle to icon to destroy
);
BOOL DestroyMenu(
    HMENU hMenu  // handle to menu to destroy
);
BOOL DestroyWindow(
    HWND hWnd   // handle to window to destroy
);
LONG DispatchMessageA(
    MSG *lpmsg   // pointer to structure with message
);
LONG DispatchMessageW(
    MSG *lpmsg   // pointer to structure with message
);
BOOL DragDetect(
    HWND hwnd,
    POINT pt
);
void DragFinish(
    HDROP hDrop
);
UINT DragQueryFileA(
    HDROP hDrop,
    UINT iFile,
    LPSTR lpszFile,
    UINT cch
);
UINT DragQueryFileW(
    HDROP hDrop,
    UINT iFile,
    LPWSTR lpszFile,
    UINT cch
);
BOOL DrawEdge(
    HDC hdc,       // handle to device context
    LPRECT qrc,    // pointer to rectangle coordinates
    UINT edge,     // type of inner and outer edge to draw
    UINT grfFlags  // type of border
);
BOOL DrawFocusRect(
    HDC hDC,          // handle to device context
    RECT *lprc  // pointer to structure for rectangle
);
BOOL DrawFrameControl(
    HDC hdc,     // handle to device context
    LPRECT lprc, // pointer to bounding rectangle
    UINT uType,  // frame-control type
    UINT uState  // frame-control state
);
BOOL DrawIconEx(
    HDC hdc,                    // handle to device context
    int xLeft,                  // x-coordinate of upper left corner
    int yTop,                   // y-coordinate of upper left corner
    HICON hIcon,                // handle to icon to draw
    int cxWidth,                // width of the icon
    int cyWidth,                // height of the icon
    UINT istepIfAniCur,         // index of frame in animated cursor
    HBRUSH hbrFlickerFreeDraw,  // handle to background brush
    UINT diFlags                // icon-drawing flags
);
BOOL DrawMenuBar(
    HWND hWnd  // handle to window with menu bar to redraw
);
BOOL DrawStateA(
    HDC hdc,                     // handle to device context
    HBRUSH hbr,                  // handle to brush
    DRAWSTATEPROC lpOutputFunc,  // pointer to callback function
    LPARAM lData,                // image information
    WPARAM wData,                // more image information
    int x,                       // horizontal location of image
    int y,                       // vertical location of image
    int cx,                      // width of image
    int cy,                      // height of image
    UINT fuFlags                 // image type and state
);
BOOL DrawStateW(
    HDC hdc,                     // handle to device context
    HBRUSH hbr,                  // handle to brush
    DRAWSTATEPROC lpOutputFunc,  // pointer to callback function
    LPARAM lData,                // image information
    WPARAM wData,                // more image information
    int x,                       // horizontal location of image
    int y,                       // vertical location of image
    int cx,                      // width of image
    int cy,                      // height of image
    UINT fuFlags                 // image type and state
);
int DrawTextA(
    HDC hDC,          // handle to device context
    LPCSTR lpString, // pointer to string to draw
    int nCount,       // string length, in characters
    LPRECT lpRect,    // pointer to struct with formatting dimensions
    UINT uFormat      // text-drawing flags
);
int DrawTextW(
    HDC hDC,          // handle to device context
    LPCWSTR lpString, // pointer to string to draw
    int nCount,       // string length, in characters
    LPRECT lpRect,    // pointer to struct with formatting dimensions
    UINT uFormat      // text-drawing flags
);

BOOL Ellipse(
    HDC hdc,        // handle to device context
    int nLeftRect,  // x-coord of bounding rectangle's upper-left corner
    int nTopRect,   // y-coord of bounding rectangle's upper-left corner
    int nRightRect, // x-coord of bounding rectangle's lower-right corner
    int nBottomRect // y-coord of bounding rectangle's lower-right corner
);
BOOL EnableMenuItem(
    HMENU hMenu,         // handle to menu
    UINT uIDEnableItem,  // menu item to enable, disable, or gray
    UINT uEnable         // menu item flags
);
BOOL EnableWindow(
    HWND hWnd,
    BOOL bEnable
);
BOOL EndDeferWindowPos(
    HDWP hWinPosInfo   // handle to internal structure
);
int EndDoc(HDC hDC);
int EndPage(HDC hDC);
BOOL EnumDisplayMonitors(
    HDC hdc,                   // handle to display DC
    LPCRECT lprcClip,          // clipping rectangle
    MONITORENUMPROC lpfnEnum,  // callback function
    LPARAM dwData              // data for callback function
);
int EnumFontFamiliesExA(
    HDC hdc,              // handle to device context
    LPLOGFONTA lpLogfont,  // pointer to logical font information
    FONTENUMEXPROC lpEnumFontFamExProc,
                    // pointer to callback function
    LPARAM lParam,        // application-supplied data
    DWORD dwFlags         // reserved; must be zero
);
int EnumFontFamiliesExW(
    HDC hdc,              // handle to device context
    LPLOGFONTW lpLogfont,  // pointer to logical font information
    FONTENUMEXPROC lpEnumFontFamExProc,
                    // pointer to callback function
    LPARAM lParam,        // application-supplied data
    DWORD dwFlags         // reserved; must be zero
);

int EnumFontFamiliesA(
    HDC hdc,             // handle to device control
    LPCSTR lpszFamily,  // pointer to family-name string
    FONTENUMPROC lpEnumFontFamProc,
                   // pointer to callback function
    LPARAM lParam        // pointer to application-supplied data
);
int EnumFontFamiliesW(
    HDC hdc,             // handle to device control
    LPCWSTR lpszFamily,  // pointer to family-name string
    FONTENUMPROC lpEnumFontFamProc,
                   // pointer to callback function
    LPARAM lParam        // pointer to application-supplied data
);
BOOL EqualRect(
    RECT *lprc1,  // pointer to structure with first rectangle
    RECT *lprc2   // pointer to structure with second rectangle
);
BOOL EqualRgn(
    HRGN hSrcRgn1,  // handle to first region
    HRGN hSrcRgn2   // handle to second region
);
DWORD ExpandEnvironmentStringsA(
    LPCSTR lpSrc, // pointer to string with environment variables
    LPSTR lpDst,  // pointer to string with expanded environment
             // variables
    DWORD nSize    // maximum characters in expanded string
);
DWORD ExpandEnvironmentStringsW(
    LPCWSTR lpSrc, // pointer to string with environment variables
    LPWSTR lpDst,  // pointer to string with expanded environment
             // variables
    DWORD nSize    // maximum characters in expanded string
);
BOOL ExtTextOutA(
    HDC hdc,          // handle to device context
    int X,            // x-coordinate of reference point
    int Y,            // y-coordinate of reference point
    UINT fuOptions,   // text-output options
    RECT *lprc, // optional clipping and/or opaquing rectangle
    LPCSTR lpString, // points to string
    UINT cbCount,     // number of characters in string
    INT *lpDx   // pointer to array of intercharacter spacing
                // values
);
BOOL ExtTextOutW(
    HDC hdc,          // handle to device context
    int X,            // x-coordinate of reference point
    int Y,            // y-coordinate of reference point
    UINT fuOptions,   // text-output options
    RECT *lprc, // optional clipping and/or opaquing rectangle
    LPCWSTR lpString, // points to string
    UINT cbCount,     // number of characters in string
    INT *lpDx   // pointer to array of intercharacter spacing
                // values
);
UINT ExtractIconExA(
    LPCSTR lpszFile,
    int nIconIndex,
    HICON *phiconLarge,
    HICON *phiconSmall,
    UINT nIcons
);
UINT ExtractIconExW(
    LPCWSTR lpszFile,
    int nIconIndex,
    HICON *phiconLarge,
    HICON *phiconSmall,
    UINT nIcons
);
HRSRC FindResourceA(
    HMODULE hModule, // module handle
    LPCSTR lpName,  // pointer to resource name
    LPCSTR lpType   // pointer to resource type
);
HRSRC FindResourceW(
    HMODULE hModule, // module handle
    LPCWSTR lpName,  // pointer to resource name
    LPCWSTR lpType   // pointer to resource type
);
HWND FindWindowA(
    LPCSTR lpClassName,  // pointer to class name
    LPCSTR lpWindowName  // pointer to window name
);
HWND FindWindowW(
    LPCWSTR lpClassName,  // pointer to class name
    LPCWSTR lpWindowName  // pointer to window name
);
DWORD FormatMessageA(
    DWORD dwFlags,      // source and processing options
    LPCVOID lpSource,   // pointer to  message source
    DWORD dwMessageId,  // requested message identifier
    DWORD dwLanguageId, // language identifier for requested message
    LPSTR lpBuffer,    // pointer to message buffer
    DWORD nSize,        // maximum size of message buffer
    //  va_list *Arguments  // pointer to array of message inserts
    void* Arguments
);
DWORD FormatMessageW(
    DWORD dwFlags,      // source and processing options
    LPCVOID lpSource,   // pointer to  message source
    DWORD dwMessageId,  // requested message identifier
    DWORD dwLanguageId, // language identifier for requested message
    LPWSTR lpBuffer,    // pointer to message buffer
    DWORD nSize,        // maximum size of message buffer
    //  va_list *Arguments  // pointer to array of message inserts
    void* Arguments
);
DWORD GdiSetBatchLimit(
    DWORD dwLimit   // batch limit
);
UINT GetACP();
HWND GetActiveWindow();
COLORREF GetBkColor(
    HDC hdc   // handle of device context
);
HWND GetCapture();
BOOL GetCaretPos(
    LPPOINT lpPoint   // address of structure to receive coordinates
);
BOOL GetCharABCWidthsA(
    HDC hdc,         // handle to device context
    UINT uFirstChar, // first character in range to query
    UINT uLastChar,  // last character in range to query
    LPABC lpabc      // pointer to character-width structure
);
BOOL GetCharABCWidthsW(
    HDC hdc,         // handle to device context
    UINT uFirstChar, // first character in range to query
    UINT uLastChar,  // last character in range to query
    LPABC lpabc      // pointer to character-width structure
);

BOOL GetCharWidthA(
    HDC hdc,         // handle to device context
    UINT iFirstChar, // first character in range to query
    UINT iLastChar,  // last character in range to query
    LPINT lpBuffer   // pointer to buffer for widths
);
BOOL GetCharWidthW(
    HDC hdc,         // handle to device context
    UINT iFirstChar, // first character in range to query
    UINT iLastChar,  // last character in range to query
    LPINT lpBuffer   // pointer to buffer for widths
);
DWORD GetCharacterPlacementA(
    HDC hdc,           // handle to device context
    LPCSTR lpString,  // pointer to string
    int nCount,        // number of characters in string
    int nMaxExtent,    // maximum extent for displayed string
    LPGCP_RESULTS lpResults,
                     // pointer to buffer for placement result
    DWORD dwFlags      // placement flags
);
DWORD GetCharacterPlacementW(
    HDC hdc,           // handle to device context
    LPCWSTR lpString,  // pointer to string
    int nCount,        // number of characters in string
    int nMaxExtent,    // maximum extent for displayed string
    LPGCP_RESULTS lpResults,
                     // pointer to buffer for placement result
    DWORD dwFlags      // placement flags
);
BOOL GetClassInfoA(
    HINSTANCE hInstance,    // handle of application instance
    LPCSTR lpClassName,    // address of class name string
    LPWNDCLASSA lpWndClass   // address of structure for class data
);
BOOL GetClassInfoW(
    HINSTANCE hInstance,    // handle of application instance
    LPCWSTR lpClassName,    // address of class name string
    LPWNDCLASSW lpWndClass   // address of structure for class data
);
//alias STDWIN.GetClientRect GetClientRect;
//alias STDWIN.GetClipBox GetClipBox;
//alias STDWIN.GetClipRgn GetClipRgn;
HANDLE GetClipboardData(
    UINT uFormat   // clipboard format
);
int GetClipboardFormatNameA(
    UINT format,            // clipboard format to retrieve
    LPSTR lpszFormatName,  // address of buffer for name
    int cchMaxCount         // length of name string in characters
);
int GetClipboardFormatNameW(
    UINT format,            // clipboard format to retrieve
    LPWSTR lpszFormatName,  // address of buffer for name
    int cchMaxCount         // length of name string in characters
);
BOOL GetComboBoxInfo(
    HWND hwndCombo,
    PCOMBOBOXINFO pcbi
);
//alias STDWIN.GetCurrentObject GetCurrentObject;
DWORD GetCurrentProcessId();
DWORD GetCurrentThreadId();
HCURSOR GetCursor();
BOOL GetCursorPos(
    LPPOINT lpPoint   // address of structure for cursor position
);
//alias STDWIN.GetDC GetDC;
UINT GetDIBColorTable(
    HDC hdc,          // handle to device context whose DIB is of
                // interest
    UINT uStartIndex, // color table index of first entry to retrieve
    UINT cEntries,    // number of color table entries to retrieve
    RGBQUAD *pColors  // pointer to buffer that receives color table
                // entries
);
int GetDIBits(
    HDC hdc,           // handle to device context
    HBITMAP hbmp,      // handle to bitmap
    UINT uStartScan,   // first scan line to set in destination bitmap
    UINT cScanLines,   // number of scan lines to copy
    LPVOID lpvBits,    // address of array for bitmap bits
    LPBITMAPINFO lpbi, // address of structure with bitmap data
    UINT uUsage        // RGB or palette index
);
HWND GetDesktopWindow();
int GetDialogBaseUnits();
int GetDoubleClickTime();
DWORD GetFontLanguageInfo(
    HDC hdc  // handle to a device context
);
BOOL GetGUIThreadInfo(
    DWORD idThread,
    LPGUITHREADINFO lpgui
);
BOOL GetIconInfo(
    HICON hIcon,          // icon handle
    PICONINFO piconinfo   // address of icon structure
);
int GetKeyNameTextA(
    LONG lParam,      // second parameter of keyboard message
    LPSTR lpString,  // pointer to buffer for key name
    int nSize         // maximum length of key-name string length
);
int GetKeyNameTextW(
    LONG lParam,      // second parameter of keyboard message
    LPWSTR lpString,  // pointer to buffer for key name
    int nSize         // maximum length of key-name string length
);
HKL GetKeyboardLayout(
    DWORD dwLayout  // thread identifier
);
SHORT GetKeyState(
    int nVirtKey   // virtual-key code
);
UINT GetKeyboardLayoutList(
    int nBuff,       // size of buffer in array element
    HKL *lpList  // buffer for keyboard layout handles
);
BOOL GetKeyboardState(
    PBYTE lpKeyState   // pointer to array to receive status data
);
HWND GetLastActivePopup(HWND hWnd);
DWORD GetLastError();
DWORD GetLayout(
    HDC hdc      // handle to DC
);
int GetLocaleInfoA(
    LCID Locale,      // locale identifier
    LCTYPE LCType,    // type of information
    LPSTR lpLCData,  // address of buffer for information
    int cchData       // size of buffer
);
int GetLocaleInfoW(
    LCID Locale,      // locale identifier
    LCTYPE LCType,    // type of information
    LPWSTR lpLCData,  // address of buffer for information
    int cchData       // size of buffer
);
HMENU GetMenu(
    HWND hWnd  // handle to window
);
BOOL GetMenuBarInfo(
    HWND hwnd,
    LONG idObject,
    LONG idItem,
    PMENUBARINFO pmbi
);
UINT GetMenuDefaultItem(
    HMENU hMenu,
    UINT fByPos,
    UINT gmdiFlags
);
BOOL GetMenuInfo(
    HMENU hmenu,
    LPCMENUINFO lpcmi
);
int GetMenuItemCount(HMENU hMenu);
BOOL GetMenuItemInfoA(
    HMENU hMenu,
    UINT uItem,
    BOOL fByPosition,
    LPMENUITEMINFO lpmii
);
BOOL GetMenuItemInfoW(
    HMENU hMenu,
    UINT uItem,
    BOOL fByPosition,
    LPMENUITEMINFO lpmii
);
BOOL GetMenuItemRect(
    HWND hWnd,
    HMENU hMenu,
    UINT uItem,
    LPRECT lprcItem
);
BOOL GetMessageW(
    LPMSG lpMsg,         // address of structure with message
    HWND hWnd,           // handle of window
    UINT wMsgFilterMin,  // first message
    UINT wMsgFilterMax   // last message
);
DWORD GetMessagePos();
LONG GetMessageTime();
DWORD GetModuleFileNameA(
    HMODULE hModule,    // handle to module to find filename for
    LPSTR lpFilename,  // pointer to buffer to receive module path
    DWORD nSize         // size of buffer, in characters
);
DWORD GetModuleFileNameW(
    HMODULE hModule,    // handle to module to find filename for
    LPWSTR lpFilename,  // pointer to buffer to receive module path
    DWORD nSize         // size of buffer, in characters
);
HMODULE GetModuleHandleW(
  LPCWSTR lpModuleName
);
BOOL GetMonitorInfoA(
    HMONITOR hMonitor,  // handle to display monitor
    LPMONITORINFO lpmi  // pointer to display monitor information
);
BOOL GetMonitorInfoW(
    HMONITOR hMonitor,  // handle to display monitor
    LPMONITORINFO lpmi  // pointer to display monitor information
);
UINT GetNearestPaletteIndex(
    HPALETTE hpal,     // handle of logical color palette
    COLORREF crColor   // color to be matched
);
BOOL GetOpenFileNameA(
    OPENFILENAMEA* lpofn   // address of structure with initialization data
);
BOOL GetOpenFileNameW(
    OPENFILENAMEW* lpofn   // address of structure with initialization data
);
UINT GetPaletteEntries(
  HPALETTE hpal,        // handle to logical palette
  UINT iStartIndex,     // first entry to retrieve
  UINT nEntries,        // number of entries to retrieve
  LPPALETTEENTRY lppe   // array that receives entries
);
HWND GetParent(
    HWND hWnd   // handle to child window
);

COLORREF GetPixel(
    HDC hdc,   // handle to device context
    int XPos,  // x-coordinate of pixel
    int nYPos  // y-coordinate of pixel
);
HANDLE GetProcessHeap();
DWORD GetProfileStringA(
    LPCSTR lpAppName,        // address of section name
    LPCSTR lpKeyName,        // address of key name
    LPCSTR lpDefault,        // address of default string
    LPSTR lpReturnedString,  // address of destination buffer
    DWORD nSize               // size of destination buffer
);
DWORD GetProfileStringW(
    LPCWSTR lpAppName,        // address of section name
    LPCWSTR lpKeyName,        // address of key name
    LPCWSTR lpDefault,        // address of default string
    LPWSTR lpReturnedString,  // address of destination buffer
    DWORD nSize               // size of destination buffer
);
int GetROP2(
    HDC hdc   // handle of device context
);
int GetRandomRgn(
    HDC  hdc,    // handle to DC
    HRGN hrgn,   // handle to region
    INT  iNum    // must be SYSRGN
);
DWORD GetRegionData(
    HRGN hRgn,            // handle to region
    DWORD dwCount,        // size of buffer containing region data
    LPRGNDATA lpRgnData   // pointer to region data
);
int GetRgnBox(
    HRGN hrgn,   // handle to a region
    LPRECT lprc  // pointer that receives bounding rectangle
);
BOOL GetSaveFileNameA(
    OPENFILENAMEA* lpofn   // address of structure with initialization data
);
BOOL GetSaveFileNameW(
    OPENFILENAME* lpofn   // address of structure with initialization data
);
BOOL GetScrollInfo(
    HWND hwnd,         // handle to window with scroll bar
    int fnBar,         // scroll bar flag
    LPSCROLLINFO lpsi  // pointer to structure for scroll parameters
);
//alias STDWIN.GetStockObject GetStockObject;
DWORD GetSysColor(
    int nIndex   // display element
);
HBRUSH GetSysColorBrush(
    int nIndex  // system color index
);
HMENU GetSystemMenu(
    HWND hWnd,    // handle to window to own window menu
    BOOL bRevert  // reset flag
);
int GetSystemMetrics(
    int nIndex   // system metric or configuration setting to retrieve
);
UINT GetSystemPaletteEntries(
    HDC hdc,              // handle of device context
    UINT iStartIndex,     // index of first entry to be retrieved
    UINT nEntries,        // number of entries to be retrieved
    LPPALETTEENTRY lppe   // array receiving system-palette entries
);
int GetTextCharset(
    HDC hdc  // handle to DC
);
COLORREF GetTextColor(
    HDC hdc   // handle to device context
);
BOOL GetTextExtentPoint32A(
    HDC hdc,           // handle to device context
    LPCSTR lpString,  // pointer to text string
    int cbString,      // number of characters in string
    LPSIZE lpSize      // pointer to structure for string size
);
BOOL GetTextExtentPoint32W(
    HDC hdc,           // handle to device context
    LPCWSTR lpString,  // pointer to text string
    int cbString,      // number of characters in string
    LPSIZE lpSize      // pointer to structure for string size
);
BOOL GetTextMetricsW(
    HDC hdc,            // handle to device context
    TEXTMETRICW* lptm   // pointer to text metrics structure
);
DWORD GetTickCount();
//alias STDWIN.GetUpdateRect GetUpdateRect;
//alias STDWIN.GetUpdateRgn GetUpdateRgn;
DWORD GetVersion();
BOOL GetVersionExA(
    LPOSVERSIONINFOA lpVersionInformation   // pointer to version information structure
);
BOOL GetVersionExW(
    LPOSVERSIONINFOW lpVersionInformation   // pointer to version information structure
);
HWND GetWindow(
    HWND hWnd,  // handle to original window
    UINT uCmd   // relationship flag
);
LONG GetWindowLongA(HWND hWnd, int nIndex);
LONG GetWindowLongW(HWND hWnd, int nIndex);

BOOL GetWindowPlacement(
    HWND hWnd,
    WINDOWPLACEMENT *lpwndpl
);
int GetWindowTextA(
  HWND hWnd,        // handle to window or control with text
  LPSTR lpString,  // address of buffer for text
  int nMaxCount     // maximum number of characters to copy
);
int GetWindowTextW(
  HWND hWnd,        // handle to window or control with text
  LPWSTR lpString,  // address of buffer for text
  int nMaxCount     // maximum number of characters to copy
);
int GetWindowTextLengthA(HWND hWnd);
int GetWindowTextLengthW(HWND hWnd);
DWORD GetWindowThreadProcessId(
  HWND hWnd,             // handle to window
  LPDWORD lpdwProcessId  // address of variable for process identifier
);
HGLOBAL GlobalAlloc(UINT uFlags, SIZE_T dwBytes);
HGLOBAL GlobalFree(HGLOBAL hMem);
LPVOID GlobalLock(HGLOBAL hMem);
SIZE_T GlobalSize(HGLOBAL hMem);
BOOL GlobalUnlock(HGLOBAL hMem);
BOOL GradientFill(
    HDC hdc,
    PTRIVERTEX pVertex,
    DWORD dwNumVertex,
    PVOID pMesh,
    DWORD dwNumMesh,
    DWORD dwMode
);
LPVOID HeapAlloc(
    HANDLE hHeap,  // handle to the private heap block
    DWORD dwFlags, // heap allocation control flags
    DWORD dwBytes  // number of bytes to allocate
);
BOOL HeapFree(
    HANDLE hHeap,  // handle to the heap
    DWORD dwFlags, // heap freeing flags
    LPVOID lpMem   // pointer to the memory to free
);
//alias STDWIN.HideCaret HideCaret;
int ImageList_Add(
    HIMAGELIST himl,
    HBITMAP hbmImage,
    HBITMAP hbmMask
);
int ImageList_AddMasked(
    HIMAGELIST himl,
    HBITMAP hbmImage,
    COLORREF crMask
     );
HIMAGELIST ImageList_Create(
    int cx,
    int cy,
    UINT flags,
    int cInitial,
    int cGrow
);
BOOL ImageList_Destroy(
    HIMAGELIST himl
);
HICON ImageList_GetIcon(
    HIMAGELIST himl,
    int i,
    UINT flags
);
BOOL ImageList_GetIconSize(
    HIMAGELIST himl,
    int *cx,
    int *cy
);
int ImageList_GetImageCount(
    HIMAGELIST himl
);
BOOL ImageList_Remove(
    HIMAGELIST himl,
    int i
);
BOOL ImageList_Replace(
    HIMAGELIST himl,
    int i,
    HBITMAP hbmImage,
    HBITMAP hbmMask
);
int ImageList_ReplaceIcon(
    HIMAGELIST himl,
    int i,
    HICON hicon
);
BOOL ImageList_SetIconSize(
    HIMAGELIST himl,
    int cx,
    int cy
);
HIMC ImmAssociateContext(
    HWND hWnd,
    HIMC hIMC
);
HIMC ImmCreateContext();
int ImmDestroyContext(HIMC hIMC );
BOOL ImmGetCompositionFontA(
    HIMC hIMC,
    LPLOGFONTA lplf
);
BOOL ImmGetCompositionFontW(
    HIMC hIMC,
    LOGFONTW* lplf
);
LONG ImmGetCompositionStringA(
    HIMC hIMC,
    DWORD dwIndex,
    LPVOID lpBuf,
    DWORD dwBufLen
);
LONG ImmGetCompositionStringW(
    HIMC hIMC,
    DWORD dwIndex,
    LPVOID lpBuf,
    DWORD dwBufLen
);
HIMC ImmGetContext(
    HWND hWnd
);
BOOL ImmGetConversionStatus(
    HIMC hIMC,
    LPDWORD lpfdwConversion,
    LPDWORD lpfdwSentence
);
HWND ImmGetDefaultIMEWnd(HWND hWnd );
BOOL ImmGetOpenStatus(
    HIMC hIMC
);
BOOL ImmReleaseContext(
    HWND hWnd,
    HIMC hIMC
);
BOOL ImmSetCompositionFontA(
    HIMC hIMC,
    LOGFONTA* lplf
);
BOOL ImmSetCompositionFontW(
    HIMC hIMC,
    LOGFONTW* lplf
);
BOOL ImmSetCompositionWindow(
    HIMC hIMC,
    LPCOMPOSITIONFORM lpCompForm
);
BOOL ImmSetConversionStatus(
    HIMC hIMC,
    DWORD fdwConversion,
    DWORD fdwSentence
);
BOOL ImmSetOpenStatus(
    HIMC hIMC,
    BOOL fOpen
);
void InitCommonControls();
BOOL InitCommonControlsEx(
    LPINITCOMMONCONTROLSEX lpInitCtrls
);
BOOL InsertMenuA(
  HMENU hMenu,      // handle to menu
  UINT uPosition,   // menu item that new menu item precedes
  UINT uFlags,      // menu item flags
  UINT uIDNewItem,  // menu item identifier or handle to drop-down
                    // menu or submenu
  LPCSTR lpNewItem // menu item content
);
BOOL InsertMenuW(
  HMENU hMenu,      // handle to menu
  UINT uPosition,   // menu item that new menu item precedes
  UINT uFlags,      // menu item flags
  UINT uIDNewItem,  // menu item identifier or handle to drop-down
                    // menu or submenu
  LPCWSTR lpNewItem // menu item content
);

BOOL InsertMenuItemA(
  HMENU hMenu,
  UINT uItem,
  BOOL fByPosition,
  MENUITEMINFOA* lpmii
);
BOOL InsertMenuItemW(
  HMENU hMenu,
  UINT uItem,
  BOOL fByPosition,
  MENUITEMINFOW* lpmii
);
BOOL IntersectRect(
    LPRECT lprcDst,        // pointer to structure for intersection
    RECT *lprcSrc1,  // pointer to structure with first rectangle
    RECT *lprcSrc2   // pointer to structure with second rectangle
);
LONG InterlockedIncrement(
    LPLONG lpAddend   // pointer to the variable to increment
);
LONG InterlockedDecrement(
    LPLONG lpAddend   // address of the variable to decrement
);
BOOL IsDBCSLeadByte(
    BYTE TestChar   // character to test
);
BOOL IsIconic(
    HWND hWnd   // handle to window
);
BOOL IsWindow(
    HWND hWnd   // handle to window
);
BOOL IsWindowEnabled(HWND hWnd);
BOOL IsWindowVisible(HWND hWnd);
BOOL IsZoomed(HWND hWnd);
BOOL KillTimer(
    HWND hWnd,      // handle of window that installed timer
    UINT uIDEvent   // timer identifier
);
//alias STDWIN.LineTo LineTo;
HBITMAP LoadBitmapA(
    HINSTANCE hInstance,  // handle to application instance
    LPCSTR lpBitmapName  // name of bitmap resource
);
HBITMAP LoadBitmapW(
    HINSTANCE hInstance,  // handle to application instance
    LPCWSTR lpBitmapName  // name of bitmap resource
);
HANDLE LoadImageA(
    HINSTANCE hinst,   // handle of the instance containing the image
    LPCSTR lpszName,  // name or identifier of image
    UINT uType,        // type of image
    int cxDesired,     // desired width
    int cyDesired,     // desired height
    UINT fuLoad        // load flags
);
HANDLE LoadImageW(
    HINSTANCE hinst,   // handle of the instance containing the image
    LPCWSTR lpszName,  // name or identifier of image
    UINT uType,        // type of image
    int cxDesired,     // desired width
    int cyDesired,     // desired height
    UINT fuLoad        // load flags
);
HINSTANCE LoadLibraryW(wchar* lpLibFileName );
HGLOBAL LoadResource(
    HMODULE hModule, // resource-module handle
    HRSRC hResInfo   // resource handle
);
int LoadStringA(
    HINSTANCE hInstance,
    UINT uID,
    LPSTR lpBuffer,
    int nBufferMax
);
int LoadStringW(
    HINSTANCE hInstance,
    UINT uID,
    LPWSTR lpBuffer,
    int nBufferMax
);
HLOCAL LocalFree(
    HLOCAL hMem   // handle to local memory object
);
LPVOID LockResource(
    HGLOBAL hResData   // handle to resource to lock
);
UINT MapVirtualKeyA(
    UINT uCode,     // virtual-key code or scan code
    UINT uMapType   // translation to perform
);
UINT MapVirtualKeyW(
    UINT uCode,     // virtual-key code or scan code
    UINT uMapType   // translation to perform
);
BOOL MessageBeep(
    UINT uType   // sound type
);
int MessageBoxW(
    HWND hWnd,          // handle of owner window
    LPCWSTR lpText,     // address of text in message box
    LPCWSTR lpCaption,  // address of title of message box
    UINT uType          // style of message box
);
HMONITOR MonitorFromWindow(
    HWND hwnd,       // handle to a window
    DWORD dwFlags    // flags if no monitor intersects the window
);
DWORD MsgWaitForMultipleObjectsEx(
    DWORD nCount,          // number of handles in handle array
    LPHANDLE pHandles,     // pointer to an object-handle array
    DWORD dwMilliseconds,  // time-out interval in milliseconds
    DWORD dwWakeMask,      // type of input events to wait for
    DWORD dwFlags          // wait flags
);
void NotifyWinEvent(
    DWORD event,
    HWND hwnd,
    LONG idObject,
    LONG idChild
);
int OffsetRgn(
    HRGN hrgn,     // handle to region
    int nXOffset,  // offset along x-axis
    int nYOffset   // offset along y-axis
);
WINOLEAPI OleInitialize(
    LPVOID pvReserved  //Reserved; must be NULL.
);
void OleUninitialize();
BOOL OpenClipboard(
    HWND hWndNewOwner
);
void OutputDebugStringA(
    LPCSTR lpOutputString
);
void OutputDebugStringW(
    LPCWSTR lpOutputString
);
BOOL PatBlt(
    HDC hdc,     // handle to device context
    int nXLeft,  // x-coord. of upper-left corner of rect. to be filled
    int nYLeft,  // y-coord. of upper-left corner of rect. to be filled
    int nWidth,  // width of rectangle to be filled
    int nHeight, // height of rectangle to be filled
    DWORD dwRop  // raster operation code
);
BOOL PeekMessageW(
    LPMSG lpMsg,         // pointer to structure for message
    HWND hWnd,           // handle to window
    UINT wMsgFilterMin,  // first message
    UINT wMsgFilterMax,  // last message
    UINT wRemoveMsg      // removal flags
);
BOOL Pie(
    HDC hdc,         // handle to device context
    int nLeftRect,   // x-coord of bounding rectangle's upper-left corner
    int nTopRect,    // y-coord of bounding rectangle's upper-left corner
    int nRightRect,  // x-coord of bounding rectangle's lower-right corner
    int nBottomRect, // y-coord of bounding rectangle's lower-right corner
    int nXRadial1,   // x-coord of first radial's endpoint
    int nYRadial1,   // y-coord of first radial's endpoint
    int nXRadial2,   // x-coord of second radial's endpoint
    int nYRadial2    // y-coord of second radial's endpoint
);
BOOL Polygon(
    HDC hdc,                // handle to device context
    POINT *lpPoints,  // pointer to polygon's vertices
    int nCount              // count of polygon's vertices
);
BOOL Polyline(
    HDC hdc,            // handle to device context
    POINT *lppt,  // pointer to array containing endpoints
    int cPoints         // number of points in the array
);
BOOL PostMessageA(
    HWND hWnd,
    UINT Msg,
    WPARAM wParam,
    LPARAM lParam
);
BOOL PostMessageW(
    HWND hWnd,
    UINT Msg,
    WPARAM wParam,
    LPARAM lParam
);
BOOL PostThreadMessageA(
    DWORD idThread,
    UINT Msg,
    WPARAM wParam,
    LPARAM lParam
);
BOOL PostThreadMessageW(
    DWORD idThread,
    UINT Msg,
    WPARAM wParam,
    LPARAM lParam
);
BOOL PtInRect(
    RECT *lprc,  // rectangle
    POINT pt           // point
);
BOOL PtInRegion(
    HRGN hrgn,  // handle to region
    int X,      // x-coordinate of point
    int Y       // y-coordinate of point
);
UINT RealizePalette(
    HDC hdc   // handle of device context
);
BOOL RectInRegion(
    HRGN hrgn,         // handle to region
    RECT *lprc   // pointer to rectangle
);
BOOL Rectangle(
    HDC hdc,         // handle to device context
    int nLeftRect,   // x-coord of bounding rectangle's upper-left corner
    int nTopRect,    // y-coord of bounding rectangle's upper-left corner
    int nRightRect,  // x-coord of bounding rectangle's lower-right corner
    int nBottomRect  // y-coord of bounding rectangle's lower-right corner
);
//alias STDWIN.RedrawWindow RedrawWindow;
LONG RegCloseKey(
  HKEY hKey
);
LONG RegEnumKeyExA(
  HKEY hKey,
  DWORD dwIndex,
  LPSTR lpName,
  LPDWORD lpcName,
  LPDWORD lpReserved,
  LPSTR lpClass,
  LPDWORD lpcClass,
  PFILETIME lpftLastWriteTime
);
LONG RegEnumKeyExW(
  HKEY hKey,
  DWORD dwIndex,
  LPWSTR lpName,
  LPDWORD lpcName,
  LPDWORD lpReserved,
  LPWSTR lpClass,
  LPDWORD lpcClass,
  PFILETIME lpftLastWriteTime
);
LONG RegOpenKeyExA(
  HKEY hKey,
  LPSTR lpSubKey,
  DWORD ulOptions,
  REGSAM samDesired,
  PHKEY phkResult
);
LONG RegOpenKeyExW(
  HKEY hKey,
  LPWSTR lpSubKey,
  DWORD ulOptions,
  REGSAM samDesired,
  PHKEY phkResult
);

LONG RegQueryInfoKeyA(
  HKEY hKey,
  LPSTR lpClass,
  LPDWORD lpcClass,
  LPDWORD lpReserved,
  LPDWORD lpcSubKeys,
  LPDWORD lpcMaxSubKeyLen,
  LPDWORD lpcMaxClassLen,
  LPDWORD lpcValues,
  LPDWORD lpcMaxValueNameLen,
  LPDWORD lpcMaxValueLen,
  LPDWORD lpcbSecurityDescriptor,
  PFILETIME lpftLastWriteTime
);
LONG RegQueryInfoKeyW(
  HKEY hKey,
  LPWSTR lpClass,
  LPDWORD lpcClass,
  LPDWORD lpReserved,
  LPDWORD lpcSubKeys,
  LPDWORD lpcMaxSubKeyLen,
  LPDWORD lpcMaxClassLen,
  LPDWORD lpcValues,
  LPDWORD lpcMaxValueNameLen,
  LPDWORD lpcMaxValueLen,
  LPDWORD lpcbSecurityDescriptor,
  PFILETIME lpftLastWriteTime
);

LONG RegQueryValueExA(
  HKEY hKey,
  LPCSTR lpValueName,
  LPDWORD lpReserved,
  LPDWORD lpType,
  LPBYTE lpData,
  LPDWORD lpcbData
);
LONG RegQueryValueExW(
  HKEY hKey,
  LPCWSTR lpValueName,
  LPDWORD lpReserved,
  LPDWORD lpType,
  LPBYTE lpData,
  LPDWORD lpcbData
);

ATOM RegisterClassA(
    WNDCLASSA *lpWndClass
);
ATOM RegisterClassW(
    WNDCLASSW *lpWndClass
);
UINT RegisterClipboardFormatA(
    LPCSTR lpszFormat
);
UINT RegisterClipboardFormatW(
    LPCWSTR lpszFormat
);
UINT RegisterWindowMessageA(
    LPCSTR lpString
);
UINT RegisterWindowMessageW(
    LPCWSTR lpString
);
BOOL ReleaseCapture();
BOOL RemoveMenu(
    HMENU hMenu,
    UINT uPosition,
    UINT uFlags
);
BOOL RestoreDC(
    HDC hdc,       // handle to DC
    int nSavedDC   // restore state
);
//alias STDWIN.RoundRect RoundRect;

// basic
void RtlMoveMemory(void* Destination, void* Source, DWORD Length);
// extends
void RtlMoveMemory(int Destination, void* Source, DWORD Length);
void RtlMoveMemory(void* Destination, int Source, DWORD Length);
void RtlMoveMemory(int Destination, int Source, DWORD Length);

LPITEMIDLIST SHBrowseForFolderA(
    BROWSEINFOA* lpbi
);
LPITEMIDLIST SHBrowseForFolderW(
    BROWSEINFOW* lpbi
);
version(WinCE){
    int SHCreateMenuBar(SHMENUBARINFO* pmb);
}
HRESULT SHGetMalloc(
//  LPMALLOC *ppMalloc
    LPVOID   *ppMalloc
);
BOOL SHGetPathFromIDListA(
    LPCITEMIDLIST pidl,
    LPSTR pszPath
);
BOOL SHGetPathFromIDListW(
    LPCITEMIDLIST pidl,
    LPWSTR pszPath
);
version(WinCE)
{
    int SHHandleWMSettingChange(HWND hwnd, int wParam, int lParam, void*  psai);
    int SHRecognizeGesture(void* shrg);
    void SHSendBackToFocusWindow(int uMsg, int wp, int lp);
    int SHSetAppKeyWndAssoc(byte bVk, HWND hwnd);
    int SHSipPreference(HWND hwnd, int st);
}

// USP methods (Unicode Complex Script processor)
HRESULT ScriptBreak(
  WCHAR *pwcChars,
  int cChars,
  SCRIPT_ANALYSIS *psa,
  SCRIPT_LOGATTR *psla
);
HRESULT ScriptCPtoX(
  int iCP,
  BOOL fTrailing,
  int cChars,
  int cGlyphs,
  WORD *pwLogClust,
  SCRIPT_VISATTR *psva,
  int *piAdvance,
  SCRIPT_ANALYSIS *psa,
  int *piX
);
HRESULT ScriptCacheGetHeight(
  HDC hdc,
  SCRIPT_CACHE *psc,
  long *tmHeight
);
HRESULT ScriptFreeCache(
  SCRIPT_CACHE *psc
);
HRESULT ScriptGetFontProperties(
  HDC hdc,
  SCRIPT_CACHE *psc,
  SCRIPT_FONTPROPERTIES *sfp
);
HRESULT ScriptGetLogicalWidths(
  SCRIPT_ANALYSIS *psa,
  int cChars,
  int cGlyphs,
  int *piGlyphWidth,
  WORD *pwLogClust,
  SCRIPT_VISATTR *psva,
  int *piDx
);
HRESULT ScriptGetProperties(
  SCRIPT_PROPERTIES ***ppSp,
  int *piNumScripts
);
HRESULT ScriptGetCMap(
  HDC hdc,
  SCRIPT_CACHE* psc,
  WCHAR* pwcInChars,
  int cChars,
  DWORD dwFlags,
  WORD* pwOutGlyphs
);
HRESULT ScriptStringAnalyse(
  HDC hdc,
  void* pString,
  int cString,
  int cGlyphs,
  int iCharset,
  DWORD dwFlags,
  int iReqWidth,
  SCRIPT_CONTROL* psControl,
  SCRIPT_STATE* psState,
  int* piDx,
  SCRIPT_TABDEF* pTabdef,
  BYTE* pbInClass,
  SCRIPT_STRING_ANALYSIS* pssa
);
HRESULT ScriptStringOut(
  SCRIPT_STRING_ANALYSIS ssa, 
  int iX, 
  int iY, 
  UINT uOptions, 
  RECT* prc, 
  int iMinSel, 
  int iMaxSel, 
  BOOL fDisabled 
);
HRESULT ScriptStringFree(
  SCRIPT_STRING_ANALYSIS* pssa  
);

HRESULT ScriptItemize(
  WCHAR *pwcInChars,
  int cInChars,
  int cMaxItems,
  SCRIPT_CONTROL *psControl,
  SCRIPT_STATE *psState,
  SCRIPT_ITEM *pItems,
  int *pcItems
);
HRESULT ScriptLayout(
  int cRuns,
  BYTE *pbLevel,
  int *piVisualToLogical,
  int *piLogicalToVisual
);
HRESULT ScriptPlace(
  HDC hdc,
  SCRIPT_CACHE *psc,
  WORD *pwGlyphs,
  int cGlyphs,
  SCRIPT_VISATTR *psva,
  SCRIPT_ANALYSIS *psa,
  int *piAdvance,
  GOFFSET *pGoffset,
  ABC *pABC
);
HRESULT ScriptShape(
  HDC hdc,              // in
  SCRIPT_CACHE *psc,    // in/out
  WCHAR *pwcChars,      //
  int cChars,
  int cMaxGlyphs,
  SCRIPT_ANALYSIS *psa,
  WORD *pwOutGlyphs,
  WORD *pwLogClust,
  SCRIPT_VISATTR *psva,
  int *pcGlyphs
);
HRESULT ScriptTextOut(
  HDC hdc,              // const
  SCRIPT_CACHE *psc,
  int x,
  int y,
  UINT fuOptions,
  RECT *lprc,           // const
  SCRIPT_ANALYSIS *psa, // const
  WCHAR *pwcReserved,   // const
  int iReserved,
  WORD *pwGlyphs,       //
  int cGlyphs,
  int *piAdvance,       // const
  int *piJustify,       // const
  GOFFSET *pGoffset     // const
);
HRESULT ScriptXtoCP(
  int iX,
  int cChars,
  int cGlyphs,
  WORD *pwLogClust,         //
  SCRIPT_VISATTR *psva,     //
  int *piAdvance,           //
  SCRIPT_ANALYSIS *psa,     //
  int *piCP,
  int *piTrailing
);
UINT SendInput(
    UINT nInputs,
    LPINPUT pInputs,
    int cbSize
);
// the basic
int SendMessageA(HWND hWnd, int msg, int wParam, int lParam );
int SendMessageW(HWND hWnd, int msg, int wParam, int lParam );

int SendMessageA(HWND hWnd, UINT Msg, WPARAM wParam, void* lParam );
int SendMessageW(HWND hWnd, UINT Msg, WPARAM wParam, void* lParam );
int SendMessageA(HWND hWnd, UINT Msg, void* wParam, LPARAM lParam );
int SendMessageW(HWND hWnd, UINT Msg, void* wParam, LPARAM lParam );
int SendMessageA(HWND hWnd, UINT Msg, void* wParam, void* lParam );
int SendMessageW(HWND hWnd, UINT Msg, void* wParam, void* lParam );

HWND SetCapture(
    HWND hWnd
);
BOOL SetCaretPos(
    int X,
    int Y
);
HANDLE SetClipboardData(
    UINT uFormat,
    HANDLE hMem
);
UINT SetDIBColorTable(
    HDC hdc,                // handle to device context whose DIB is of interest
    UINT uStartIndex,       // color table index of first entry to set
    UINT cEntries,          // number of color table entries to set
    RGBQUAD *pColors  // pointer to array of color table entries
);
UINT SetErrorMode(
    UINT uMode
);
BOOL SetEvent(
  HANDLE hEvent   // handle to event object
);
void SetLastError(
    DWORD dwErrCode
);
DWORD SetLayout(
    HDC hdc,             // handle to DC
    DWORD dwLayout       // layout options
);
BOOL SetMenu(
    HWND hWnd,
    HMENU hMenu
);
BOOL SetMenuDefaultItem(
    HMENU hMenu,
    UINT uItem,
    UINT fByPos
);
BOOL SetMenuInfo(
    HMENU hmenu,
    LPCMENUINFO lpcmi
);
BOOL SetMenuItemInfoA(
    HMENU hMenu,
    UINT uItem,
    BOOL fByPosition,
    LPMENUITEMINFOA lpmii
);
BOOL SetMenuItemInfoW(
    HMENU hMenu,
    UINT uItem,
    BOOL fByPosition,
    LPMENUITEMINFOW lpmii
);
UINT SetPaletteEntries(
    HPALETTE hpal,             // handle to logical palette
    UINT iStart,               // index of first entry to set
    UINT cEntries,             // number of entries to set
    PALETTEENTRY *lppe              // array of palette entries
);
HWND SetParent(
    HWND hWndChild,
    HWND hWndNewParent
);
// alias STDWIN.SetPixel SetPixel;
// alias STDWIN.SetROP2 SetROP2;
BOOL SetRect(
    LPRECT lprc, // rectangle
    int xLeft,   // left side
    int yTop,    // top side
    int xRight,  // right side
    int yBottom  // bottom side
);
// alias STDWIN.SetRectRgn SetRectRgn;
int SetScrollInfo(
    HWND hwnd,
    int fnBar,
    LPCSCROLLINFO lpsi,
    BOOL fRedraw
);
UINT_PTR SetTimer(
    HWND hWnd,
    UINT_PTR nIDEvent,
    UINT uElapse,
    TIMERPROC lpTimerFunc
);
LONG SetWindowLongA(
    HWND hWnd,
    int nIndex,
    LONG dwNewLong
);
LONG SetWindowLongW(
    HWND hWnd,
    int nIndex,
    LONG dwNewLong
);

BOOL SetWindowPlacement(
    HWND hWnd,
    WINDOWPLACEMENT *lpwndpl
);
BOOL SetWindowPos(
    HWND hWnd,             // handle to window
    HWND hWndInsertAfter,  // placement-order handle
    int X,                 // horizontal position
    int Y,                 // vertical position
    int cx,                // width
    int cy,                // height
    UINT uFlags            // window-positioning flags
);
BOOL SetWindowTextA(
    HWND hWnd,
    LPCSTR lpString
);
BOOL SetWindowTextW(
    HWND hWnd,
    LPCWSTR lpString
);
HHOOK SetWindowsHookExA(
    int idHook,        // type of hook to install
    HOOKPROC lpfn,     // address of hook procedure
    HINSTANCE hMod,    // handle to application instance
    DWORD dwThreadId   // identity of thread to install hook for
);
HHOOK SetWindowsHookExW(
    int idHook,        // type of hook to install
    HOOKPROC lpfn,     // address of hook procedure
    HINSTANCE hMod,    // handle to application instance
    DWORD dwThreadId   // identity of thread to install hook for
);
BOOL ShellExecuteExA(
    LPSHELLEXECUTEINFOA lpExecInfo
);
BOOL ShellExecuteExW(
    LPSHELLEXECUTEINFOW lpExecInfo
);
BOOL Shell_NotifyIconA(
    DWORD dwMessage,
    PNOTIFYICONDATAA lpdata
);
BOOL Shell_NotifyIconW(
    DWORD dwMessage,
    PNOTIFYICONDATAW lpdata
);
BOOL ShowOwnedPopups(
    HWND hWnd,
    BOOL fShow
);
version(WinCE)
{
BOOL SipGetInfo(
    SIPINFO *pSipInfo
);
}
DWORD SizeofResource(
    HMODULE hModule, // resource-module handle
    HRSRC hResInfo   // resource handle
);
void Sleep(
    DWORD dwMilliseconds
);
int StartDocA(
    HDC hdc,              // handle to DC
    DOCINFOA* lpdi          // contains file names
);
int StartDocW(
    HDC hdc,              // handle to DC
    DOCINFOW* lpdi          // contains file names
);
int StartPage(
    HDC hDC   // handle to DC
);
// alias STDWIN.StretchBlt StretchBlt;
BOOL SystemParametersInfoA(
    UINT uiAction,
    UINT uiParam,
    PVOID pvParam,
    UINT fWinIni
);
BOOL SystemParametersInfoW(
    UINT uiAction,
    UINT uiParam,
    PVOID pvParam,
    UINT fWinIni
);
int ToAscii(
    UINT uVirtKey,
    UINT uScanCode,
    PBYTE lpKeyState,
    LPWORD lpChar,
    UINT uFlags
);
int ToUnicode(
    UINT wVirtKey,
    UINT wScanCode,
    PBYTE lpKeyState,
    LPWSTR pwszBuff,
    int cchBuff,
    UINT wFlags
);
BOOL TrackMouseEvent(
    LPTRACKMOUSEEVENT lpEventTrack  // pointer to a TRACKMOUSEEVENT structure
);
int TranslateAcceleratorA(
    HWND hWnd,         // handle to destination window
    HACCEL hAccTable,  // handle to accelerator table
    LPMSG lpMsg        // address of structure with message
);
int TranslateAcceleratorW(
    HWND hWnd,         // handle to destination window
    HACCEL hAccTable,  // handle to accelerator table
    LPMSG lpMsg        // address of structure with message
);
UINT TranslateCharsetInfo(
    DWORD *lpSrc,
    LPCHARSETINFO lpCs,
    DWORD dwFlags
);
BOOL TranslateMDISysAccel(
    HWND hWndClient,
    LPMSG lpMsg
);
BOOL TranslateMessage(
    MSG *lpMsg   // address of structure with message
);
version(WinCE)
{
BOOL TransparentImage(
HDC hdcDest,
LONG DstX,
LONG DstY,
LONG DstCx,
LONG DstCy,
HANDLE hSrc,
LONG SrcX,
LONG SrcY,
LONG SrcCx,
LONG SrcCy,
COLORREF TransparentColor
);
}
BOOL UnhookWindowsHookEx(
    HHOOK hhk   // handle to hook procedure to remove
);
BOOL UnregisterClassA(
    LPCSTR lpClassName,  // address of class name string
    HINSTANCE hInstance   // handle of application instance
);
BOOL UnregisterClassW(
    LPCWSTR lpClassName,  // address of class name string
    HINSTANCE hInstance   // handle of application instance
);
SHORT VkKeyScanA(char ch);
SHORT VkKeyScanW(wchar ch);
BOOL WaitMessage();

BOOL GetScrollBarInfo(
    HWND hwnd,
    LONG idObject,
    PSCROLLBARINFO psbi
);

}

extern (C)
{
    int wcslen(wchar* string);
}
