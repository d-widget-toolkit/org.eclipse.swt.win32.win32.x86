/**
 * This module declared window APIs required by SWT but not in std.c.windows.windows,
 * The one in the std.c.windows.windows module are aliased
 */


module org.eclipse.swt.internal.win32.WINAPI;

public import org.eclipse.swt.internal.win32.WINTYPES;

version(Tango){
    import tango.sys.win32.Types;
    static import tango.sys.win32.UserGdi;
    public alias tango.sys.win32.UserGdi WINAPI;
} else { // Phobos
    struct WINAPI{ static {
        /+ Functions +/
        extern(Windows)
        {
            BOOL GetWindowInfo(HWND, PWINDOWINFO);
            BOOL EnumDisplayMonitors(HDC, RECT*, MONITORENUMPROC, LPARAM);
            BOOL GetMonitorInfoA(HMONITOR, LPMONITORINFO);
            WINBOOL GetBinaryTypeA(LPCSTR, LPDWORD);
            DWORD GetShortPathNameA(LPCSTR, LPSTR, DWORD);
            LPSTR GetEnvironmentStringsA();
            WINBOOL FreeEnvironmentStringsA(LPSTR);
            DWORD FormatMessageA(DWORD, LPCVOID, DWORD, DWORD, LPSTR, DWORD, VA_LIST*);
            HANDLE CreateMailslotA(LPCSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
            int lstrcmpA(LPCSTR, LPCSTR);
            int lstrcmpiA(LPCSTR, LPCSTR);
            LPSTR lstrcpynA(LPSTR, LPCSTR, int);
            LPSTR lstrcpyA(LPSTR, LPCSTR);
            LPSTR lstrcatA(LPSTR, LPCSTR);
            int lstrlenA(LPCSTR);
            HANDLE CreateMutexA(LPSECURITY_ATTRIBUTES, WINBOOL, LPCSTR);
            HANDLE OpenMutexA(DWORD, WINBOOL, LPCSTR);
            HANDLE CreateEventA(LPSECURITY_ATTRIBUTES, WINBOOL, WINBOOL, LPCSTR);
            HANDLE OpenEventA(DWORD, WINBOOL, LPCSTR);
            HANDLE CreateSemaphoreA(LPSECURITY_ATTRIBUTES, LONG, LONG, LPCSTR);
            HANDLE OpenSemaphoreA(DWORD, WINBOOL, LPCSTR);
            HANDLE CreateFileMappingA(HANDLE, LPSECURITY_ATTRIBUTES, DWORD, DWORD, DWORD, LPCSTR);
            HANDLE OpenFileMappingA(DWORD, WINBOOL, LPCSTR);
            DWORD GetLogicalDriveStringsA(DWORD, LPSTR);
            HINST LoadLibraryA(LPCSTR);
            HINST LoadLibraryExA(LPCSTR, HANDLE, DWORD);
            DWORD GetModuleFileNameA(HINST, LPSTR, DWORD);
            HMODULE GetModuleHandleA(LPCSTR);
            void FatalAppExitA(UINT);
            LPSTR GetCommandLineA();
            DWORD GetEnvironmentVariableA(LPCSTR, LPSTR, DWORD);
            WINBOOL SetEnvironmentVariableA(LPCSTR, LPCSTR);
            DWORD ExpandEnvironmentStringsA(LPCSTR, LPSTR, DWORD);
            void OutputDebugStringA(LPCSTR);
            HRSRC FindResourceA(HINST, LPCSTR, LPCSTR);
            HRSRC FindResourceExA(HINST, LPCSTR, LPCSTR, ushort);
            WINBOOL EnumResourceTypesA(HINST, ENUMRESTYPEPROC, LONG);
            WINBOOL EnumResourceNamesA(HINST, LPCSTR, ENUMRESNAMEPROC, LONG);
            WINBOOL EnumResourceLanguagesA(HINST, LPCSTR, LPCSTR, ENUMRESLANGPROC, LONG);
            HANDLE BeginUpdateResourceA(LPCSTR, WINBOOL);
            WINBOOL UpdateResourceA(HANDLE, LPCSTR, LPCSTR, ushort, LPVOID, DWORD);
            WINBOOL EndUpdateResourceA(HANDLE, WINBOOL);
            ATOM GlobalAddAtomA(LPCSTR);
            ATOM GlobalFindAtomA(LPCSTR);
            UINT GlobalGetAtomNameA(ATOM, LPSTR, int);
            ATOM AddAtomA(LPCSTR);
            ATOM FindAtomA(LPCSTR);
            UINT GetAtomNameA(ATOM, LPSTR, int);
            UINT GetProfileIntA(LPCSTR, LPCSTR, INT);
            DWORD GetProfileStringA(LPCSTR, LPCSTR, LPCSTR, LPSTR, DWORD);
            WINBOOL WriteProfileStringA(LPCSTR, LPCSTR, LPCSTR);
            DWORD GetProfileSectionA(LPCSTR, LPSTR, DWORD);
            WINBOOL WriteProfileSectionA(LPCSTR, LPCSTR);
            UINT GetPrivateProfileIntA(LPCSTR, LPCSTR, INT, LPCSTR);
            DWORD GetPrivateProfileStringA(LPCSTR, LPCSTR, LPCSTR, LPSTR, DWORD, LPCSTR);
            WINBOOL WritePrivateProfileStringA(LPCSTR, LPCSTR, LPCSTR, LPCSTR);
            DWORD GetPrivateProfileSectionA(LPCSTR, LPSTR, DWORD, LPCSTR);
            WINBOOL WritePrivateProfileSectionA(LPCSTR, LPCSTR, LPCSTR);
            UINT GetDriveTypeA(LPCSTR);
            UINT GetSystemDirectoryA(LPSTR, UINT);
            DWORD GetTempPathA(DWORD, LPSTR);
            UINT GetTempFileNameA(LPCSTR, LPCSTR, UINT, LPSTR);
            UINT GetWindowsDirectoryA(LPSTR, UINT);
            WINBOOL SetCurrentDirectoryA(LPCSTR);
            DWORD GetCurrentDirectoryA(DWORD, LPSTR);
            WINBOOL GetDiskFreeSpaceA(LPCSTR, LPDWORD, LPDWORD, LPDWORD, LPDWORD);
            WINBOOL CreateDirectoryA(LPCSTR, LPSECURITY_ATTRIBUTES);
            WINBOOL CreateDirectoryExA(LPCSTR, LPCSTR, LPSECURITY_ATTRIBUTES);
            WINBOOL RemoveDirectoryA(LPCSTR);
            DWORD GetFullPathNameA(LPCSTR, DWORD, LPSTR, LPSTR*);
            WINBOOL DefineDosDeviceA(DWORD, LPCSTR, LPCSTR);
            DWORD QueryDosDeviceA(LPCSTR, LPSTR, DWORD);
            HANDLE CreateFileA(LPCSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES, DWORD, DWORD, HANDLE);
            WINBOOL SetFileAttributesA(LPCSTR, DWORD);
            DWORD GetFileAttributesA(LPCSTR);
            BOOL GetFileAttributesExA(LPCSTR, DWORD, WIN32_FILE_ATTRIBUTE_DATA*);
            DWORD GetCompressedFileSizeA(LPCSTR, LPDWORD);
            WINBOOL DeleteFileA(LPCSTR);
            DWORD SearchPathA(LPCSTR, LPCSTR, LPCSTR, DWORD, LPSTR, LPSTR);
            WINBOOL CopyFileA(LPCSTR, LPCSTR, WINBOOL);
            WINBOOL MoveFileA(LPCSTR, LPCSTR);
            WINBOOL MoveFileExA(LPCSTR, LPCSTR, DWORD);
            HANDLE CreateNamedPipeA(LPCSTR, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
            WINBOOL GetNamedPipeHandleStateA(HANDLE, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPSTR, DWORD);
            WINBOOL CallNamedPipeA(LPCSTR, LPVOID, DWORD, LPVOID, DWORD, LPDWORD, DWORD);
            WINBOOL WaitNamedPipeA(LPCSTR, DWORD);
            WINBOOL SetVolumeLabelA(LPCSTR, LPCSTR);
            WINBOOL GetVolumeInformationA(LPCSTR, LPSTR, DWORD, LPDWORD, LPDWORD, LPDWORD, LPSTR, DWORD);
            WINBOOL ClearEventLogA(HANDLE, LPCSTR);
            WINBOOL BackupEventLogA(HANDLE, LPCSTR);
            HANDLE OpenEventLogA(LPCSTR, LPCSTR);
            HANDLE RegisterEventSourceA(LPCSTR, LPCSTR);
            HANDLE OpenBackupEventLogA(LPCSTR, LPCSTR);
            WINBOOL ReadEventLogA(HANDLE, DWORD, DWORD, LPVOID, DWORD, LPDWORD, LPDWORD);
            WINBOOL ReportEventA(HANDLE, ushort, ushort, DWORD, PSID, ushort, DWORD, LPCSTR*, LPVOID);
            WINBOOL AccessCheckAndAuditAlarmA(LPCSTR, LPVOID, LPSTR, LPSTR, PSECURITY_DESCRIPTOR, DWORD, PGENERIC_MAPPING, WINBOOL, LPDWORD, LPBOOL, LPBOOL);
            WINBOOL ObjectOpenAuditAlarmA(LPCSTR, LPVOID, LPSTR, LPSTR, PSECURITY_DESCRIPTOR, HANDLE, DWORD, DWORD, PPRIVILEGE_SET, WINBOOL, WINBOOL, LPBOOL);
            WINBOOL ObjectPrivilegeAuditAlarmA(LPCSTR, LPVOID, HANDLE, DWORD, PPRIVILEGE_SET, WINBOOL);
            WINBOOL ObjectCloseAuditAlarmA(LPCSTR, LPVOID, WINBOOL);
            WINBOOL PrivilegedServiceAuditAlarmA(LPCSTR, LPCSTR, HANDLE, PPRIVILEGE_SET, WINBOOL);
            WINBOOL SetFileSecurityA(LPCSTR, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR);
            WINBOOL GetFileSecurityA(LPCSTR, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR, DWORD, LPDWORD);
            HANDLE FindFirstChangeNotificationA(LPCSTR, WINBOOL, DWORD);
            WINBOOL IsBadStringPtrA(LPCSTR, UINT);
            WINBOOL LookupAccountSidA(LPCSTR, PSID, LPSTR, LPDWORD, LPSTR, LPDWORD, PSID_NAME_USE);
            WINBOOL LookupAccountNameA(LPCSTR, LPCSTR, PSID, LPDWORD, LPSTR, LPDWORD, PSID_NAME_USE);
            WINBOOL LookupPrivilegeValueA(LPCSTR, LPCSTR, PLUID);
            WINBOOL LookupPrivilegeNameA(LPCSTR, PLUID, LPSTR, LPDWORD);
            WINBOOL LookupPrivilegeDisplayNameA(LPCSTR, LPCSTR, LPSTR, LPDWORD, LPDWORD);
            WINBOOL BuildCommDCBA(LPCSTR, LPDCB);
            WINBOOL BuildCommDCBAndTimeoutsA(LPCSTR, LPDCB, LPCOMMTIMEOUTS);
            WINBOOL CommConfigDialogA(LPCSTR, HWND, LPCOMMCONFIG);
            WINBOOL GetDefaultCommConfigA(LPCSTR, LPCOMMCONFIG, LPDWORD);
            WINBOOL SetDefaultCommConfigA(LPCSTR, LPCOMMCONFIG, DWORD);
            WINBOOL GetComputerNameA(LPSTR, LPDWORD);
            WINBOOL SetComputerNameA(LPCSTR);
            WINBOOL GetUserNameA(LPSTR, LPDWORD);
            int wvsprintfA(LPSTR, LPCSTR, VA_LIST*);
            HKL LoadKeyboardLayoutA(LPCSTR, UINT);
            WINBOOL GetKeyboardLayoutNameA(LPSTR);
            HDESK CreateDesktopA(LPSTR, LPSTR, LPDEVMODE, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
            HDESK OpenDesktopA(LPSTR, DWORD, WINBOOL, DWORD);
            WINBOOL EnumDesktopsA(HWINSTA, DESKTOPENUMPROC, LPARAM);
            HWINSTA CreateWindowStationA(LPSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
            HWINSTA OpenWindowStationA(LPSTR, WINBOOL, DWORD);
            WINBOOL EnumWindowStationsA(ENUMWINDOWSTATIONPROC, LPARAM);
            WINBOOL GetUserObjectInformationA(HANDLE, int, PVOID, DWORD, LPDWORD);
            WINBOOL SetUserObjectInformationA(HANDLE, int, PVOID, DWORD);
            UINT RegisterWindowMessageA(LPCSTR);
            WINBOOL GetMessageA(LPMSG, HWND, UINT, UINT);
            LONG DispatchMessageA(LPMSG);
            WINBOOL PeekMessageA(LPMSG, HWND, UINT, UINT, UINT);
            LRESULT SendMessageA(HWND, UINT, WPARAM, LPARAM);
            LRESULT SendMessageA(HWND, UINT, void*, LPARAM);
            LRESULT SendMessageA(HWND, UINT, WPARAM, void*);
            LRESULT SendMessageA(HWND, UINT, void*, void*);
            LRESULT SendMessageTimeoutA(HWND, UINT, WPARAM, LPARAM, UINT, UINT, LPDWORD);
            WINBOOL SendNotifyMessageA(HWND, UINT, WPARAM, LPARAM);
            WINBOOL SendMessageCallbackA(HWND, UINT, WPARAM, LPARAM, SENDASYNCPROC, DWORD);
            WINBOOL PostMessageA(HWND, UINT, WPARAM, LPARAM);
            WINBOOL PostThreadMessageA(DWORD, UINT, WPARAM, LPARAM);
            LRESULT DefWindowProcA(HWND, UINT, WPARAM, LPARAM);
            LRESULT CallWindowProcA(WNDPROC, HWND, UINT, WPARAM, LPARAM);
            ATOM RegisterClassA(LPWNDCLASSA);
            WINBOOL UnregisterClassA(LPCSTR, HINST);
            WINBOOL GetClassInfoA(HINST, LPCSTR, LPWNDCLASS);
            ATOM RegisterClassExA(LPWNDCLASSEX);
            WINBOOL GetClassInfoExA(HINST, LPCSTR, LPWNDCLASSEX);
            HWND CreateWindowExA(DWORD, LPCSTR, LPCSTR, DWORD, int, int, int, int, HWND, HMENU, HINST, LPVOID);
            HWND CreateDialogParamA(HINST, LPCSTR, HWND, DLGPROC, LPARAM);
            HWND CreateDialogIndirectParamA(HINST, LPCDLGTEMPLATE, HWND, DLGPROC, LPARAM);
            int DialogBoxParamA(HINST, LPCSTR, HWND, DLGPROC, LPARAM);
            int DialogBoxIndirectParamA(HINST, LPCDLGTEMPLATE, HWND, DLGPROC, LPARAM);
            WINBOOL SetDlgItemTextA(HWND, int, LPCSTR);
            UINT GetDlgItemTextA(HWND, int, LPSTR, int);
            LONG SendDlgItemMessageA(HWND, int, UINT, WPARAM, LPARAM);
            LRESULT DefDlgProcA(HWND, UINT, WPARAM, LPARAM);
            WINBOOL CallMsgFilterA(LPMSG, int);
            UINT RegisterClipboardFormatA(LPCSTR);
            int GetClipboardFormatNameA(UINT, LPSTR, int);
            WINBOOL CharToOemA(LPCSTR, LPSTR);
            WINBOOL OemToCharA(LPCSTR, LPSTR);
            WINBOOL CharToOemBuffA(LPCSTR, LPSTR, DWORD);
            WINBOOL OemToCharBuffA(LPCSTR, LPSTR, DWORD);
            LPSTR CharUpperA(LPSTR);
            DWORD CharUpperBuffA(LPSTR, DWORD);
            LPSTR CharLowerA(LPSTR);
            DWORD CharLowerBuffA(LPSTR, DWORD);
            LPSTR CharNextA(LPCSTR);
            LPSTR CharPrevA(LPCSTR, LPCSTR);
            WINBOOL IsCharAlphaA(char);
            WINBOOL IsCharAlphaNumericA(char);
            WINBOOL IsCharUpperA(char);
            WINBOOL IsCharLowerA(char);
            int GetKeyNameTextA(LONG, LPSTR, int);
            SHORT VkKeyScanA(char);
            SHORT VkKeyScanExA(char, HKL);
            UINT MapVirtualKeyA(UINT, UINT);
            UINT MapVirtualKeyExA(UINT, UINT, HKL);
            HACCEL LoadAcceleratorsA(HINST, LPCSTR);
            HACCEL CreateAcceleratorTableA(LPACCEL, int);
            int CopyAcceleratorTableA(HACCEL, LPACCEL, int);
            int TranslateAcceleratorA(HWND, HACCEL, LPMSG);
            HMENU LoadMenuA(HINST, LPCSTR);
            HMENU LoadMenuIndirectA(LPMENUTEMPLATE);
            WINBOOL ChangeMenuA(HMENU, UINT, LPCSTR, UINT, UINT);
            int GetMenuStringA(HMENU, UINT, LPSTR, int, UINT);
            WINBOOL InsertMenuA(HMENU, UINT, UINT, UINT, LPCSTR);
            WINBOOL AppendMenuA(HMENU, UINT, UINT, LPCSTR);
            WINBOOL ModifyMenuA(HMENU, UINT, UINT, UINT, LPCSTR);
            WINBOOL InsertMenuItemA(HMENU, UINT, WINBOOL, LPCMENUITEMINFO);
            WINBOOL GetMenuItemInfoA(HMENU, UINT, WINBOOL, LPMENUITEMINFO);
            WINBOOL SetMenuItemInfoA(HMENU, UINT, WINBOOL, LPCMENUITEMINFO);
            int DrawTextA(HDC, LPCSTR, int, LPRECT, UINT);
            int DrawTextExA(HDC, LPSTR, int, LPRECT, UINT, LPDRAWTEXTPARAMS);
            WINBOOL GrayStringA(HDC, HBRUSH, GRAYSTRINGPROC, LPARAM, int, int, int, int, int);
            WINBOOL DrawStateA(HDC, HBRUSH, DRAWSTATEPROC, LPARAM, WPARAM, int, int, int, int, UINT);
            LONG TabbedTextOutA(HDC, int, int, LPCSTR, int, int, LPINT, int);
            DWORD GetTabbedTextExtentA(HDC, LPCSTR, int, int, LPINT);
            WINBOOL SetPropA(HWND, LPCSTR, HANDLE);
            HANDLE GetPropA(HWND, LPCSTR);
            HANDLE RemovePropA(HWND, LPCSTR);
            int EnumPropsExA(HWND, PROPENUMPROCEX, LPARAM);
            int EnumPropsA(HWND, PROPENUMPROC);
            WINBOOL SetWindowTextA(HWND, LPCSTR);
            int GetWindowTextA(HWND, LPSTR, int);
            int GetWindowTextLengthA(HWND);
            int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT);
            int MessageBoxExA(HWND, LPCSTR, LPCSTR, UINT, ushort);
            int MessageBoxIndirectA(LPMSGBOXPARAMS);
            LONG GetWindowLongA(HWND, int);
            LONG SetWindowLongA(HWND, int, LONG);
            DWORD GetClassLongA(HWND, int);
            DWORD SetClassLongA(HWND, int, LONG);
            HWND FindWindowA(LPCSTR, LPCSTR);
            HWND FindWindowExA(HWND, HWND, LPCSTR, LPCSTR);
            int GetClassNameA(HWND, LPSTR, int);
            HHOOK SetWindowsHookExA(int, HOOKPROC, HINST, DWORD);
            HBITMAP LoadBitmapA(HINST, LPCSTR);
            HCURSOR LoadCursorA(HINST, LPCSTR);
            HCURSOR LoadCursorFromFileA(LPCSTR);
            HICON LoadIconA(HINST, LPCSTR);
            HANDLE LoadImageA(HINST, LPCSTR, UINT, int, int, UINT);
            int LoadStringA(HINST, UINT, LPSTR, int);
            WINBOOL IsDialogMessageA(HWND, LPMSG);
            int DlgDirListA(HWND, LPSTR, int, int, UINT);
            WINBOOL DlgDirSelectExA(HWND, LPSTR, int, int);
            int DlgDirListComboBoxA(HWND, LPSTR, int, int, UINT);
            WINBOOL DlgDirSelectComboBoxExA(HWND, LPSTR, int, int);
            LRESULT DefFrameProcA(HWND, HWND, UINT, WPARAM, LPARAM);
            LRESULT DefMDIChildProcA(HWND, UINT, WPARAM, LPARAM);
            HWND CreateMDIWindowA(LPSTR, LPSTR, DWORD, int, int, int, int, HWND, HINST, LPARAM);
            WINBOOL WinHelpA(HWND, LPCSTR, UINT, DWORD);
            LONG ChangeDisplaySettingsA(LPDEVMODE, DWORD);
            WINBOOL EnumDisplaySettingsA(LPCSTR, DWORD, LPDEVMODE);
            WINBOOL SystemParametersInfoA(UINT, UINT, PVOID, UINT);
            int AddFontResourceA(LPCSTR);
            HMETAFILE CopyMetaFileA(HMETAFILE, LPCSTR);
            HFONT CreateFontIndirectA(LPLOGFONT);
            HDC CreateICA(LPCSTR, LPCSTR, LPCSTR, LPDEVMODE);
            HDC CreateMetaFileA(LPCSTR);
            WINBOOL CreateScalableFontResourceA(DWORD, LPCSTR, LPCSTR, LPCSTR);
            int EnumFontFamiliesExA(HDC, LPLOGFONT, FONTENUMEXPROC, LPARAM, DWORD);
            int EnumFontFamiliesA(HDC, LPCSTR, FONTENUMPROC, LPARAM);
            int EnumFontsA(HDC, LPCSTR, ENUMFONTSPROC, LPARAM);
            WINBOOL GetCharWidthA(HDC, UINT, UINT, LPINT);
            WINBOOL GetCharWidth32A(HDC, UINT, UINT, LPINT);
            WINBOOL GetCharWidthFloatA(HDC, UINT, UINT, PFLOAT);
            WINBOOL GetCharABCWidthsA(HDC, UINT, UINT, LPABC);
            WINBOOL GetCharABCWidthsFloatA(HDC, UINT, UINT, LPABCFLOAT);
            DWORD GetGlyphOutlineA(HDC, UINT, UINT, LPGLYPHMETRICS, DWORD, LPVOID, PMAT2);
            HMETAFILE GetMetaFileA(LPCSTR);
            UINT GetOutlineTextMetricsA(HDC, UINT, LPOUTLINETEXTMETRIC);
            WINBOOL GetTextExtentPointA(HDC, LPCSTR, int, LPSIZE);
            WINBOOL GetTextExtentPoint32A(HDC, LPCSTR, int, LPSIZE);
            WINBOOL GetTextExtentExPointA(HDC, LPCSTR, int, int, LPINT, LPINT, LPSIZE);
            DWORD GetCharacterPlacementA(HDC, LPCSTR, int, int, LPGCP_RESULTS, DWORD);
            HDC ResetDCA(HDC, LPDEVMODE);
            WINBOOL RemoveFontResourceA(LPCSTR);
            HENHMETAFILE CopyEnhMetaFileA(HENHMETAFILE, LPCSTR);
            HDC CreateEnhMetaFileA(HDC, LPCSTR, LPRECT, LPCSTR);
            HENHMETAFILE GetEnhMetaFileA(LPCSTR);
            UINT GetEnhMetaFileDescriptionA(HENHMETAFILE, UINT, LPSTR);
            WINBOOL GetTextMetricsA(HDC, LPTEXTMETRIC);
            int StartDocA(HDC, PDOCINFO);
            int GetObjectA(HGDIOBJ, int, LPVOID);
            WINBOOL TextOutA(HDC, int, int, LPCSTR, int);
            WINBOOL ExtTextOutA(HDC, int, int, UINT, LPRECT, LPCSTR, UINT, LPINT);
            WINBOOL PolyTextOutA(HDC, PPOLYTEXT, int);
            int GetTextFaceA(HDC, int, LPSTR);
            DWORD GetKerningPairsA(HDC, DWORD, LPKERNINGPAIR);
            HCOLORSPACE CreateColorSpaceA(LPLOGCOLORSPACE);
            WINBOOL GetLogColorSpaceA(HCOLORSPACE, LPLOGCOLORSPACE, DWORD);
            WINBOOL GetICMProfileA(HDC, DWORD, LPSTR);
            WINBOOL SetICMProfileA(HDC, LPSTR);
            WINBOOL UpdateICMRegKeyA(DWORD, DWORD, LPSTR, UINT);
            int EnumICMProfilesA(HDC, ICMENUMPROC, LPARAM);
            int PropertySheetA(LPCPROPSHEETHEADER);
            HIMAGELIST ImageList_LoadImageA(HINST, LPCSTR, int, int, COLORREF, UINT, UINT);
            HWND CreateStatusWindowA(LONG, LPCSTR, HWND, UINT);
            void DrawStatusTextA(HDC, LPRECT, LPCSTR);
            WINBOOL GetOpenFileNameA(LPOPENFILENAME);
            WINBOOL GetSaveFileNameA(LPOPENFILENAME);
            int GetFileTitleA(LPCSTR, LPSTR, ushort);
            WINBOOL ChooseColorA(LPCHOOSECOLOR);
            HWND FindTextA(LPFINDREPLACE);
            HWND ReplaceTextA(LPFINDREPLACE);
            WINBOOL ChooseFontA(LPCHOOSEFONTA);
            WINBOOL PrintDlgA(LPPRINTDLGA);
            WINBOOL PageSetupDlgA(LPPAGESETUPDLG);
            WINBOOL CreateProcessA(LPCSTR, LPSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, WINBOOL, DWORD, LPVOID, LPCSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION);
            void GetStartupInfoA(LPSTARTUPINFO);
            HANDLE FindFirstFileA(LPCSTR, LPWIN32_FIND_DATA);
            WINBOOL FindNextFileA(HANDLE, LPWIN32_FIND_DATA);
            WINBOOL GetVersionExA(LPOSVERSIONINFO);
            HDC CreateDCA(LPCSTR, LPCSTR, LPCSTR, PDEVMODE);
            DWORD VerInstallFileA(DWORD, LPSTR, LPSTR, LPSTR, LPSTR, LPSTR, LPSTR, PUINT);
            DWORD GetFileVersionInfoSizeA(LPSTR, LPDWORD);
            WINBOOL GetFileVersionInfoA(LPSTR, DWORD, DWORD, LPVOID);
            DWORD VerLanguageNameA(DWORD, LPSTR, DWORD);
            WINBOOL VerQueryValueA(LPVOID, LPSTR, LPVOID, PUINT);
            DWORD VerFindFileA(DWORD, LPSTR, LPSTR, LPSTR, LPSTR, PUINT, LPSTR, PUINT);
            LONG RegConnectRegistryA(LPSTR, HKEY, PHKEY);
            LONG RegCreateKeyA(HKEY, LPCSTR, PHKEY);
            LONG RegCreateKeyExA(HKEY, LPCSTR, DWORD, LPSTR, DWORD, REGSAM, LPSECURITY_ATTRIBUTES, PHKEY, LPDWORD);
            LONG RegDeleteKeyA(HKEY, LPCSTR);
            LONG RegDeleteValueA(HKEY, LPCSTR);
            LONG RegEnumKeyA(HKEY, DWORD, LPSTR, DWORD);
            LONG RegEnumKeyExA(HKEY, DWORD, LPSTR, LPDWORD, LPDWORD, LPSTR, LPDWORD, PFILETIME);
            LONG RegEnumValueA(HKEY, DWORD, LPSTR, LPDWORD, LPDWORD, LPDWORD, LPBYTE, LPDWORD);
            LONG RegLoadKeyA(HKEY, LPCSTR, LPCSTR);
            LONG RegOpenKeyA(HKEY, LPCSTR, PHKEY);
            LONG RegOpenKeyExA(HKEY, LPCSTR, DWORD, REGSAM, PHKEY);
            LONG RegQueryInfoKeyA(HKEY, LPSTR, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, PFILETIME);
            LONG RegQueryValueA(HKEY, LPCSTR, LPSTR, PLONG);
            LONG RegQueryMultipleValuesA(HKEY, PVALENT, DWORD, LPSTR, LPDWORD);
            LONG RegQueryValueExA(HKEY, LPCSTR, LPDWORD, LPDWORD, LPBYTE, LPDWORD);
            LONG RegReplaceKeyA(HKEY, LPCSTR, LPCSTR, LPCSTR);
            LONG RegRestoreKeyA(HKEY, LPCSTR, DWORD);
            LONG RegSaveKeyA(HKEY, LPCSTR, LPSECURITY_ATTRIBUTES);
            LONG RegSetValueA(HKEY, LPCSTR, DWORD, LPCSTR, DWORD);
            LONG RegSetValueExA(HKEY, LPCSTR, DWORD, DWORD, LPBYTE, DWORD);
            LONG RegUnLoadKeyA(HKEY, LPCSTR);
            WINBOOL InitiateSystemShutdownA(LPSTR, LPSTR, DWORD, WINBOOL, WINBOOL);
            WINBOOL AbortSystemShutdownA(LPSTR);
            int CompareStringA(LCID, DWORD, LPCSTR, int, LPCSTR, int);
            int LCMapStringA(LCID, DWORD, LPCSTR, int, LPSTR, int);
            int GetLocaleInfoA(LCID, LCTYPE, LPSTR, int);
            WINBOOL SetLocaleInfoA(LCID, LCTYPE, LPCSTR);
            int GetTimeFormatA(LCID, DWORD, LPSYSTEMTIME, LPCSTR, LPSTR, int);
            int GetDateFormatA(LCID, DWORD, LPSYSTEMTIME, LPCSTR, LPSTR, int);
            int GetNumberFormatA(LCID, DWORD, LPCSTR, PNUMBERFMT, LPSTR, int);
            int GetCurrencyFormatA(LCID, DWORD, LPCSTR, PCURRENCYFMT, LPSTR, int);
            WINBOOL EnumCalendarInfoA(CALINFO_ENUMPROC, LCID, CALID, CALTYPE);
            WINBOOL EnumTimeFormatsA(TIMEFMT_ENUMPROC, LCID, DWORD);
            WINBOOL EnumDateFormatsA(DATEFMT_ENUMPROC, LCID, DWORD);
            WINBOOL GetStringTypeExA(LCID, DWORD, LPCSTR, int, LPWORD);
            WINBOOL GetStringTypeA(LCID, DWORD, LPCSTR, int, LPWORD);
            int FoldStringA(DWORD, LPCSTR, int, LPSTR, int);
            WINBOOL EnumSystemLocalesA(LOCALE_ENUMPROC, DWORD);
            WINBOOL EnumSystemCodePagesA(CODEPAGE_ENUMPROC, DWORD);
            WINBOOL PeekConsoleInputA(HANDLE, PINPUTRECORD, DWORD, LPDWORD);
            WINBOOL ReadConsoleInputA(HANDLE, PINPUTRECORD, DWORD, LPDWORD);
            WINBOOL WriteConsoleInputA(HANDLE, PINPUTRECORD, DWORD, LPDWORD);
            WINBOOL ReadConsoleOutputA(HANDLE, PCHAR_INFO, COORD, COORD, PSMALL_RECT);
            WINBOOL WriteConsoleOutputA(HANDLE, PCHAR_INFO, COORD, COORD, PSMALL_RECT);
            WINBOOL ReadConsoleOutputCharacterA(HANDLE, LPSTR, DWORD, COORD, LPDWORD);
            WINBOOL WriteConsoleOutputCharacterA(HANDLE, LPCSTR, DWORD, COORD, LPDWORD);
            WINBOOL FillConsoleOutputCharacterA(HANDLE, char, DWORD, COORD, LPDWORD);
            WINBOOL ScrollConsoleScreenBufferA(HANDLE, PSMALL_RECT, PSMALL_RECT, COORD, PCHAR_INFO);
            DWORD GetConsoleTitleA(LPSTR, DWORD);
            WINBOOL SetConsoleTitleA(LPCSTR);
            WINBOOL ReadConsoleA(HANDLE, LPVOID, DWORD, LPDWORD, LPVOID);
            WINBOOL WriteConsoleA(HANDLE, POINTER, DWORD, LPDWORD, LPVOID);
            DWORD WNetAddConnectionA(LPCSTR, LPCSTR, LPCSTR);
            DWORD WNetAddConnection2A(LPNETRESOURCE, LPCSTR, LPCSTR, DWORD);
            DWORD WNetAddConnection3A(HWND, LPNETRESOURCE, LPCSTR, LPCSTR, DWORD);
            DWORD WNetCancelConnectionA(LPCSTR, WINBOOL);
            DWORD WNetCancelConnection2A(LPCSTR, DWORD, WINBOOL);
            DWORD WNetGetConnectionA(LPCSTR, LPSTR, LPDWORD);
            DWORD WNetUseConnectionA(HWND, LPNETRESOURCE, LPCSTR, LPCSTR, DWORD, LPSTR, LPDWORD, LPDWORD);
            DWORD WNetSetConnectionA(LPCSTR, DWORD, LPVOID);
            DWORD WNetConnectionDialog1A(LPCONNECTDLGSTRUCT);
            DWORD WNetDisconnectDialog1A(LPDISCDLGSTRUCT);
            DWORD WNetOpenEnumA(DWORD, DWORD, DWORD, LPNETRESOURCE, LPHANDLE);
            DWORD WNetEnumResourceA(HANDLE, LPDWORD, LPVOID, LPDWORD);
            DWORD WNetGetUniversalNameA(LPCSTR, DWORD, LPVOID, LPDWORD);
            DWORD WNetGetUserA(LPCSTR, LPSTR, LPDWORD);
            DWORD WNetGetProviderNameA(DWORD, LPSTR, LPDWORD);
            DWORD WNetGetNetworkInformationA(LPCSTR, LPNETINFOSTRUCT);
            DWORD WNetGetLastErrorA(LPDWORD, LPSTR, DWORD, LPSTR, DWORD);
            DWORD MultinetGetConnectionPerformanceA(LPNETRESOURCE, LPNETCONNECTINFOSTRUCT);
            WINBOOL ChangeServiceConfigA(SC_HANDLE, DWORD, DWORD, DWORD, LPCSTR, LPCSTR, LPDWORD, LPCSTR, LPCSTR, LPCSTR, LPCSTR);
            SC_HANDLE CreateServiceA(SC_HANDLE, LPCSTR, LPCSTR, DWORD, DWORD, DWORD, DWORD, LPCSTR, LPCSTR, LPDWORD, LPCSTR, LPCSTR, LPCSTR);
            WINBOOL EnumDependentServicesA(SC_HANDLE, DWORD, LPENUM_SERVICE_STATUS, DWORD, LPDWORD, LPDWORD);
            WINBOOL EnumServicesStatusA(SC_HANDLE, DWORD, DWORD, LPENUM_SERVICE_STATUS, DWORD, LPDWORD, LPDWORD, LPDWORD);
            WINBOOL GetServiceKeyNameA(SC_HANDLE, LPCSTR, LPSTR, LPDWORD);
            WINBOOL GetServiceDisplayNameA(SC_HANDLE, LPCSTR, LPSTR, LPDWORD);
            SC_HANDLE OpenSCManagerA(LPCSTR, LPCSTR, DWORD);
            SC_HANDLE OpenServiceA(SC_HANDLE, LPCSTR, DWORD);
            WINBOOL QueryServiceConfigA(SC_HANDLE, LPQUERY_SERVICE_CONFIG, DWORD, LPDWORD);
            WINBOOL QueryServiceLockStatusA(SC_HANDLE, LPQUERY_SERVICE_LOCK_STATUS, DWORD, LPDWORD);
            SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerA(LPCSTR, LPHANDLER_FUNCTION);
            WINBOOL StartServiceCtrlDispatcherA(LPSERVICE_TABLE_ENTRY);
            WINBOOL StartServiceA(SC_HANDLE, DWORD, LPCSTR);
            uint DragQueryFileA(HDROP, uint, PCHAR, uint);
            HICON ExtractAssociatedIconA(HINST, PCHAR, LPWORD);
            HICON ExtractIconA(HINST, PCHAR, uint);
            HINST FindExecutableA(PCHAR, PCHAR, PCHAR);
            int ShellAboutA(HWND, PCHAR, PCHAR, HICON);
            HINST ShellExecuteA(HWND, PCHAR, PCHAR, PCHAR, PCHAR, int);
            HSZ DdeCreateStringHandleA(DWORD, PCHAR, int);
            UINT DdeInitializeA(LPDWORD, PFNCALLBACK, DWORD, DWORD);
            DWORD DdeQueryStringA(DWORD, HSZ, PCHAR, DWORD, int);
            WINBOOL LogonUserA(LPSTR, LPSTR, LPSTR, DWORD, DWORD, PHANDLE);
            WINBOOL CreateProcessAsUserA(HANDLE, LPCTSTR, LPTSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, WINBOOL, DWORD, LPVOID, LPCTSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION);
            WINBOOL GetBinaryTypeW(LPCWSTR, LPDWORD);
            DWORD GetShortPathNameW(LPCWSTR, LPWSTR, DWORD);
            LPWSTR GetEnvironmentStringsW();
            WINBOOL FreeEnvironmentStringsW(LPWSTR);
            DWORD FormatMessageW(DWORD, LPCVOID, DWORD, DWORD, LPWSTR, DWORD, VA_LIST*);
            HANDLE CreateMailslotW(LPCWSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
            int lstrcmpW(LPCWSTR, LPCWSTR);
            int lstrcmpiW(LPCWSTR, LPCWSTR);
            LPWSTR lstrcpynW(LPWSTR, LPCWSTR, int);
            LPWSTR lstrcpyW(LPWSTR, LPCWSTR);
            LPWSTR lstrcatW(LPWSTR, LPCWSTR);
            int lstrlenW(LPCWSTR);
            HANDLE CreateMutexW(LPSECURITY_ATTRIBUTES, WINBOOL, LPCWSTR);
            HANDLE OpenMutexW(DWORD, WINBOOL, LPCWSTR);
            HANDLE CreateEventW(LPSECURITY_ATTRIBUTES, WINBOOL, WINBOOL, LPCWSTR);
            HANDLE OpenEventW(DWORD, WINBOOL, LPCWSTR);
            HANDLE CreateSemaphoreW(LPSECURITY_ATTRIBUTES, LONG, LONG, LPCWSTR);
            HANDLE OpenSemaphoreW(DWORD, WINBOOL, LPCWSTR);
            HANDLE CreateFileMappingW(HANDLE, LPSECURITY_ATTRIBUTES, DWORD, DWORD, DWORD, LPCWSTR);
            HANDLE OpenFileMappingW(DWORD, WINBOOL, LPCWSTR);
            DWORD GetLogicalDriveStringsW(DWORD, LPWSTR);
            HINST LoadLibraryW(LPCWSTR);
            HINST LoadLibraryExW(LPCWSTR, HANDLE, DWORD);
            DWORD GetModuleFileNameW(HINST, LPWSTR, DWORD);
            HMODULE GetModuleHandleW(LPCWSTR);
            void FatalAppExitW(UINT);
            LPWSTR GetCommandLineW();
            DWORD GetEnvironmentVariableW(LPCWSTR, LPWSTR, DWORD);
            WINBOOL SetEnvironmentVariableW(LPCWSTR, LPCWSTR);
            DWORD ExpandEnvironmentStringsW(LPCWSTR, LPWSTR, DWORD);
            void OutputDebugStringW(LPCWSTR);
            HRSRC FindResourceW(HINST, LPCWSTR, LPCWSTR);
            HRSRC FindResourceExW(HINST, LPCWSTR, LPCWSTR, ushort);
            WINBOOL EnumResourceTypesW(HINST, ENUMRESTYPEPROC, LONG);
            WINBOOL EnumResourceNamesW(HINST, LPCWSTR, ENUMRESNAMEPROC, LONG);
            WINBOOL EnumResourceLanguagesW(HINST, LPCWSTR, LPCWSTR, ENUMRESLANGPROC, LONG);
            HANDLE BeginUpdateResourceW(LPCWSTR, WINBOOL);
            WINBOOL UpdateResourceW(HANDLE, LPCWSTR, LPCWSTR, ushort, LPVOID, DWORD);
            WINBOOL EndUpdateResourceW(HANDLE, WINBOOL);
            ATOM GlobalAddAtomW(LPCWSTR);
            ATOM GlobalFindAtomW(LPCWSTR);
            UINT GlobalGetAtomNameW(ATOM, LPWSTR, int);
            ATOM AddAtomW(LPCWSTR);
            ATOM FindAtomW(LPCWSTR);
            UINT GetAtomNameW(ATOM, LPWSTR, int);
            UINT GetProfileIntW(LPCWSTR, LPCWSTR, INT);
            DWORD GetProfileStringW(LPCWSTR, LPCWSTR, LPCWSTR, LPWSTR, DWORD);
            WINBOOL WriteProfileStringW(LPCWSTR, LPCWSTR, LPCWSTR);
            DWORD GetProfileSectionW(LPCWSTR, LPWSTR, DWORD);
            WINBOOL WriteProfileSectionW(LPCWSTR, LPCWSTR);
            UINT GetPrivateProfileIntW(LPCWSTR, LPCWSTR, INT, LPCWSTR);
            DWORD GetPrivateProfileStringW(LPCWSTR, LPCWSTR, LPCWSTR, LPWSTR, DWORD, LPCWSTR);
            WINBOOL WritePrivateProfileStringW(LPCWSTR, LPCWSTR, LPCWSTR, LPCWSTR);
            DWORD GetPrivateProfileSectionW(LPCWSTR, LPWSTR, DWORD, LPCWSTR);
            WINBOOL WritePrivateProfileSectionW(LPCWSTR, LPCWSTR, LPCWSTR);
            UINT GetDriveTypeW(LPCWSTR);
            UINT GetSystemDirectoryW(LPWSTR, UINT);
            DWORD GetTempPathW(DWORD, LPWSTR);
            UINT GetTempFileNameW(LPCWSTR, LPCWSTR, UINT, LPWSTR);
            UINT GetWindowsDirectoryW(LPWSTR, UINT);
            WINBOOL SetCurrentDirectoryW(LPCWSTR);
            DWORD GetCurrentDirectoryW(DWORD, LPWSTR);
            WINBOOL GetDiskFreeSpaceW(LPCWSTR, LPDWORD, LPDWORD, LPDWORD, LPDWORD);
            WINBOOL CreateDirectoryW(LPCWSTR, LPSECURITY_ATTRIBUTES);
            WINBOOL CreateDirectoryExW(LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
            WINBOOL RemoveDirectoryW(LPCWSTR);
            DWORD GetFullPathNameW(LPCWSTR, DWORD, LPWSTR, LPWSTR*);
            WINBOOL DefineDosDeviceW(DWORD, LPCWSTR, LPCWSTR);
            DWORD QueryDosDeviceW(LPCWSTR, LPWSTR, DWORD);
            HANDLE CreateFileW(LPCWSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES, DWORD, DWORD, HANDLE);
            WINBOOL SetFileAttributesW(LPCWSTR, DWORD);
            DWORD GetFileAttributesW(LPCWSTR);
            BOOL GetFileAttributesExW(LPCWSTR, DWORD, WIN32_FILE_ATTRIBUTE_DATA*);
            DWORD GetCompressedFileSizeW(LPCWSTR, LPDWORD);
            WINBOOL DeleteFileW(LPCWSTR);
            DWORD SearchPathW(LPCWSTR, LPCWSTR, LPCWSTR, DWORD, LPWSTR, LPWSTR);
            WINBOOL CopyFileW(LPCWSTR, LPCWSTR, WINBOOL);
            WINBOOL MoveFileW(LPCWSTR, LPCWSTR);
            WINBOOL MoveFileExW(LPCWSTR, LPCWSTR, DWORD);
            HANDLE CreateNamedPipeW(LPCWSTR, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
            WINBOOL GetNamedPipeHandleStateW(HANDLE, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPWSTR, DWORD);
            WINBOOL CallNamedPipeW(LPCWSTR, LPVOID, DWORD, LPVOID, DWORD, LPDWORD, DWORD);
            WINBOOL WaitNamedPipeW(LPCWSTR, DWORD);
            WINBOOL SetVolumeLabelW(LPCWSTR, LPCWSTR);
            WINBOOL GetVolumeInformationW(LPCWSTR, LPWSTR, DWORD, LPDWORD, LPDWORD, LPDWORD, LPWSTR, DWORD);
            WINBOOL ClearEventLogW(HANDLE, LPCWSTR);
            WINBOOL BackupEventLogW(HANDLE, LPCWSTR);
            HANDLE OpenEventLogW(LPCWSTR, LPCWSTR);
            HANDLE RegisterEventSourceW(LPCWSTR, LPCWSTR);
            HANDLE OpenBackupEventLogW(LPCWSTR, LPCWSTR);
            WINBOOL ReadEventLogW(HANDLE, DWORD, DWORD, LPVOID, DWORD, LPDWORD, LPDWORD);
            WINBOOL ReportEventW(HANDLE, ushort, ushort, DWORD, PSID, ushort, DWORD, LPCWSTR*, LPVOID);
            WINBOOL AccessCheckAndAuditAlarmW(LPCWSTR, LPVOID, LPWSTR, LPWSTR, PSECURITY_DESCRIPTOR, DWORD, PGENERIC_MAPPING, WINBOOL, LPDWORD, LPBOOL, LPBOOL);
            WINBOOL ObjectOpenAuditAlarmW(LPCWSTR, LPVOID, LPWSTR, LPWSTR, PSECURITY_DESCRIPTOR, HANDLE, DWORD, DWORD, PPRIVILEGE_SET, WINBOOL, WINBOOL, LPBOOL);
            WINBOOL ObjectPrivilegeAuditAlarmW(LPCWSTR, LPVOID, HANDLE, DWORD, PPRIVILEGE_SET, WINBOOL);
            WINBOOL ObjectCloseAuditAlarmW(LPCWSTR, LPVOID, WINBOOL);
            WINBOOL PrivilegedServiceAuditAlarmW(LPCWSTR, LPCWSTR, HANDLE, PPRIVILEGE_SET, WINBOOL);
            WINBOOL SetFileSecurityW(LPCWSTR, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR);
            WINBOOL GetFileSecurityW(LPCWSTR, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR, DWORD, LPDWORD);
            HANDLE FindFirstChangeNotificationW(LPCWSTR, WINBOOL, DWORD);
            WINBOOL IsBadStringPtrW(LPCWSTR, UINT);
            WINBOOL LookupAccountSidW(LPCWSTR, PSID, LPWSTR, LPDWORD, LPWSTR, LPDWORD, PSID_NAME_USE);
            WINBOOL LookupAccountNameW(LPCWSTR, LPCWSTR, PSID, LPDWORD, LPWSTR, LPDWORD, PSID_NAME_USE);
            WINBOOL LookupPrivilegeValueW(LPCWSTR, LPCWSTR, PLUID);
            WINBOOL LookupPrivilegeNameW(LPCWSTR, PLUID, LPWSTR, LPDWORD);
            WINBOOL LookupPrivilegeDisplayNameW(LPCWSTR, LPCWSTR, LPWSTR, LPDWORD, LPDWORD);
            WINBOOL BuildCommDCBW(LPCWSTR, LPDCB);
            WINBOOL BuildCommDCBAndTimeoutsW(LPCWSTR, LPDCB, LPCOMMTIMEOUTS);
            WINBOOL CommConfigDialogW(LPCWSTR, HWND, LPCOMMCONFIG);
            WINBOOL GetDefaultCommConfigW(LPCWSTR, LPCOMMCONFIG, LPDWORD);
            WINBOOL SetDefaultCommConfigW(LPCWSTR, LPCOMMCONFIG, DWORD);
            WINBOOL GetComputerNameW(LPWSTR, LPDWORD);
            WINBOOL SetComputerNameW(LPCWSTR);
            WINBOOL GetUserNameW(LPWSTR, LPDWORD);
            int wvsprintfW(LPWSTR, LPCWSTR, VA_LIST*);
            HKL LoadKeyboardLayoutW(LPCWSTR, UINT);
            WINBOOL GetKeyboardLayoutNameW(LPWSTR);
            HDESK CreateDesktopW(LPWSTR, LPWSTR, LPDEVMODE, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
            HDESK OpenDesktopW(LPWSTR, DWORD, WINBOOL, DWORD);
            WINBOOL EnumDesktopsW(HWINSTA, DESKTOPENUMPROC, LPARAM);
            HWINSTA CreateWindowStationW(LPWSTR, DWORD, DWORD, LPSECURITY_ATTRIBUTES);
            HWINSTA OpenWindowStationW(LPWSTR, WINBOOL, DWORD);
            WINBOOL EnumWindowStationsW(ENUMWINDOWSTATIONPROC, LPARAM);
            WINBOOL GetUserObjectInformationW(HANDLE, int, PVOID, DWORD, LPDWORD);
            WINBOOL SetUserObjectInformationW(HANDLE, int, PVOID, DWORD);
            UINT RegisterWindowMessageW(LPCWSTR);
            WINBOOL GetMessageW(LPMSG, HWND, UINT, UINT);
            LONG DispatchMessageW(LPMSG);
            WINBOOL PeekMessageW(LPMSG, HWND, UINT, UINT, UINT);
            LRESULT SendMessageW(HWND, UINT, WPARAM, LPARAM);
            LRESULT SendMessageW(HWND, UINT, WPARAM, void*);
            LRESULT SendMessageW(HWND, UINT, void*, LPARAM);
            LRESULT SendMessageW(HWND, UINT, void*, void*);
            LRESULT SendMessageTimeoutW(HWND, UINT, WPARAM, LPARAM, UINT, UINT, LPDWORD);
            WINBOOL SendNotifyMessageW(HWND, UINT, WPARAM, LPARAM);
            WINBOOL SendMessageCallbackW(HWND, UINT, WPARAM, LPARAM, SENDASYNCPROC, DWORD);
            WINBOOL PostMessageW(HWND, UINT, WPARAM, LPARAM);
            WINBOOL PostThreadMessageW(DWORD, UINT, WPARAM, LPARAM);
            LRESULT DefWindowProcW(HWND, UINT, WPARAM, LPARAM);
            LRESULT CallWindowProcW(WNDPROC, HWND, UINT, WPARAM, LPARAM);
            ATOM RegisterClassW(LPWNDCLASSW);
            WINBOOL UnregisterClassW(LPCWSTR, HINST);
            WINBOOL GetClassInfoW(HINST, LPCWSTR, LPWNDCLASS);
            ATOM RegisterClassExW(LPWNDCLASSEX);
            WINBOOL GetClassInfoExW(HINST, LPCWSTR, LPWNDCLASSEX);
            HWND CreateWindowExW(DWORD, LPCWSTR, LPCWSTR, DWORD, int, int, int, int, HWND, HMENU, HINST, LPVOID);
            HWND CreateDialogParamW(HINST, LPCWSTR, HWND, DLGPROC, LPARAM);
            HWND CreateDialogIndirectParamW(HINST, LPCDLGTEMPLATE, HWND, DLGPROC, LPARAM);
            int DialogBoxParamW(HINST, LPCWSTR, HWND, DLGPROC, LPARAM);
            int DialogBoxIndirectParamW(HINST, LPCDLGTEMPLATE, HWND, DLGPROC, LPARAM);
            WINBOOL SetDlgItemTextW(HWND, int, LPCWSTR);
            UINT GetDlgItemTextW(HWND, int, LPWSTR, int);
            LONG SendDlgItemMessageW(HWND, int, UINT, WPARAM, LPARAM);
            LRESULT DefDlgProcW(HWND, UINT, WPARAM, LPARAM);
            WINBOOL CallMsgFilterW(LPMSG, int);
            UINT RegisterClipboardFormatW(LPCWSTR);
            int GetClipboardFormatNameW(UINT, LPWSTR, int);
            WINBOOL CharToOemW(LPCWSTR, LPSTR);
            WINBOOL OemToCharW(LPCSTR, LPWSTR);
            WINBOOL CharToOemBuffW(LPCWSTR, LPSTR, DWORD);
            WINBOOL OemToCharBuffW(LPCSTR, LPWSTR, DWORD);
            LPWSTR CharUpperW(LPWSTR);
            DWORD CharUpperBuffW(LPWSTR, DWORD);
            LPWSTR CharLowerW(LPWSTR);
            DWORD CharLowerBuffW(LPWSTR, DWORD);
            LPWSTR CharNextW(LPCWSTR);
            LPWSTR CharPrevW(LPCWSTR, LPCWSTR);
            WINBOOL IsCharAlphaW(WCHAR);
            WINBOOL IsCharAlphaNumericW(WCHAR);
            WINBOOL IsCharUpperW(WCHAR);
            WINBOOL IsCharLowerW(WCHAR);
            int GetKeyNameTextW(LONG, LPWSTR, int);
            SHORT VkKeyScanW(WCHAR);
            SHORT VkKeyScanExW(WCHAR, HKL);
            UINT MapVirtualKeyW(UINT, UINT);
            UINT MapVirtualKeyExW(UINT, UINT, HKL);
            HACCEL LoadAcceleratorsW(HINST, LPCWSTR);
            HACCEL CreateAcceleratorTableW(LPACCEL, int);
            int CopyAcceleratorTableW(HACCEL, LPACCEL, int);
            int TranslateAcceleratorW(HWND, HACCEL, LPMSG);
            HMENU LoadMenuW(HINST, LPCWSTR);
            HMENU LoadMenuIndirectW(LPMENUTEMPLATE);
            WINBOOL ChangeMenuW(HMENU, UINT, LPCWSTR, UINT, UINT);
            int GetMenuStringW(HMENU, UINT, LPWSTR, int, UINT);
            WINBOOL InsertMenuW(HMENU, UINT, UINT, UINT, LPCWSTR);
            WINBOOL AppendMenuW(HMENU, UINT, UINT, LPCWSTR);
            WINBOOL ModifyMenuW(HMENU, UINT, UINT, UINT, LPCWSTR);
            WINBOOL InsertMenuItemW(HMENU, UINT, WINBOOL, LPCMENUITEMINFO);
            WINBOOL GetMenuItemInfoW(HMENU, UINT, WINBOOL, LPMENUITEMINFO);
            WINBOOL SetMenuItemInfoW(HMENU, UINT, WINBOOL, LPCMENUITEMINFO);
            int DrawTextW(HDC, LPCWSTR, int, LPRECT, UINT);
            int DrawTextExW(HDC, LPWSTR, int, LPRECT, UINT, LPDRAWTEXTPARAMS);
            WINBOOL GrayStringW(HDC, HBRUSH, GRAYSTRINGPROC, LPARAM, int, int, int, int, int);
            WINBOOL DrawStateW(HDC, HBRUSH, DRAWSTATEPROC, LPARAM, WPARAM, int, int, int, int, UINT);
            LONG TabbedTextOutW(HDC, int, int, LPCWSTR, int, int, LPINT, int);
            DWORD GetTabbedTextExtentW(HDC, LPCWSTR, int, int, LPINT);
            WINBOOL SetPropW(HWND, LPCWSTR, HANDLE);
            HANDLE GetPropW(HWND, LPCWSTR);
            HANDLE RemovePropW(HWND, LPCWSTR);
            int EnumPropsExW(HWND, PROPENUMPROCEX, LPARAM);
            int EnumPropsW(HWND, PROPENUMPROC);
            WINBOOL SetWindowTextW(HWND, LPCWSTR);
            int GetWindowTextW(HWND, LPWSTR, int);
            int GetWindowTextLengthW(HWND);
            int MessageBoxW(HWND, LPCWSTR, LPCWSTR, UINT);
            int MessageBoxExW(HWND, LPCWSTR, LPCWSTR, UINT, ushort);
            int MessageBoxIndirectW(LPMSGBOXPARAMS);
            LONG GetWindowLongW(HWND, int);
            LONG SetWindowLongW(HWND, int, LONG);
            DWORD GetClassLongW(HWND, int);
            DWORD SetClassLongW(HWND, int, LONG);
            HWND FindWindowW(LPCWSTR, LPCWSTR);
            HWND FindWindowExW(HWND, HWND, LPCWSTR, LPCWSTR);
            int GetClassNameW(HWND, LPWSTR, int);
            HHOOK SetWindowsHookExW(int, HOOKPROC, HINST, DWORD);
            HBITMAP LoadBitmapW(HINST, LPCWSTR);
            HCURSOR LoadCursorW(HINST, LPCWSTR);
            HCURSOR LoadCursorFromFileW(LPCWSTR);
            HICON LoadIconW(HINST, LPCWSTR);
            HANDLE LoadImageW(HINST, LPCWSTR, UINT, int, int, UINT);
            int LoadStringW(HINST, UINT, LPWSTR, int);
            WINBOOL IsDialogMessageW(HWND, LPMSG);
            int DlgDirListW(HWND, LPWSTR, int, int, UINT);
            WINBOOL DlgDirSelectExW(HWND, LPWSTR, int, int);
            int DlgDirListComboBoxW(HWND, LPWSTR, int, int, UINT);
            WINBOOL DlgDirSelectComboBoxExW(HWND, LPWSTR, int, int);
            LRESULT DefFrameProcW(HWND, HWND, UINT, WPARAM, LPARAM);
            LRESULT DefMDIChildProcW(HWND, UINT, WPARAM, LPARAM);
            HWND CreateMDIWindowW(LPWSTR, LPWSTR, DWORD, int, int, int, int, HWND, HINST, LPARAM);
            WINBOOL WinHelpW(HWND, LPCWSTR, UINT, DWORD);
            LONG ChangeDisplaySettingsW(LPDEVMODE, DWORD);
            WINBOOL EnumDisplaySettingsW(LPCWSTR, DWORD, LPDEVMODE);
            WINBOOL SystemParametersInfoW(UINT, UINT, PVOID, UINT);
            int AddFontResourceW(LPCWSTR);
            HMETAFILE CopyMetaFileW(HMETAFILE, LPCWSTR);
            HFONT CreateFontIndirectW(PLOGFONT);
            HFONT CreateFontW(int, int, int, int, int, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, LPCWSTR);
            HDC CreateICW(LPCWSTR, LPCWSTR, LPCWSTR, LPDEVMODE);
            HDC CreateMetaFileW(LPCWSTR);
            WINBOOL CreateScalableFontResourceW(DWORD, LPCWSTR, LPCWSTR, LPCWSTR);
            int EnumFontFamiliesExW(HDC, LPLOGFONT, FONTENUMEXPROC, LPARAM, DWORD);
            int EnumFontFamiliesW(HDC, LPCWSTR, FONTENUMPROC, LPARAM);
            int EnumFontsW(HDC, LPCWSTR, ENUMFONTSPROC, LPARAM);
            WINBOOL GetCharWidthW(HDC, UINT, UINT, LPINT);
            WINBOOL GetCharWidth32W(HDC, UINT, UINT, LPINT);
            WINBOOL GetCharWidthFloatW(HDC, UINT, UINT, PFLOAT);
            WINBOOL GetCharABCWidthsW(HDC, UINT, UINT, LPABC);
            WINBOOL GetCharABCWidthsFloatW(HDC, UINT, UINT, LPABCFLOAT);
            DWORD GetGlyphOutlineW(HDC, UINT, UINT, LPGLYPHMETRICS, DWORD, LPVOID, PMAT2);
            HMETAFILE GetMetaFileW(LPCWSTR);
            UINT GetOutlineTextMetricsW(HDC, UINT, LPOUTLINETEXTMETRIC);
            WINBOOL GetTextExtentPointW(HDC, LPCWSTR, int, LPSIZE);
            WINBOOL GetTextExtentPoint32W(HDC, LPCWSTR, int, LPSIZE);
            WINBOOL GetTextExtentExPointW(HDC, LPCWSTR, int, int, LPINT, LPINT, LPSIZE);
            DWORD GetCharacterPlacementW(HDC, LPCWSTR, int, int, LPGCP_RESULTS, DWORD);
            HDC ResetDCW(HDC, LPDEVMODE);
            WINBOOL RemoveFontResourceW(LPCWSTR);
            HENHMETAFILE CopyEnhMetaFileW(HENHMETAFILE, LPCWSTR);
            HDC CreateEnhMetaFileW(HDC, LPCWSTR, LPRECT, LPCWSTR);
            HENHMETAFILE GetEnhMetaFileW(LPCWSTR);
            UINT GetEnhMetaFileDescriptionW(HENHMETAFILE, UINT, LPWSTR);
            WINBOOL GetTextMetricsW(HDC, LPTEXTMETRIC);
            int StartDocW(HDC, PDOCINFO);
            int GetObjectW(HGDIOBJ, int, LPVOID);
            WINBOOL TextOutW(HDC, int, int, LPCWSTR, int);
            WINBOOL ExtTextOutW(HDC, int, int, UINT, LPRECT, LPCWSTR, UINT, LPINT);
            WINBOOL PolyTextOutW(HDC, PPOLYTEXT, int);
            int GetTextFaceW(HDC, int, LPWSTR);
            DWORD GetKerningPairsW(HDC, DWORD, LPKERNINGPAIR);
            WINBOOL GetLogColorSpaceW(HCOLORSPACE, LPLOGCOLORSPACE, DWORD);
            HCOLORSPACE CreateColorSpaceW(LPLOGCOLORSPACE);
            WINBOOL GetICMProfileW(HDC, DWORD, LPWSTR);
            WINBOOL SetICMProfileW(HDC, LPWSTR);
            WINBOOL UpdateICMRegKeyW(DWORD, DWORD, LPWSTR, UINT);
            int EnumICMProfilesW(HDC, ICMENUMPROC, LPARAM);
            HPROPSHEETPAGE CreatePropertySheetPageW(LPCPROPSHEETPAGE);
            int PropertySheetW(LPCPROPSHEETHEADER);
            HIMAGELIST ImageList_LoadImageW(HINST, LPCWSTR, int, int, COLORREF, UINT, UINT);
            HWND CreateStatusWindowW(LONG, LPCWSTR, HWND, UINT);
            void DrawStatusTextW(HDC, LPRECT, LPCWSTR);
            WINBOOL GetOpenFileNameW(LPOPENFILENAME);
            WINBOOL GetSaveFileNameW(LPOPENFILENAME);
            int GetFileTitleW(LPCWSTR, LPWSTR, ushort);
            WINBOOL ChooseColorW(LPCHOOSECOLOR);
            HWND ReplaceTextW(LPFINDREPLACE);
            WINBOOL ChooseFontW(LPCHOOSEFONTW);
            HWND FindTextW(LPFINDREPLACE);
            WINBOOL PrintDlgW(LPPRINTDLGW);
            WINBOOL PageSetupDlgW(LPPAGESETUPDLG);
            WINBOOL CreateProcessW(LPCWSTR, LPWSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, WINBOOL, DWORD, LPVOID, LPCWSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION);
            void GetStartupInfoW(LPSTARTUPINFO);
            HANDLE FindFirstFileW(LPCWSTR, LPWIN32_FIND_DATAW);
            WINBOOL FindNextFileW(HANDLE, LPWIN32_FIND_DATAW);
            WINBOOL GetVersionExW(LPOSVERSIONINFO);
            HDC CreateDCW(LPCWSTR, LPCWSTR, LPCWSTR, PDEVMODE);
            HFONT CreateFontA(int, int, int, int, int, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, LPCSTR);
            DWORD VerInstallFileW(DWORD, LPWSTR, LPWSTR, LPWSTR, LPWSTR, LPWSTR, LPWSTR, PUINT);
            DWORD GetFileVersionInfoSizeW(LPWSTR, LPDWORD);
            WINBOOL GetFileVersionInfoW(LPWSTR, DWORD, DWORD, LPVOID);
            DWORD VerLanguageNameW(DWORD, LPWSTR, DWORD);
            WINBOOL VerQueryValueW(LPVOID, LPWSTR, LPVOID, PUINT);
            DWORD VerFindFileW(DWORD, LPWSTR, LPWSTR, LPWSTR, LPWSTR, PUINT, LPWSTR, PUINT);
            LONG RegSetValueExW(HKEY, LPCWSTR, DWORD, DWORD, LPBYTE, DWORD);
            LONG RegUnLoadKeyW(HKEY, LPCWSTR);
            WINBOOL InitiateSystemShutdownW(LPWSTR, LPWSTR, DWORD, WINBOOL, WINBOOL);
            WINBOOL AbortSystemShutdownW(LPWSTR);
            LONG RegRestoreKeyW(HKEY, LPCWSTR, DWORD);
            LONG RegSaveKeyW(HKEY, LPCWSTR, LPSECURITY_ATTRIBUTES);
            LONG RegSetValueW(HKEY, LPCWSTR, DWORD, LPCWSTR, DWORD);
            LONG RegQueryValueW(HKEY, LPCWSTR, LPWSTR, PLONG);
            LONG RegQueryMultipleValuesW(HKEY, PVALENT, DWORD, LPWSTR, LPDWORD);
            LONG RegQueryValueExW(HKEY, LPCWSTR, LPDWORD, LPDWORD, LPBYTE, LPDWORD);
            LONG RegReplaceKeyW(HKEY, LPCWSTR, LPCWSTR, LPCWSTR);
            LONG RegConnectRegistryW(LPWSTR, HKEY, PHKEY);
            LONG RegCreateKeyW(HKEY, LPCWSTR, PHKEY);
            LONG RegCreateKeyExW(HKEY, LPCWSTR, DWORD, LPWSTR, DWORD, REGSAM, LPSECURITY_ATTRIBUTES, PHKEY, LPDWORD);
            LONG RegDeleteKeyW(HKEY, LPCWSTR);
            LONG RegDeleteValueW(HKEY, LPCWSTR);
            LONG RegEnumKeyW(HKEY, DWORD, LPWSTR, DWORD);
            LONG RegEnumKeyExW(HKEY, DWORD, LPWSTR, LPDWORD, LPDWORD, LPWSTR, LPDWORD, PFILETIME);
            LONG RegEnumValueW(HKEY, DWORD, LPWSTR, LPDWORD, LPDWORD, LPDWORD, LPBYTE, LPDWORD);
            LONG RegLoadKeyW(HKEY, LPCWSTR, LPCWSTR);
            LONG RegOpenKeyW(HKEY, LPCWSTR, PHKEY);
            LONG RegOpenKeyExW(HKEY, LPCWSTR, DWORD, REGSAM, PHKEY);
            LONG RegQueryInfoKeyW(HKEY, LPWSTR, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, LPDWORD, PFILETIME);
            int CompareStringW(LCID, DWORD, LPCWSTR, int, LPCWSTR, int);
            int LCMapStringW(LCID, DWORD, LPCWSTR, int, LPWSTR, int);
            int GetLocaleInfoW(LCID, LCTYPE, LPWSTR, int);
            WINBOOL SetLocaleInfoW(LCID, LCTYPE, LPCWSTR);
            int GetTimeFormatW(LCID, DWORD, LPSYSTEMTIME, LPCWSTR, LPWSTR, int);
            int GetDateFormatW(LCID, DWORD, LPSYSTEMTIME, LPCWSTR, LPWSTR, int);
            int GetNumberFormatW(LCID, DWORD, LPCWSTR, PNUMBERFMT, LPWSTR, int);
            int GetCurrencyFormatW(LCID, DWORD, LPCWSTR, PCURRENCYFMT, LPWSTR, int);
            WINBOOL EnumCalendarInfoW(CALINFO_ENUMPROC, LCID, CALID, CALTYPE);
            WINBOOL EnumTimeFormatsW(TIMEFMT_ENUMPROC, LCID, DWORD);
            WINBOOL EnumDateFormatsW(DATEFMT_ENUMPROC, LCID, DWORD);
            WINBOOL GetStringTypeExW(LCID, DWORD, LPCWSTR, int, LPWORD);
            WINBOOL GetStringTypeW(DWORD, LPCWSTR, int, LPWORD);
            int FoldStringW(DWORD, LPCWSTR, int, LPWSTR, int);
            WINBOOL EnumSystemLocalesW(LOCALE_ENUMPROC, DWORD);
            WINBOOL EnumSystemCodePagesW(CODEPAGE_ENUMPROC, DWORD);
            WINBOOL PeekConsoleInputW(HANDLE, PINPUTRECORD, DWORD, LPDWORD);
            WINBOOL ReadConsoleInputW(HANDLE, PINPUTRECORD, DWORD, LPDWORD);
            WINBOOL WriteConsoleInputW(HANDLE, PINPUTRECORD, DWORD, LPDWORD);
            WINBOOL ReadConsoleOutputW(HANDLE, PCHAR_INFO, COORD, COORD, PSMALL_RECT);
            WINBOOL WriteConsoleOutputW(HANDLE, PCHAR_INFO, COORD, COORD, PSMALL_RECT);
            WINBOOL ReadConsoleOutputCharacterW(HANDLE, LPWSTR, DWORD, COORD, LPDWORD);
            WINBOOL WriteConsoleOutputCharacterW(HANDLE, LPCWSTR, DWORD, COORD, LPDWORD);
            WINBOOL FillConsoleOutputCharacterW(HANDLE, WCHAR, DWORD, COORD, LPDWORD);
            WINBOOL ScrollConsoleScreenBufferW(HANDLE, PSMALL_RECT, PSMALL_RECT, COORD, PCHAR_INFO);
            DWORD GetConsoleTitleW(LPWSTR, DWORD);
            WINBOOL SetConsoleTitleW(LPCWSTR);
            WINBOOL ReadConsoleW(HANDLE, LPVOID, DWORD, LPDWORD, LPVOID);
            WINBOOL WriteConsoleW(HANDLE, POINTER, DWORD, LPDWORD, LPVOID);
            DWORD WNetAddConnectionW(LPCWSTR, LPCWSTR, LPCWSTR);
            DWORD WNetAddConnection2W(LPNETRESOURCE, LPCWSTR, LPCWSTR, DWORD);
            DWORD WNetAddConnection3W(HWND, LPNETRESOURCE, LPCWSTR, LPCWSTR, DWORD);
            DWORD WNetCancelConnectionW(LPCWSTR, WINBOOL);
            DWORD WNetCancelConnection2W(LPCWSTR, DWORD, WINBOOL);
            DWORD WNetGetConnectionW(LPCWSTR, LPWSTR, LPDWORD);
            DWORD WNetUseConnectionW(HWND, LPNETRESOURCE, LPCWSTR, LPCWSTR, DWORD, LPWSTR, LPDWORD, LPDWORD);
            DWORD WNetSetConnectionW(LPCWSTR, DWORD, LPVOID);
            DWORD WNetConnectionDialog1W(LPCONNECTDLGSTRUCT);
            DWORD WNetDisconnectDialog1W(LPDISCDLGSTRUCT);
            DWORD WNetOpenEnumW(DWORD, DWORD, DWORD, LPNETRESOURCE, LPHANDLE);
            DWORD WNetEnumResourceW(HANDLE, LPDWORD, LPVOID, LPDWORD);
            DWORD WNetGetUniversalNameW(LPCWSTR, DWORD, LPVOID, LPDWORD);
            DWORD WNetGetUserW(LPCWSTR, LPWSTR, LPDWORD);
            DWORD WNetGetProviderNameW(DWORD, LPWSTR, LPDWORD);
            DWORD WNetGetNetworkInformationW(LPCWSTR, LPNETINFOSTRUCT);
            DWORD WNetGetLastErrorW(LPDWORD, LPWSTR, DWORD, LPWSTR, DWORD);
            DWORD MultinetGetConnectionPerformanceW(LPNETRESOURCE, LPNETCONNECTINFOSTRUCT);
            WINBOOL ChangeServiceConfigW(SC_HANDLE, DWORD, DWORD, DWORD, LPCWSTR, LPCWSTR, LPDWORD, LPCWSTR, LPCWSTR, LPCWSTR, LPCWSTR);
            SC_HANDLE CreateServiceW(SC_HANDLE, LPCWSTR, LPCWSTR, DWORD, DWORD, DWORD, DWORD, LPCWSTR, LPCWSTR, LPDWORD, LPCWSTR, LPCWSTR, LPCWSTR);
            WINBOOL EnumDependentServicesW(SC_HANDLE, DWORD, LPENUM_SERVICE_STATUS, DWORD, LPDWORD, LPDWORD);
            WINBOOL EnumServicesStatusW(SC_HANDLE, DWORD, DWORD, LPENUM_SERVICE_STATUS, DWORD, LPDWORD, LPDWORD, LPDWORD);
            WINBOOL GetServiceKeyNameW(SC_HANDLE, LPCWSTR, LPWSTR, LPDWORD);
            WINBOOL GetServiceDisplayNameW(SC_HANDLE, LPCWSTR, LPWSTR, LPDWORD);
            SC_HANDLE OpenSCManagerW(LPCWSTR, LPCWSTR, DWORD);
            SC_HANDLE OpenServiceW(SC_HANDLE, LPCWSTR, DWORD);
            WINBOOL QueryServiceConfigW(SC_HANDLE, LPQUERY_SERVICE_CONFIG, DWORD, LPDWORD);
            WINBOOL QueryServiceLockStatusW(SC_HANDLE, LPQUERY_SERVICE_LOCK_STATUS, DWORD, LPDWORD);
            SERVICE_STATUS_HANDLE RegisterServiceCtrlHandlerW(LPCWSTR, LPHANDLER_FUNCTION);
            WINBOOL StartServiceCtrlDispatcherW(LPSERVICE_TABLE_ENTRY);
            WINBOOL StartServiceW(SC_HANDLE, DWORD, LPCWSTR);
            uint DragQueryFileW(HDROP, uint, LPCWSTR, uint);
            HICON ExtractAssociatedIconW(HINST, LPCWSTR, LPWORD);
            HICON ExtractIconW(HINST, LPCWSTR, uint);
            HINST FindExecutableW(LPCWSTR, LPCWSTR, LPCWSTR);
            int ShellAboutW(HWND, LPCWSTR, LPCWSTR, HICON);
            HINST ShellExecuteW(HWND, LPCWSTR, LPCWSTR, LPCWSTR, LPCWSTR, int);
            HSZ DdeCreateStringHandleW(DWORD, LPCWSTR, int);
            UINT DdeInitializeW(LPDWORD, PFNCALLBACK, DWORD, DWORD);
            DWORD DdeQueryStringW(DWORD, HSZ, LPCWSTR, DWORD, int);
            WINBOOL LogonUserW(LPWSTR, LPWSTR, LPWSTR, DWORD, DWORD, PHANDLE);
            WINBOOL CreateProcessAsUserW(HANDLE, LPCWSTR, LPWSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, WINBOOL, DWORD, LPVOID, LPCWSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION);
            WINBOOL AccessCheck(PSECURITY_DESCRIPTOR, HANDLE, DWORD, PGENERIC_MAPPING, PPRIVILEGE_SET, LPDWORD, LPDWORD, LPBOOL);
            LONG InterlockedIncrement(LPLONG);
            LONG InterlockedDecrement(LPLONG);
            LONG InterlockedExchange(LPLONG, LONG);
            WINBOOL FreeResource(HGLOBAL);
            LPVOID LockResource(HGLOBAL);
            WINBOOL FreeLibrary(HINST);
            void FreeLibraryAndExitThread(HMODULE, DWORD);
            WINBOOL DisableThreadLibraryCalls(HMODULE);
            FARPROC GetProcAddress(HINST, LPCSTR);
            DWORD GetVersion();
            HGLOBAL GlobalAlloc(UINT, DWORD);
            HGLOBAL GlobalReAlloc(HGLOBAL, DWORD, UINT);
            DWORD GlobalSize(HGLOBAL);
            UINT GlobalFlags(HGLOBAL);
            LPVOID GlobalLock(HGLOBAL);
            HGLOBAL GlobalHandle(LPCVOID);
            WINBOOL GlobalUnlock(HGLOBAL);
            HGLOBAL GlobalFree(HGLOBAL);
            UINT GlobalCompact(DWORD);
            void GlobalFix(HGLOBAL);
            void GlobalUnfix(HGLOBAL);
            LPVOID GlobalWire(HGLOBAL);
            WINBOOL GlobalUnWire(HGLOBAL);
            void GlobalMemoryStatus(LPMEMORYSTATUS);
            HLOCAL LocalAlloc(UINT, UINT);
            HLOCAL LocalReAlloc(HLOCAL, UINT, UINT);
            LPVOID LocalLock(HLOCAL);
            HLOCAL LocalHandle(LPCVOID);
            WINBOOL LocalUnlock(HLOCAL);
            UINT LocalSize(HLOCAL);
            UINT LocalFlags(HLOCAL);
            HLOCAL LocalFree(HLOCAL);
            UINT LocalShrink(HLOCAL, UINT);
            UINT LocalCompact(UINT);
            WINBOOL FlushInstructionCache(HANDLE, LPCVOID, DWORD);
            LPVOID VirtualAlloc(LPVOID, DWORD, DWORD, DWORD);
            WINBOOL VirtualFree(LPVOID, DWORD, DWORD);
            WINBOOL VirtualProtect(LPVOID, DWORD, DWORD, PDWORD);
            DWORD VirtualQuery(LPCVOID, PMEMORY_BASIC_INFORMATION, DWORD);
            WINBOOL VirtualProtectEx(HANDLE, LPVOID, DWORD, DWORD, PDWORD);
            DWORD VirtualQueryEx(HANDLE, LPCVOID, PMEMORY_BASIC_INFORMATION, DWORD);
            HANDLE HeapCreate(DWORD, DWORD, DWORD);
            WINBOOL HeapDestroy(HANDLE);
            LPVOID HeapAlloc(HANDLE, DWORD, DWORD);
            LPVOID HeapReAlloc(HANDLE, DWORD, LPVOID, DWORD);
            WINBOOL HeapFree(HANDLE, DWORD, LPVOID);
            DWORD HeapSize(HANDLE, DWORD, LPCVOID);
            WINBOOL HeapValidate(HANDLE, DWORD, LPCVOID);
            UINT HeapCompact(HANDLE, DWORD);
            HANDLE GetProcessHeap();
            DWORD GetProcessHeaps(DWORD, PHANDLE);
            WINBOOL HeapLock(HANDLE);
            WINBOOL HeapUnlock(HANDLE);
            WINBOOL HeapWalk(HANDLE, LPPROCESS_HEAP_ENTRY);
            WINBOOL GetProcessAffinityMask(HANDLE, LPDWORD, LPDWORD);
            WINBOOL GetProcessTimes(HANDLE, LPFILETIME, LPFILETIME, LPFILETIME, LPFILETIME);
            WINBOOL GetProcessWorkingSetSize(HANDLE, LPDWORD, LPDWORD);
            WINBOOL SetProcessWorkingSetSize(HANDLE, DWORD, DWORD);
            HANDLE OpenProcess(DWORD, WINBOOL, DWORD);
            HANDLE GetCurrentProcess();
            DWORD GetCurrentProcessId();
            void ExitProcess(UINT);
            WINBOOL TerminateProcess(HANDLE, UINT);
            WINBOOL GetExitCodeProcess(HANDLE, LPDWORD);
            void FatalExit(int);
            void RaiseException(DWORD, DWORD, DWORD);
            LONG UnhandledExceptionFilter(EMPTYRECORD*);
            HANDLE CreateRemoteThread(HANDLE, LPSECURITY_ATTRIBUTES, DWORD, LPTHREAD_START_ROUTINE, LPVOID, DWORD, LPDWORD);
            HANDLE GetCurrentThread();
            DWORD GetCurrentThreadId();
            DWORD SetThreadAffinityMask(HANDLE, DWORD);
            WINBOOL SetThreadPriority(HANDLE, int);
            int GetThreadPriority(HANDLE);
            WINBOOL GetThreadTimes(HANDLE, LPFILETIME, LPFILETIME, LPFILETIME, LPFILETIME);
            void ExitThread(DWORD);
            WINBOOL TerminateThread(HANDLE, DWORD);
            WINBOOL GetExitCodeThread(HANDLE, LPDWORD);
            WINBOOL GetThreadSelectorEntry(HANDLE, DWORD, LPLDT_ENTRY);
            DWORD GetLastError();
            void SetLastError(DWORD);
            HANDLE CreateIoCompletionPort(HANDLE, HANDLE, DWORD, DWORD);
            UINT SetErrorMode(UINT);
            WINBOOL ReadProcessMemory(HANDLE, LPCVOID, LPVOID, DWORD, LPDWORD);
            WINBOOL WriteProcessMemory(HANDLE, LPVOID, LPVOID, DWORD, LPDWORD);
            WINBOOL GetThreadContext(HANDLE, LPCONTEXT);
            DWORD SuspendThread(HANDLE);
            DWORD ResumeThread(HANDLE);
            void DebugBreak();
            WINBOOL WaitForDebugEvent(LPDEBUG_EVENT, DWORD);
            WINBOOL ContinueDebugEvent(DWORD, DWORD, DWORD);
            WINBOOL DebugActiveProcess(DWORD);
            void InitializeCriticalSection(LPCRITICAL_SECTION);
            void EnterCriticalSection(LPCRITICAL_SECTION);
            WINBOOL TryEnterCriticalSection(LPCRITICAL_SECTION);
            void LeaveCriticalSection(LPCRITICAL_SECTION);
            void DeleteCriticalSection(LPCRITICAL_SECTION);
            WINBOOL SetEvent(HANDLE);
            WINBOOL ResetEvent(HANDLE);
            WINBOOL PulseEvent(HANDLE);
            WINBOOL ReleaseSemaphore(HANDLE, LONG, LPLONG);
            WINBOOL ReleaseMutex(HANDLE);
            DWORD WaitForSingleObject(HANDLE, DWORD);
            DWORD WaitForMultipleObjects(DWORD, HANDLE*, WINBOOL, DWORD);
            void Sleep(DWORD);
            HGLOBAL LoadResource(HINST, HRSRC);
            DWORD SizeofResource(HINST, HRSRC);
            ATOM GlobalDeleteAtom(ATOM);
            WINBOOL InitAtomTable(DWORD);
            ATOM DeleteAtom(ATOM);
            UINT SetHandleCount(UINT);
            DWORD GetLogicalDrives();
            WINBOOL LockFile(HANDLE, DWORD, DWORD, DWORD, DWORD);
            WINBOOL UnlockFile(HANDLE, DWORD, DWORD, DWORD, DWORD);
            WINBOOL LockFileEx(HANDLE, DWORD, DWORD, DWORD, DWORD, LPOVERLAPPED);
            WINBOOL UnlockFileEx(HANDLE, DWORD, DWORD, DWORD, LPOVERLAPPED);
            WINBOOL GetFileInformationByHandle(HANDLE, LPBY_HANDLE_FILE_INFORMATION);
            DWORD GetFileType(HANDLE);
            DWORD GetFileSize(HANDLE, LPDWORD);
            HANDLE GetStdHandle(DWORD);
            WINBOOL SetStdHandle(DWORD, HANDLE);
            WINBOOL FlushFileBuffers(HANDLE);
            WINBOOL DeviceIoControl(HANDLE, DWORD, LPVOID, DWORD, LPVOID, DWORD, LPDWORD, LPOVERLAPPED);
            WINBOOL SetEndOfFile(HANDLE);
            DWORD SetFilePointer(HANDLE, LONG, PLONG, DWORD);
            WINBOOL FindClose(HANDLE);
            WINBOOL GetFileTime(HANDLE, LPFILETIME, LPFILETIME, LPFILETIME);
            WINBOOL SetFileTime(HANDLE, FILETIME*, FILETIME*, FILETIME*);
            WINBOOL CloseHandle(HANDLE);
            WINBOOL DuplicateHandle(HANDLE, HANDLE, HANDLE, LPHANDLE, DWORD, WINBOOL, DWORD);
            WINBOOL GetHandleInformation(HANDLE, LPDWORD);
            WINBOOL SetHandleInformation(HANDLE, DWORD, DWORD);
            DWORD LoadModule(LPCSTR, LPVOID);
            UINT WinExec(LPCSTR, UINT);
            WINBOOL ClearCommBreak(HANDLE);
            WINBOOL ClearCommError(HANDLE, LPDWORD, LPCOMSTAT);
            WINBOOL SetupComm(HANDLE, DWORD, DWORD);
            WINBOOL EscapeCommFunction(HANDLE, DWORD);
            WINBOOL GetCommConfig(HANDLE, LPCOMMCONFIG, LPDWORD);
            WINBOOL GetCommProperties(HANDLE, LPCOMMPROP);
            WINBOOL GetCommModemStatus(HANDLE, PDWORD);
            WINBOOL GetCommState(HANDLE, PDCB);
            WINBOOL GetCommTimeouts(HANDLE, PCOMMTIMEOUTS);
            WINBOOL PurgeComm(HANDLE, DWORD);
            WINBOOL SetCommBreak(HANDLE);
            WINBOOL SetCommConfig(HANDLE, LPCOMMCONFIG, DWORD);
            WINBOOL SetCommMask(HANDLE, DWORD);
            WINBOOL SetCommState(HANDLE, TDCB*);
            WINBOOL SetCommTimeouts(HANDLE, TCOMMTIMEOUTS*);
            WINBOOL TransmitCommChar(HANDLE, char);
            WINBOOL WaitCommEvent(HANDLE, LPDWORD, LPOVERLAPPED);
            DWORD SetTapePosition(HANDLE, DWORD, DWORD, DWORD, DWORD, WINBOOL);
            DWORD GetTapePosition(HANDLE, DWORD, LPDWORD, LPDWORD, LPDWORD);
            DWORD PrepareTape(HANDLE, DWORD, WINBOOL);
            DWORD EraseTape(HANDLE, DWORD, WINBOOL);
            DWORD CreateTapePartition(HANDLE, DWORD, DWORD, DWORD);
            DWORD WriteTapemark(HANDLE, DWORD, DWORD, WINBOOL);
            DWORD GetTapeStatus(HANDLE);
            DWORD GetTapeParameters(HANDLE, DWORD, LPDWORD, LPVOID);
            DWORD SetTapeParameters(HANDLE, DWORD, LPVOID);
            WINBOOL Beep(DWORD, DWORD);
            int MulDiv(int, int, int);
            void GetSystemTime(LPSYSTEMTIME);
                void GetSystemTimeAsFileTime(FILETIME*);
            WINBOOL SetSystemTime(SYSTEMTIME*);
            void GetLocalTime(LPSYSTEMTIME);
            WINBOOL SetLocalTime(SYSTEMTIME*);
            void GetSystemInfo(LPSYSTEM_INFO);
            WINBOOL SystemTimeToTzSpecificLocalTime(LPTIME_ZONE_INFORMATION, LPSYSTEMTIME, LPSYSTEMTIME);
            DWORD GetTimeZoneInformation(LPTIME_ZONE_INFORMATION);
            WINBOOL SetTimeZoneInformation(TIME_ZONE_INFORMATION*);
            WINBOOL SystemTimeToFileTime(SYSTEMTIME*, LPFILETIME);
            WINBOOL FileTimeToLocalFileTime(FILETIME*, LPFILETIME);
            WINBOOL LocalFileTimeToFileTime(FILETIME*, LPFILETIME);
            WINBOOL FileTimeToSystemTime(FILETIME*, LPSYSTEMTIME);
            LONG CompareFileTime(FILETIME*, FILETIME*);
            WINBOOL FileTimeToDosDateTime(FILETIME*, LPWORD, LPWORD);
            WINBOOL DosDateTimeToFileTime(ushort, ushort, LPFILETIME);
            DWORD GetTickCount();
            WINBOOL SetSystemTimeAdjustment(DWORD, WINBOOL);
            WINBOOL GetSystemTimeAdjustment(PDWORD, PDWORD, PWINBOOL);
            WINBOOL CreatePipe(PHANDLE, PHANDLE, LPSECURITY_ATTRIBUTES, DWORD);
            WINBOOL ConnectNamedPipe(HANDLE, LPOVERLAPPED);
            WINBOOL DisconnectNamedPipe(HANDLE);
            WINBOOL SetNamedPipeHandleState(HANDLE, LPDWORD, LPDWORD, LPDWORD);
            WINBOOL GetNamedPipeInfo(HANDLE, LPDWORD, LPDWORD, LPDWORD, LPDWORD);
            WINBOOL PeekNamedPipe(HANDLE, LPVOID, DWORD, LPDWORD, LPDWORD, LPDWORD);
            WINBOOL TransactNamedPipe(HANDLE, LPVOID, DWORD, LPVOID, DWORD, LPDWORD, LPOVERLAPPED);
            WINBOOL GetMailslotInfo(HANDLE, LPDWORD, LPDWORD, LPDWORD, LPDWORD);
            WINBOOL SetMailslotInfo(HANDLE, DWORD);
            LPVOID MapViewOfFile(HANDLE, DWORD, DWORD, DWORD, DWORD);
            WINBOOL FlushViewOfFile(LPCVOID, DWORD);
            WINBOOL UnmapViewOfFile(LPVOID);
            HFILE OpenFile(LPCSTR, LPOFSTRUCT, UINT);
            HFILE _lopen(LPCSTR, int);
            HFILE _lcreat(LPCSTR, int);
            UINT _lread(HFILE, LPVOID, UINT);
            UINT _lwrite(HFILE, LPCSTR, UINT);
            int _hread(HFILE, LPVOID, int);
            int _hwrite(HFILE, LPCSTR, int);
            HFILE _lclose(HFILE);
            LONG _llseek(HFILE, LONG, int);
            WINBOOL IsTextUnicode(LPVOID, int, LPINT);
            DWORD TlsAlloc();
            LPVOID TlsGetValue(DWORD);
            WINBOOL TlsSetValue(DWORD, LPVOID);
            WINBOOL TlsFree(DWORD);
            DWORD SleepEx(DWORD, WINBOOL);
            DWORD WaitForSingleObjectEx(HANDLE, DWORD, WINBOOL);
            DWORD WaitForMultipleObjectsEx(DWORD, HANDLE*, WINBOOL, DWORD, WINBOOL);
            WINBOOL ReadFileEx(HANDLE, LPVOID, DWORD, LPOVERLAPPED, LPOVERLAPPED_COMPLETION_ROUTINE);
            WINBOOL WriteFileEx(HANDLE, LPCVOID, DWORD, LPOVERLAPPED, LPOVERLAPPED_COMPLETION_ROUTINE);
            WINBOOL BackupRead(HANDLE, LPBYTE, DWORD, LPDWORD, WINBOOL, WINBOOL, LPVOID*);
            WINBOOL BackupSeek(HANDLE, DWORD, DWORD, LPDWORD, LPDWORD, LPVOID*);
            WINBOOL BackupWrite(HANDLE, LPBYTE, DWORD, LPDWORD, WINBOOL, WINBOOL, LPVOID*);
            WINBOOL SetProcessShutdownParameters(DWORD, DWORD);
            WINBOOL GetProcessShutdownParameters(LPDWORD, LPDWORD);
            void SetFileApisToOEM();
            void SetFileApisToANSI();
            WINBOOL AreFileApisANSI();
            WINBOOL CloseEventLog(HANDLE);
            WINBOOL DeregisterEventSource(HANDLE);
            WINBOOL NotifyChangeEventLog(HANDLE, HANDLE);
            WINBOOL GetNumberOfEventLogRecords(HANDLE, PDWORD);
            WINBOOL GetOldestEventLogRecord(HANDLE, PDWORD);
            WINBOOL DuplicateToken(HANDLE, SECURITY_IMPERSONATION_LEVEL, PHANDLE);
            WINBOOL GetKernelObjectSecurity(HANDLE, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR, DWORD, LPDWORD);
            WINBOOL ImpersonateNamedPipeClient(HANDLE);
            WINBOOL ImpersonateLoggedOnUser(HANDLE);
            WINBOOL ImpersonateSelf(SECURITY_IMPERSONATION_LEVEL);
            WINBOOL RevertToSelf();
            WINBOOL SetThreadToken(PHANDLE, HANDLE);
            WINBOOL OpenProcessToken(HANDLE, DWORD, PHANDLE);
            WINBOOL OpenThreadToken(HANDLE, DWORD, WINBOOL, PHANDLE);
            WINBOOL GetTokenInformation(HANDLE, TOKEN_INFORMATION_CLASS, LPVOID, DWORD, PDWORD);
            WINBOOL SetTokenInformation(HANDLE, TOKEN_INFORMATION_CLASS, LPVOID, DWORD);
            WINBOOL AdjustTokenPrivileges(HANDLE, WINBOOL, PTOKEN_PRIVILEGES, DWORD, PTOKEN_PRIVILEGES, PDWORD);
            WINBOOL AdjustTokenGroups(HANDLE, WINBOOL, PTOKEN_GROUPS, DWORD, PTOKEN_GROUPS, PDWORD);
            WINBOOL PrivilegeCheck(HANDLE, PPRIVILEGE_SET, LPBOOL);
            WINBOOL IsValidSid(PSID);
            WINBOOL EqualSid(PSID, PSID);
            WINBOOL EqualPrefixSid(PSID, PSID);
            DWORD GetSidLengthRequired(UCHAR);
            WINBOOL AllocateAndInitializeSid(PSID_IDENTIFIER_AUTHORITY, ubyte, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, PSID*);
            PVOID FreeSid(PSID);
            WINBOOL InitializeSid(PSID, PSID_IDENTIFIER_AUTHORITY, ubyte);
            PSID_IDENTIFIER_AUTHORITY GetSidIdentifierAuthority(PSID);
            PDWORD GetSidSubAuthority(PSID, DWORD);
            PUCHAR GetSidSubAuthorityCount(PSID);
            DWORD GetLengthSid(PSID);
            WINBOOL CopySid(DWORD, PSID, PSID);
            WINBOOL AreAllAccessesGranted(DWORD, DWORD);
            WINBOOL AreAnyAccessesGranted(DWORD, DWORD);
            void MapGenericMask(PDWORD);
            WINBOOL IsValidAcl(PACL);
            WINBOOL InitializeAcl(PACL, DWORD, DWORD);
            WINBOOL GetAclInformation(PACL, LPVOID, DWORD, ACL_INFORMATION_CLASS);
            WINBOOL SetAclInformation(PACL, LPVOID, DWORD, ACL_INFORMATION_CLASS);
            WINBOOL AddAce(PACL, DWORD, DWORD, LPVOID, DWORD);
            WINBOOL DeleteAce(PACL, DWORD);
            WINBOOL GetAce(PACL, DWORD, LPVOID*);
            WINBOOL AddAccessAllowedAce(PACL, DWORD, DWORD, PSID);
            WINBOOL AddAccessDeniedAce(PACL, DWORD, DWORD, PSID);
            WINBOOL AddAuditAccessAce(PACL, DWORD, DWORD, PSID, WINBOOL, WINBOOL);
            WINBOOL FindFirstFreeAce(PACL, LPVOID*);
            WINBOOL InitializeSecurityDescriptor(PSECURITY_DESCRIPTOR, DWORD);
            WINBOOL IsValidSecurityDescriptor(PSECURITY_DESCRIPTOR);
            DWORD GetSecurityDescriptorLength(PSECURITY_DESCRIPTOR);
            WINBOOL GetSecurityDescriptorControl(PSECURITY_DESCRIPTOR, PSECURITY_DESCRIPTOR_CONTROL, LPDWORD);
            WINBOOL SetSecurityDescriptorDacl(PSECURITY_DESCRIPTOR, WINBOOL, PACL, WINBOOL);
            WINBOOL GetSecurityDescriptorDacl(PSECURITY_DESCRIPTOR, LPBOOL, PACL*, LPBOOL);
            WINBOOL SetSecurityDescriptorSacl(PSECURITY_DESCRIPTOR, WINBOOL, PACL, WINBOOL);
            WINBOOL GetSecurityDescriptorSacl(PSECURITY_DESCRIPTOR, LPBOOL, PACL*, LPBOOL);
            WINBOOL SetSecurityDescriptorOwner(PSECURITY_DESCRIPTOR, PSID, WINBOOL);
            WINBOOL GetSecurityDescriptorOwner(PSECURITY_DESCRIPTOR, PSID*, LPBOOL);
            WINBOOL SetSecurityDescriptorGroup(PSECURITY_DESCRIPTOR, PSID, WINBOOL);
            WINBOOL GetSecurityDescriptorGroup(PSECURITY_DESCRIPTOR, PSID*, LPBOOL);
            WINBOOL CreatePrivateObjectSecurity(PSECURITY_DESCRIPTOR, PSECURITY_DESCRIPTOR, PSECURITY_DESCRIPTOR*, WINBOOL, HANDLE, PGENERIC_MAPPING);
            WINBOOL SetPrivateObjectSecurity(SECURITY_INFORMATION, PSECURITY_DESCRIPTOR, PSECURITY_DESCRIPTOR*, PGENERIC_MAPPING, HANDLE);
            WINBOOL GetPrivateObjectSecurity(PSECURITY_DESCRIPTOR, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR, DWORD, PDWORD);
            WINBOOL DestroyPrivateObjectSecurity(PSECURITY_DESCRIPTOR);
            WINBOOL MakeSelfRelativeSD(PSECURITY_DESCRIPTOR, PSECURITY_DESCRIPTOR, LPDWORD);
            WINBOOL MakeAbsoluteSD(PSECURITY_DESCRIPTOR, PSECURITY_DESCRIPTOR, LPDWORD, PACL, LPDWORD, PACL, LPDWORD, PSID, LPDWORD, PSID, LPDWORD);
            WINBOOL SetKernelObjectSecurity(HANDLE, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR);
            WINBOOL FindNextChangeNotification(HANDLE);
            WINBOOL FindCloseChangeNotification(HANDLE);
            WINBOOL VirtualLock(LPVOID, DWORD);
            WINBOOL VirtualUnlock(LPVOID, DWORD);
            LPVOID MapViewOfFileEx(HANDLE, DWORD, DWORD, DWORD, DWORD, LPVOID);
            WINBOOL SetPriorityClass(HANDLE, DWORD);
            DWORD GetPriorityClass(HANDLE);
            WINBOOL IsBadReadPtr(POINTER, UINT);
            WINBOOL IsBadWritePtr(LPVOID, UINT);
            WINBOOL IsBadHugeReadPtr(POINTER, UINT);
            WINBOOL IsBadHugeWritePtr(LPVOID, UINT);
            WINBOOL IsBadCodePtr(FARPROC);
            WINBOOL AllocateLocallyUniqueId(PLUID);
            WINBOOL QueryPerformanceCounter(PLARGE_INTEGER);
            WINBOOL QueryPerformanceFrequency(PLARGE_INTEGER);
            WINBOOL ActivateKeyboardLayout(HKL, UINT);
            WINBOOL UnloadKeyboardLayout(HKL);
            int GetKeyboardLayoutList(int, HKL*);
            HKL GetKeyboardLayout(DWORD);
            HDESK OpenInputDesktop(DWORD, WINBOOL, DWORD);
            WINBOOL EnumDesktopWindows(HDESK, ENUMWINDOWSPROC, LPARAM);
            WINBOOL SwitchDesktop(HDESK);
            WINBOOL SetThreadDesktop(HDESK);
            WINBOOL CloseDesktop(HDESK);
            HDESK GetThreadDesktop(DWORD);
            WINBOOL CloseWindowStation(HWINSTA);
            WINBOOL SetProcessWindowStation(HWINSTA);
            HWINSTA GetProcessWindowStation();
            WINBOOL SetUserObjectSecurity(HANDLE, PSECURITY_INFORMATION, PSECURITY_DESCRIPTOR);
            WINBOOL GetUserObjectSecurity(HANDLE, PSECURITY_INFORMATION, PSECURITY_DESCRIPTOR, DWORD, LPDWORD);
            WINBOOL TranslateMessage(LPMSG);
            WINBOOL SetMessageQueue(int);
            WINBOOL RegisterHotKey(HWND, int, UINT, UINT);
            WINBOOL UnregisterHotKey(HWND, int);
            WINBOOL ExitWindowsEx(UINT, DWORD);
            WINBOOL SwapMouseButton(WINBOOL);
            DWORD GetMessagePos();
            LONG GetMessageTime();
            LONG GetMessageExtraInfo();
            LPARAM SetMessageExtraInfo(LPARAM);
            int BroadcastSystemMessage(DWORD, LPDWORD, UINT, WPARAM, LPARAM);
            WINBOOL AttachThreadInput(DWORD, DWORD, WINBOOL);
            WINBOOL ReplyMessage(LRESULT);
            WINBOOL WaitMessage();
            DWORD WaitForInputIdle(HANDLE, DWORD);
            void PostQuitMessage(int);
            WINBOOL InSendMessage();
            UINT GetDoubleClickTime();
            WINBOOL SetDoubleClickTime(UINT);
            WINBOOL IsWindow(HWND);
            WINBOOL IsMenu(HMENU);
            WINBOOL IsChild(HWND, HWND);
            WINBOOL DestroyWindow(HWND);
            WINBOOL ShowWindow(HWND, int);
            WINBOOL ShowWindowAsync(HWND, int);
            WINBOOL FlashWindow(HWND, WINBOOL);
            WINBOOL ShowOwnedPopups(HWND, WINBOOL);
            WINBOOL OpenIcon(HWND);
            WINBOOL CloseWindow(HWND);
            WINBOOL MoveWindow(HWND, int, int, int, int, WINBOOL);
            WINBOOL SetWindowPos(HWND, HWND, int, int, int, int, UINT);
            WINBOOL GetWindowPlacement(HWND, WINDOWPLACEMENT*);
            WINBOOL SetWindowPlacement(HWND, WINDOWPLACEMENT*);
            HDWP BeginDeferWindowPos(int);
            HDWP DeferWindowPos(HDWP, HWND, HWND, int, int, int, int, UINT);
            WINBOOL EndDeferWindowPos(HDWP);
            WINBOOL IsWindowVisible(HWND);
            WINBOOL IsIconic(HWND);
            WINBOOL AnyPopup();
            WINBOOL BringWindowToTop(HWND);
            WINBOOL IsZoomed(HWND);
            WINBOOL EndDialog(HWND, int);
            HWND GetDlgItem(HWND, int);
            WINBOOL SetDlgItemInt(HWND, int, UINT, WINBOOL);
            UINT GetDlgItemInt(HWND, int, WINBOOL*, WINBOOL);
            WINBOOL CheckDlgButton(HWND, int, UINT);
            WINBOOL CheckRadioButton(HWND, int, int, int);
            UINT IsDlgButtonChecked(HWND, int);
            HWND GetNextDlgGroupItem(HWND, HWND, WINBOOL);
            HWND GetNextDlgTabItem(HWND, HWND, WINBOOL);
            int GetDlgCtrlID(HWND);
            int GetDialogBaseUnits();
            WINBOOL OpenClipboard(HWND);
            WINBOOL CloseClipboard();
            HWND GetClipboardOwner();
            HWND SetClipboardViewer(HWND);
            HWND GetClipboardViewer();
            WINBOOL ChangeClipboardChain(HWND, HWND);
            HANDLE SetClipboardData(UINT, HANDLE);
            HANDLE GetClipboardData(UINT);
            int CountClipboardFormats();
            UINT EnumClipboardFormats(UINT);
            WINBOOL EmptyClipboard();
            WINBOOL IsClipboardFormatAvailable(UINT);
            int GetPriorityClipboardFormat(UINT*, int);
            HWND GetOpenClipboardWindow();
            LPSTR CharNextExA(ushort, LPCSTR, DWORD);
            LPSTR CharPrevExA(ushort, LPCSTR, LPCSTR, DWORD);
            HWND SetFocus(HWND);
            HWND GetActiveWindow();
            HWND GetFocus();
            UINT GetKBCodePage();
            SHORT GetKeyState(int);
            SHORT GetAsyncKeyState(int);
            WINBOOL GetKeyboardState(PBYTE);
            WINBOOL SetKeyboardState(LPBYTE);
            int GetKeyboardType(int);
            int ToAscii(UINT, UINT, PBYTE, LPWORD, UINT);
            int ToAsciiEx(UINT, UINT, PBYTE, LPWORD, UINT, HKL);
            int ToUnicode(UINT, UINT, PBYTE, LPWSTR, int, UINT);
            DWORD OemKeyScan(ushort);
            void keybd_event(ubyte, ubyte, DWORD, POINTER);
            void mouse_event(DWORD, DWORD, DWORD, DWORD);
            WINBOOL GetInputState();
            DWORD GetQueueStatus(UINT);
            HWND GetCapture();
            HWND SetCapture(HWND);
            WINBOOL ReleaseCapture();
            DWORD MsgWaitForMultipleObjects(DWORD, LPHANDLE, WINBOOL, DWORD, DWORD);
            UINT SetTimer(HWND, UINT, UINT, TIMERPROC);
            WINBOOL KillTimer(HWND, UINT);
            WINBOOL IsWindowUnicode(HWND);
            WINBOOL EnableWindow(HWND, WINBOOL);
            WINBOOL IsWindowEnabled(HWND);
            WINBOOL DestroyAcceleratorTable(HACCEL);
            int GetSystemMetrics(int);
            HMENU GetMenu(HWND);
            WINBOOL SetMenu(HWND, HMENU);
            WINBOOL HiliteMenuItem(HWND, HMENU, UINT, UINT);
            UINT GetMenuState(HMENU, UINT, UINT);
            WINBOOL DrawMenuBar(HWND);
            HMENU GetSystemMenu(HWND, WINBOOL);
            HMENU CreateMenu();
            HMENU CreatePopupMenu();
            WINBOOL DestroyMenu(HMENU);
            DWORD CheckMenuItem(HMENU, UINT, UINT);
            WINBOOL EnableMenuItem(HMENU, UINT, UINT);
            HMENU GetSubMenu(HMENU, int);
            UINT GetMenuItemID(HMENU, int);
            int GetMenuItemCount(HMENU);
            WINBOOL RemoveMenu(HMENU, UINT, UINT);
            WINBOOL DeleteMenu(HMENU, UINT, UINT);
            WINBOOL SetMenuItemBitmaps(HMENU, UINT, UINT, HBITMAP, HBITMAP);
            LONG GetMenuCheckMarkDimensions();
            WINBOOL TrackPopupMenu(HMENU, UINT, int, int, int, HWND, RECT*);
            UINT GetMenuDefaultItem(HMENU, UINT, UINT);
            WINBOOL SetMenuDefaultItem(HMENU, UINT, UINT);
            WINBOOL GetMenuItemRect(HWND, HMENU, UINT, LPRECT);
            int MenuItemFromPoint(HWND, HMENU, POINT);
            DWORD DragObject(HWND, HWND, UINT, DWORD, HCURSOR);
            WINBOOL DragDetect(HWND, POINT);
            WINBOOL DrawIcon(HDC, int, int, HICON);
            WINBOOL UpdateWindow(HWND);
            HWND SetActiveWindow(HWND);
            HWND GetForegroundWindow();
            WINBOOL PaintDesktop(HDC);
            WINBOOL SetForegroundWindow(HWND);
            HWND WindowFromDC(HDC);
            HDC GetDC(HWND);
            HDC GetDCEx(HWND, HRGN, DWORD);
            HDC GetWindowDC(HWND);
            int ReleaseDC(HWND, HDC);
            HDC BeginPaint(HWND, LPPAINTSTRUCT);
            WINBOOL EndPaint(HWND, LPPAINTSTRUCT);
            WINBOOL GetUpdateRect(HWND, LPRECT, WINBOOL);
            int GetUpdateRgn(HWND, HRGN, WINBOOL);
            int SetWindowRgn(HWND, HRGN, WINBOOL);
            int GetWindowRgn(HWND, HRGN);
            int ExcludeUpdateRgn(HDC, HWND);
            WINBOOL InvalidateRect(HWND, RECT*, WINBOOL);
            WINBOOL ValidateRect(HWND, RECT*);
            WINBOOL InvalidateRgn(HWND, HRGN, WINBOOL);
            WINBOOL ValidateRgn(HWND, HRGN);
            WINBOOL RedrawWindow(HWND, RECT*, HRGN, UINT);
            WINBOOL LockWindowUpdate(HWND);
            WINBOOL ScrollWindow(HWND, int, int, RECT*, RECT*);
            WINBOOL ScrollDC(HDC, int, int, RECT*, RECT*, HRGN, LPRECT);
            int ScrollWindowEx(HWND, int, int, RECT*, RECT*, HRGN, LPRECT, UINT);
            int SetScrollPos(HWND, int, int, WINBOOL);
            int GetScrollPos(HWND, int);
            WINBOOL SetScrollRange(HWND, int, int, int, WINBOOL);
            WINBOOL GetScrollRange(HWND, int, LPINT, LPINT);
            WINBOOL ShowScrollBar(HWND, int, WINBOOL);
            WINBOOL EnableScrollBar(HWND, UINT, UINT);
            WINBOOL GetClientRect(HWND, LPRECT);
            WINBOOL GetWindowRect(HWND, LPRECT);
            WINBOOL AdjustWindowRect(LPRECT, DWORD, WINBOOL);
            WINBOOL AdjustWindowRectEx(LPRECT, DWORD, WINBOOL, DWORD);
            WINBOOL SetWindowContextHelpId(HWND, DWORD);
            DWORD GetWindowContextHelpId(HWND);
            WINBOOL SetMenuContextHelpId(HMENU, DWORD);
            DWORD GetMenuContextHelpId(HMENU);
            WINBOOL MessageBeep(UINT);
            int ShowCursor(WINBOOL);
            WINBOOL SetCursorPos(int, int);
            HCURSOR SetCursor(HCURSOR);
            WINBOOL GetCursorPos(LPPOINT);
            WINBOOL ClipCursor(RECT*);
            WINBOOL GetClipCursor(LPRECT);
            HCURSOR GetCursor();
            WINBOOL CreateCaret(HWND, HBITMAP, int, int);
            UINT GetCaretBlinkTime();
            WINBOOL SetCaretBlinkTime(UINT);
            WINBOOL DestroyCaret();
            WINBOOL HideCaret(HWND);
            WINBOOL ShowCaret(HWND);
            WINBOOL SetCaretPos(int, int);
            WINBOOL GetCaretPos(LPPOINT);
            WINBOOL ClientToScreen(HWND, LPPOINT);
            WINBOOL ScreenToClient(HWND, LPPOINT);
            int MapWindowPoints(HWND, HWND, LPPOINT, UINT);
            HWND WindowFromPoint(POINT);
            HWND ChildWindowFromPoint(HWND, POINT);
            DWORD GetSysColor(int);
            HBRUSH GetSysColorBrush(int);
            WINBOOL SetSysColors(int, WINT*, COLORREF*);
            WINBOOL DrawFocusRect(HDC, RECT*);
            int FillRect(HDC, RECT*, HBRUSH);
            int FrameRect(HDC, RECT*, HBRUSH);
            WINBOOL InvertRect(HDC, RECT*);
            WINBOOL SetRect(LPRECT, int, int, int, int);
            WINBOOL SetRectEmpty(LPRECT);
            WINBOOL CopyRect(LPRECT, RECT*);
            WINBOOL InflateRect(LPRECT, int, int);
            WINBOOL IntersectRect(LPRECT, RECT*, RECT*);
            WINBOOL UnionRect(LPRECT, RECT*, RECT*);
            WINBOOL SubtractRect(LPRECT, RECT*, RECT*);
            WINBOOL OffsetRect(LPRECT, int, int);
            WINBOOL IsRectEmpty(RECT*);
            WINBOOL EqualRect(RECT*, RECT*);
            WINBOOL PtInRect(RECT*, POINT);
            ushort GetWindowWord(HWND, int);
            ushort SetWindowWord(HWND, int, ushort);
            ushort GetClassWord(HWND, int);
            ushort SetClassWord(HWND, int, ushort);
            HWND GetDesktopWindow();
            HWND GetParent(HWND);
            HWND SetParent(HWND, HWND);
            WINBOOL EnumChildWindows(HWND, ENUMWINDOWSPROC, LPARAM);
            WINBOOL EnumWindows(ENUMWINDOWSPROC, LPARAM);
            WINBOOL EnumThreadWindows(DWORD, ENUMWINDOWSPROC, LPARAM);
            HWND GetTopWindow(HWND);
            DWORD GetWindowThreadProcessId(HWND, LPDWORD);
            HWND GetLastActivePopup(HWND);
            HWND GetWindow(HWND, UINT);
            WINBOOL UnhookWindowsHook(int, HOOKPROC);
            WINBOOL UnhookWindowsHookEx(HHOOK);
            LRESULT CallNextHookEx(HHOOK, int, WPARAM, LPARAM);
            WINBOOL CheckMenuRadioItem(HMENU, UINT, UINT, UINT, UINT);
            HCURSOR CreateCursor(HINST, int, int, int, int, POINTER, POINTER);
            WINBOOL DestroyCursor(HCURSOR);
            WINBOOL SetSystemCursor(HCURSOR, DWORD);
            HICON CreateIcon(HINST, int, int, ubyte, ubyte, ubyte*, ubyte*);
            WINBOOL DestroyIcon(HICON);
            int LookupIconIdFromDirectory(PBYTE, WINBOOL);
            int LookupIconIdFromDirectoryEx(PBYTE, WINBOOL, int, int, UINT);
            HICON CreateIconFromResource(PBYTE, DWORD, WINBOOL, DWORD);
            HICON CreateIconFromResourceEx(PBYTE, DWORD, WINBOOL, DWORD, int, int, UINT);
            HICON CopyImage(HANDLE, UINT, int, int, UINT);
            HICON CreateIconIndirect(PICONINFO);
            HICON CopyIcon(HICON);
            WINBOOL GetIconInfo(HICON, PICONINFO);
            WINBOOL MapDialogRect(HWND, LPRECT);
            int SetScrollInfo(HWND, int, LPCSCROLLINFO, WINBOOL);
            WINBOOL GetScrollInfo(HWND, int, LPSCROLLINFO);
            WINBOOL TranslateMDISysAccel(HWND, LPMSG);
            UINT ArrangeIconicWindows(HWND);
            ushort TileWindows(HWND, UINT, RECT*, UINT, HWND*);
            ushort CascadeWindows(HWND, UINT, RECT*, UINT, HWND*);
            void SetLastErrorEx(DWORD);
            void SetDebugErrorLevel(DWORD);
            WINBOOL DrawEdge(HDC, LPRECT, UINT, UINT);
            WINBOOL DrawFrameControl(HDC, LPRECT, UINT, UINT);
            WINBOOL DrawCaption(HWND, HDC, RECT*, UINT);
            WINBOOL DrawAnimatedRects(HWND, int, RECT*, RECT*);
            WINBOOL TrackPopupMenuEx(HMENU, UINT, int, int, HWND, LPTPMPARAMS);
            HWND ChildWindowFromPointEx(HWND, POINT, UINT);
            WINBOOL DrawIconEx(HDC, int, int, HICON, int, int, UINT, HBRUSH, UINT);
            WINBOOL AnimatePalette(HPALETTE, UINT, UINT, PALETTEENTRY*);
            WINBOOL Arc(HDC, int, int, int, int, int, int, int, int);
            WINBOOL BitBlt(HDC, int, int, int, int, HDC, int, int, DWORD);
            WINBOOL CancelDC(HDC);
            WINBOOL Chord(HDC, int, int, int, int, int, int, int, int);
            HMETAFILE CloseMetaFile(HDC);
            int CombineRgn(HRGN, HRGN, HRGN, int);
            HBITMAP CreateBitmap(int, int, UINT, UINT, POINTER);
            HBITMAP CreateBitmapIndirect(BITMAP*);
            HBRUSH CreateBrushIndirect(LOGBRUSH*);
            HBITMAP CreateCompatibleBitmap(HDC, int, int);
            HBITMAP CreateDiscardableBitmap(HDC, int, int);
            HDC CreateCompatibleDC(HDC);
            HBITMAP CreateDIBitmap(HDC, BITMAPINFOHEADER*, DWORD, POINTER, BITMAPINFO*, UINT);
            HBRUSH CreateDIBPatternBrush(HGLOBAL, UINT);
            HBRUSH CreateDIBPatternBrushPt(POINTER, UINT);
            HRGN CreateEllipticRgn(int, int, int, int);
            HRGN CreateEllipticRgnIndirect(RECT*);
            HBRUSH CreateHatchBrush(int, COLORREF);
            HPALETTE CreatePalette(LOGPALETTE*);
            HPEN CreatePen(int, int, COLORREF);
            HPEN CreatePenIndirect(LOGPEN*);
            HRGN CreatePolyPolygonRgn(POINT*, WINT*, int, int);
            HBRUSH CreatePatternBrush(HBITMAP);
            HRGN CreateRectRgn(int, int, int, int);
            HRGN CreateRectRgnIndirect(RECT*);
            HRGN CreateRoundRectRgn(int, int, int, int, int, int);
            HBRUSH CreateSolidBrush(COLORREF);
            WINBOOL DeleteDC(HDC);
            WINBOOL DeleteMetaFile(HMETAFILE);
            WINBOOL DeleteObject(HGDIOBJ);
            int DrawEscape(HDC, int, int, LPCSTR);
            WINBOOL Ellipse(HDC, int, int, int, int);
            int EnumObjects(HDC, int, ENUMOBJECTSPROC, LPARAM);
            WINBOOL EqualRgn(HRGN, HRGN);
            int Escape(HDC, int, int, LPCSTR, LPVOID);
            int ExtEscape(HDC, int, int, LPCSTR, int, LPSTR);
            int ExcludeClipRect(HDC, int, int, int, int);
            HRGN ExtCreateRegion(XFORM*, DWORD, RGNDATA*);
            WINBOOL ExtFloodFill(HDC, int, int, COLORREF, UINT);
            WINBOOL FillRgn(HDC, HRGN, HBRUSH);
            WINBOOL FloodFill(HDC, int, int, COLORREF);
            WINBOOL FrameRgn(HDC, HRGN, HBRUSH, int, int);
            int GetROP2(HDC);
            WINBOOL GetAspectRatioFilterEx(HDC, LPSIZE);
            COLORREF GetBkColor(HDC);
            int GetBkMode(HDC);
            LONG GetBitmapBits(HBITMAP, LONG, LPVOID);
            WINBOOL GetBitmapDimensionEx(HBITMAP, LPSIZE);
            UINT GetBoundsRect(HDC, LPRECT, UINT);
            WINBOOL GetBrushOrgEx(HDC, LPPOINT);
            int GetClipBox(HDC, LPRECT);
            int GetClipRgn(HDC, HRGN);
            int GetMetaRgn(HDC, HRGN);
            HGDIOBJ GetCurrentObject(HDC, UINT);
            WINBOOL GetCurrentPositionEx(HDC, LPPOINT);
            int GetDeviceCaps(HDC, int);
            int GetDIBits(HDC, HBITMAP, UINT, UINT, LPVOID, LPBITMAPINFO, UINT);
            DWORD GetFontData(HDC, DWORD, DWORD, LPVOID, DWORD);
            int GetGraphicsMode(HDC);
            int GetMapMode(HDC);
            UINT GetMetaFileBitsEx(HMETAFILE, UINT, LPVOID);
            COLORREF GetNearestColor(HDC, COLORREF);
            UINT GetNearestPaletteIndex(HPALETTE, COLORREF);
            DWORD GetObjectType(HGDIOBJ);
            UINT GetPaletteEntries(HPALETTE, UINT, UINT, LPPALETTEENTRY);
            COLORREF GetPixel(HDC, int, int);
            int GetPixelFormat(HDC);
            int GetPolyFillMode(HDC);
            WINBOOL GetRasterizerCaps(LPRASTERIZER_STATUS, UINT);
            DWORD GetRegionData(HRGN, DWORD, LPRGNDATA);
            int GetRgnBox(HRGN, LPRECT);
            HGDIOBJ GetStockObject(int);
            int GetStretchBltMode(HDC);
            UINT GetSystemPaletteEntries(HDC, UINT, UINT, LPPALETTEENTRY);
            UINT GetSystemPaletteUse(HDC);
            int GetTextCharacterExtra(HDC);
            UINT GetTextAlign(HDC);
            COLORREF GetTextColor(HDC);
            int GetTextCharset(HDC);
            int GetTextCharsetInfo(HDC, LPFONTSIGNATURE, DWORD);
            WINBOOL TranslateCharsetInfo(DWORD*, LPCHARSETINFO, DWORD);
            DWORD GetFontLanguageInfo(HDC);
            WINBOOL GetViewportExtEx(HDC, LPSIZE);
            WINBOOL GetViewportOrgEx(HDC, LPPOINT);
            WINBOOL GetWindowExtEx(HDC, LPSIZE);
            WINBOOL GetWindowOrgEx(HDC, LPPOINT);
            int IntersectClipRect(HDC, int, int, int, int);
            WINBOOL InvertRgn(HDC, HRGN);
            WINBOOL LineDDA(int, int, int, int, LINEDDAPROC, LPARAM);
            WINBOOL LineTo(HDC, int, int);
            WINBOOL MaskBlt(HDC, int, int, int, int, HDC, int, int, HBITMAP, int, int, DWORD);
            WINBOOL PlgBlt(HDC, POINT*, HDC, int, int, int, int, HBITMAP, int, int);
            int OffsetClipRgn(HDC, int, int);
            int OffsetRgn(HRGN, int, int);
            WINBOOL PatBlt(HDC, int, int, int, int, DWORD);
            WINBOOL Pie(HDC, int, int, int, int, int, int, int, int);
            WINBOOL PlayMetaFile(HDC, HMETAFILE);
            WINBOOL PaintRgn(HDC, HRGN);
            WINBOOL PolyPolygon(HDC, POINT*, WINT*, int);
            WINBOOL PtInRegion(HRGN, int, int);
            WINBOOL PtVisible(HDC, int, int);
            WINBOOL RectInRegion(HRGN, RECT*);
            WINBOOL RectVisible(HDC, RECT*);
            WINBOOL Rectangle(HDC, int, int, int, int);
            WINBOOL RestoreDC(HDC, int);
            UINT RealizePalette(HDC);
            WINBOOL RoundRect(HDC, int, int, int, int, int, int);
            WINBOOL ResizePalette(HPALETTE, UINT);
            int SaveDC(HDC);
            int SelectClipRgn(HDC, HRGN);
            int ExtSelectClipRgn(HDC, HRGN, int);
            int SetMetaRgn(HDC);
            HGDIOBJ SelectObject(HDC, HGDIOBJ);
            HPALETTE SelectPalette(HDC, HPALETTE, WINBOOL);
            COLORREF SetBkColor(HDC, COLORREF);
            int SetBkMode(HDC, int);
            LONG SetBitmapBits(HBITMAP, DWORD, POINTER);
            UINT SetBoundsRect(HDC, RECT*, UINT);
            int SetDIBits(HDC, HBITMAP, UINT, UINT, POINTER, PBITMAPINFO, UINT);
            int SetDIBitsToDevice(HDC, int, int, DWORD, DWORD, int, int, UINT, UINT, POINTER, BITMAPINFO*, UINT);
            DWORD SetMapperFlags(HDC, DWORD);
            int SetGraphicsMode(HDC, int);
            int SetMapMode(HDC, int);
            HMETAFILE SetMetaFileBitsEx(UINT, ubyte*);
            UINT SetPaletteEntries(HPALETTE, UINT, UINT, PALETTEENTRY*);
            COLORREF SetPixel(HDC, int, int, COLORREF);
            WINBOOL SetPixelV(HDC, int, int, COLORREF);
            int SetPolyFillMode(HDC, int);
            WINBOOL StretchBlt(HDC, int, int, int, int, HDC, int, int, int, int, DWORD);
            WINBOOL SetRectRgn(HRGN, int, int, int, int);
            int StretchDIBits(HDC, int, int, int, int, int, int, int, int, POINTER, BITMAPINFO*, UINT, DWORD);
            int SetROP2(HDC, int);
            int SetStretchBltMode(HDC, int);
            UINT SetSystemPaletteUse(HDC, UINT);
            int SetTextCharacterExtra(HDC, int);
            COLORREF SetTextColor(HDC, COLORREF);
            UINT SetTextAlign(HDC, UINT);
            WINBOOL SetTextJustification(HDC, int, int);
            WINBOOL UpdateColors(HDC);
            WINBOOL PlayMetaFileRecord(HDC, LPHANDLETABLE, LPMETARECORD, UINT);
            WINBOOL EnumMetaFile(HDC, HMETAFILE, ENUMMETAFILEPROC, LPARAM);
            HENHMETAFILE CloseEnhMetaFile(HDC);
            WINBOOL DeleteEnhMetaFile(HENHMETAFILE);
            WINBOOL EnumEnhMetaFile(HDC, HENHMETAFILE, ENHMETAFILEPROC, LPVOID, RECT*);
            UINT GetEnhMetaFileHeader(HENHMETAFILE, UINT, LPENHMETAHEADER);
            UINT GetEnhMetaFilePaletteEntries(HENHMETAFILE, UINT, LPPALETTEENTRY);
            UINT GetWinMetaFileBits(HENHMETAFILE, UINT, LPBYTE, WINT, HDC);
            WINBOOL PlayEnhMetaFile(HDC, HENHMETAFILE, RECT*);
            WINBOOL PlayEnhMetaFileRecord(HDC, LPHANDLETABLE, ENHMETARECORD*, UINT);
            HENHMETAFILE SetEnhMetaFileBits(UINT, ubyte*);
            HENHMETAFILE SetWinMetaFileBits(UINT, ubyte*, HDC, METAFILEPICT*);
            WINBOOL GdiComment(HDC, UINT, ubyte*);
            WINBOOL AngleArc(HDC, int, int, DWORD, FLOAT, FLOAT);
            WINBOOL PolyPolyline(HDC, POINT*, DWORD*, DWORD);
            WINBOOL GetWorldTransform(HDC, LPXFORM);
            WINBOOL SetWorldTransform(HDC, XFORM*);
            WINBOOL ModifyWorldTransform(HDC, XFORM*, DWORD);
            WINBOOL CombineTransform(LPXFORM, XFORM*, XFORM*);
            HBITMAP CreateDIBSection(HDC, BITMAPINFO*, UINT, POINTER*, HANDLE, DWORD);
            UINT GetDIBColorTable(HDC, UINT, UINT, RGBQUAD*);
            UINT SetDIBColorTable(HDC, UINT, UINT, RGBQUAD*);
            WINBOOL SetColorAdjustment(HDC, COLORADJUSTMENT*);
            WINBOOL GetColorAdjustment(HDC, LPCOLORADJUSTMENT);
            HPALETTE CreateHalftonePalette(HDC);
            int EndDoc(HDC);
            int StartPage(HDC);
            int EndPage(HDC);
            int AbortDoc(HDC);
            int SetAbortProc(HDC, TABORTPROC);
            WINBOOL ArcTo(HDC, int, int, int, int, int, int, int, int);
            WINBOOL BeginPath(HDC);
            WINBOOL CloseFigure(HDC);
            WINBOOL EndPath(HDC);
            WINBOOL FillPath(HDC);
            WINBOOL FlattenPath(HDC);
            int GetPath(HDC, LPPOINT, LPBYTE, int);
            HRGN PathToRegion(HDC);
            WINBOOL PolyDraw(HDC, POINT*, ubyte*, int);
            WINBOOL SelectClipPath(HDC, int);
            int SetArcDirection(HDC, int);
            WINBOOL SetMiterLimit(HDC, FLOAT, PFLOAT);
            WINBOOL StrokeAndFillPath(HDC);
            WINBOOL StrokePath(HDC);
            WINBOOL WidenPath(HDC);
            HPEN ExtCreatePen(DWORD, DWORD, LOGBRUSH*, DWORD, DWORD*);
            WINBOOL GetMiterLimit(HDC, PFLOAT);
            int GetArcDirection(HDC);
            WINBOOL MoveToEx(HDC, int, int, LPPOINT);
            HRGN CreatePolygonRgn(POINT*, int, int);
            WINBOOL DPtoLP(HDC, LPPOINT, int);
            WINBOOL LPtoDP(HDC, LPPOINT, int);
            WINBOOL Polygon(HDC, POINT*, int);
            WINBOOL Polyline(HDC, POINT*, int);
            WINBOOL PolyBezier(HDC, POINT*, DWORD);
            WINBOOL PolyBezierTo(HDC, POINT*, DWORD);
            WINBOOL PolylineTo(HDC, POINT*, DWORD);
            WINBOOL SetViewportExtEx(HDC, int, int, LPSIZE);
            WINBOOL SetViewportOrgEx(HDC, int, int, LPPOINT);
            WINBOOL SetWindowExtEx(HDC, int, int, LPSIZE);
            WINBOOL SetWindowOrgEx(HDC, int, int, LPPOINT);
            WINBOOL OffsetViewportOrgEx(HDC, int, int, LPPOINT);
            WINBOOL OffsetWindowOrgEx(HDC, int, int, LPPOINT);
            WINBOOL ScaleViewportExtEx(HDC, int, int, int, int, LPSIZE);
            WINBOOL ScaleWindowExtEx(HDC, int, int, int, int, LPSIZE);
            WINBOOL SetBitmapDimensionEx(HBITMAP, int, int, LPSIZE);
            WINBOOL SetBrushOrgEx(HDC, int, int, LPPOINT);
            WINBOOL GetDCOrgEx(HDC, LPPOINT);
            WINBOOL FixBrushOrgEx(HDC, int, int, LPPOINT);
            WINBOOL UnrealizeObject(HGDIOBJ);
            WINBOOL GdiFlush();
            DWORD GdiSetBatchLimit(DWORD);
            DWORD GdiGetBatchLimit();
            int SetICMMode(HDC, int);
            WINBOOL CheckColorsInGamut(HDC, LPVOID, LPVOID, DWORD);
            HANDLE GetColorSpace(HDC);
            WINBOOL SetColorSpace(HDC, HCOLORSPACE);
            WINBOOL DeleteColorSpace(HCOLORSPACE);
            WINBOOL GetDeviceGammaRamp(HDC, LPVOID);
            WINBOOL SetDeviceGammaRamp(HDC, LPVOID);
            WINBOOL ColorMatchToTarget(HDC, HDC, DWORD);
            HPROPSHEETPAGE CreatePropertySheetPageA(LPCPROPSHEETPAGE);
            WINBOOL DestroyPropertySheetPage(HPROPSHEETPAGE);
            void InitCommonControls();
            HIMAGELIST ImageList_Create(int, int, UINT, int, int);
            WINBOOL ImageList_Destroy(HIMAGELIST);
            int ImageList_GetImageCount(HIMAGELIST);
            int ImageList_Add(HIMAGELIST, HBITMAP, HBITMAP);
            int ImageList_ReplaceIcon(HIMAGELIST, int, HICON);
            COLORREF ImageList_SetBkColor(HIMAGELIST, COLORREF);
            COLORREF ImageList_GetBkColor(HIMAGELIST);
            WINBOOL ImageList_SetOverlayImage(HIMAGELIST, int, int);
            WINBOOL ImageList_Draw(HIMAGELIST, int, HDC, int, int, UINT);
            WINBOOL ImageList_Replace(HIMAGELIST, int, HBITMAP, HBITMAP);
            int ImageList_AddMasked(HIMAGELIST, HBITMAP, COLORREF);
            WINBOOL ImageList_DrawEx(HIMAGELIST, int, HDC, int, int, int, int, COLORREF, COLORREF, UINT);
            WINBOOL ImageList_Remove(HIMAGELIST, int);
            HICON ImageList_GetIcon(HIMAGELIST, int, UINT);
            WINBOOL ImageList_BeginDrag(HIMAGELIST, int, int, int);
            void ImageList_EndDrag();
            WINBOOL ImageList_DragEnter(HWND, int, int);
            WINBOOL ImageList_DragLeave(HWND);
            WINBOOL ImageList_DragMove(int, int);
            WINBOOL ImageList_SetDragCursorImage(HIMAGELIST, int, int, int);
            WINBOOL ImageList_DragShowNolock(WINBOOL);
            HIMAGELIST ImageList_GetDragImage(POINT*, POINT*);
            WINBOOL ImageList_GetIconSize(HIMAGELIST, int*, int*);
            WINBOOL ImageList_SetIconSize(HIMAGELIST, int, int);
            WINBOOL ImageList_GetImageInfo(HIMAGELIST, int, IMAGEINFO*);
            HIMAGELIST ImageList_Merge(HIMAGELIST, int, HIMAGELIST, int, int, int);
            HWND CreateToolbarEx(HWND, DWORD, UINT, int, HINST, UINT, LPCTBBUTTON, int, int, int, int, int, UINT);
            HBITMAP CreateMappedBitmap(HINST, int, UINT, LPCOLORMAP, int);
            void MenuHelp(UINT, WPARAM, LPARAM, HMENU, HINST, HWND);
            WINBOOL ShowHideMenuCtl(HWND, UINT, LPINT);
            void GetEffectiveClientRect(HWND, LPRECT);
            WINBOOL MakeDragList(HWND);
            void DrawInsert(HWND, HWND);
            int LBItemFromPt(HWND, POINT, WINBOOL);
            HWND CreateUpDownControl(DWORD, int, int, int, int, HWND, int, HINST, HWND, int, int, int);
            LONG RegCloseKey(HKEY);
            LONG RegSetKeySecurity(HKEY, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR);
            LONG RegFlushKey(HKEY);
            LONG RegGetKeySecurity(HKEY, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR, LPDWORD);
            LONG RegNotifyChangeKeyValue(HKEY, WINBOOL, DWORD, HANDLE, WINBOOL);
            WINBOOL IsValidCodePage(UINT);
            UINT GetACP();
            UINT GetOEMCP();
            WINBOOL GetCPInfo(UINT, LPCPINFO);
            WINBOOL IsDBCSLeadByte(ubyte);
            WINBOOL IsDBCSLeadByteEx(UINT, ubyte);
            int MultiByteToWideChar(UINT, DWORD, LPCSTR, int, LPWSTR, int);
            int WideCharToMultiByte(UINT, DWORD, LPCWSTR, int, LPSTR, int, LPCSTR, LPBOOL);
            WINBOOL IsValidLocale(LCID, DWORD);
            LCID ConvertDefaultLocale(LCID);
            LCID GetThreadLocale();
            WINBOOL SetThreadLocale(LCID);
            LANGID GetSystemDefaultLangID();
            LANGID GetUserDefaultLangID();
            LCID GetSystemDefaultLCID();
            LCID GetUserDefaultLCID();
            WINBOOL ReadConsoleOutputAttribute(HANDLE, LPWORD, DWORD, COORD, LPDWORD);
            WINBOOL WriteConsoleOutputAttribute(HANDLE, ushort*, DWORD, COORD, LPDWORD);
            WINBOOL FillConsoleOutputAttribute(HANDLE, ushort, DWORD, COORD, LPDWORD);
            WINBOOL GetConsoleMode(HANDLE, LPDWORD);
            WINBOOL GetNumberOfConsoleInputEvents(HANDLE, PDWORD);
            WINBOOL GetConsoleScreenBufferInfo(HANDLE, PCONSOLE_SCREEN_BUFFER_INFO);
            COORD GetLargestConsoleWindowSize(HANDLE);
            WINBOOL GetConsoleCursorInfo(HANDLE, PCONSOLE_CURSOR_INFO);
            WINBOOL GetNumberOfConsoleMouseButtons(LPDWORD);
            WINBOOL SetConsoleMode(HANDLE, DWORD);
            WINBOOL SetConsoleActiveScreenBuffer(HANDLE);
            WINBOOL FlushConsoleInputBuffer(HANDLE);
            WINBOOL SetConsoleScreenBufferSize(HANDLE, COORD);
            WINBOOL SetConsoleCursorPosition(HANDLE, COORD);
            WINBOOL SetConsoleCursorInfo(HANDLE, PCONSOLE_CURSOR_INFO);
            WINBOOL SetConsoleWindowInfo(HANDLE, WINBOOL, SMALL_RECT*);
            WINBOOL SetConsoleTextAttribute(HANDLE, ushort);
            WINBOOL SetConsoleCtrlHandler(PHANDLER_ROUTINE, WINBOOL);
            WINBOOL GenerateConsoleCtrlEvent(DWORD, DWORD);
            WINBOOL AllocConsole();
            WINBOOL FreeConsole();
            HANDLE CreateConsoleScreenBuffer(DWORD, DWORD, SECURITY_ATTRIBUTES*, DWORD, LPVOID);
            UINT GetConsoleCP();
            WINBOOL SetConsoleCP(UINT);
            UINT GetConsoleOutputCP();
            WINBOOL SetConsoleOutputCP(UINT);
            DWORD WNetConnectionDialog(HWND, DWORD);
            DWORD WNetDisconnectDialog(HWND, DWORD);
            DWORD WNetCloseEnum(HANDLE);
            WINBOOL CloseServiceHandle(SC_HANDLE);
            WINBOOL ControlService(SC_HANDLE, DWORD, LPSERVICE_STATUS);
            WINBOOL DeleteService(SC_HANDLE);
            SC_LOCK LockServiceDatabase(SC_HANDLE);
            WINBOOL NotifyBootConfigStatus(WINBOOL);
            WINBOOL QueryServiceObjectSecurity(SC_HANDLE, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR, DWORD, LPDWORD);
            WINBOOL QueryServiceStatus(SC_HANDLE, LPSERVICE_STATUS);
            WINBOOL SetServiceObjectSecurity(SC_HANDLE, SECURITY_INFORMATION, PSECURITY_DESCRIPTOR);
            WINBOOL SetServiceStatus(SERVICE_STATUS_HANDLE, LPSERVICE_STATUS);
            WINBOOL UnlockServiceDatabase(SC_LOCK);
            int ChoosePixelFormat(HDC, PIXELFORMATDESCRIPTOR*);
            int DescribePixelFormat(HDC, int, UINT, LPPIXELFORMATDESCRIPTOR);
            WINBOOL SetPixelFormat(HDC, int, PPIXELFORMATDESCRIPTOR);
            WINBOOL SwapBuffers(HDC);
            WINBOOL DragQueryPoint(HDROP, LPPOINT);
            void DragFinish(HDROP);
            void DragAcceptFiles(HWND, BOOL);
            HICON DuplicateIcon(HINST, HICON);
            BOOL DdeAbandonTransaction(DWORD, HCONV, DWORD);
            PBYTE DdeAccessData(HDDEDATA, PDWORD);
            HDDEDATA DdeAddData(HDDEDATA, PBYTE, DWORD, DWORD);
            HDDEDATA DdeClientTransaction(PBYTE, DWORD, HCONV, HSZ, UINT, UINT, DWORD, PDWORD);
            int DdeCmpStringHandles(HSZ, HSZ);
            HCONV DdeConnect(DWORD, HSZ, HSZ, CONVCONTEXT*);
            HCONVLIST DdeConnectList(DWORD, HSZ, HSZ, HCONVLIST, PCONVCONTEXT);
            HDDEDATA DdeCreateDataHandle(DWORD, LPBYTE, DWORD, DWORD, HSZ, UINT, UINT);
            WINBOOL DdeDisconnect(HCONV);
            BOOL DdeDisconnectList(HCONVLIST);
            BOOL DdeEnableCallback(DWORD, HCONV, UINT);
            WINBOOL DdeFreeDataHandle(HDDEDATA);
            WINBOOL DdeFreeStringHandle(DWORD, HSZ);
            DWORD DdeGetData(HDDEDATA, ubyte*, DWORD, DWORD);
            UINT DdeGetLastError(DWORD);
            BOOL DdeImpersonateClient(HCONV);
            BOOL DdeKeepStringHandle(DWORD, HSZ);
            HDDEDATA DdeNameService(DWORD, HSZ, HSZ, UINT);
            WINBOOL DdePostAdvise(DWORD, HSZ, HSZ);
            UINT DdeQueryConvInfo(HCONV, DWORD, PCONVINFO);
            HCONV DdeQueryNextServer(HCONVLIST, HCONV);
            HCONV DdeReconnect(HCONV);
            BOOL DdeSetUserHandle(HCONV, DWORD, DWORD);
            BOOL DdeUnaccessData(HDDEDATA);
            WINBOOL DdeUninitialize(DWORD);
            void SHAddToRecentDocs(UINT);
            LPITEMIDLIST SHBrowseForFolder(LPBROWSEINFO);
            void SHChangeNotify(LONG, UINT, LPCVOID);
            int SHFileOperationA(LPSHFILEOPSTRUCTA);
            int SHFileOperationW(LPSHFILEOPSTRUCTW);
            void SHFreeNameMappings(HANDLE);
            DWORD SHGetFileInfo(LPCTSTR, DWORD, SHFILEINFO*, UINT, UINT);
            WINBOOL SHGetPathFromIDList(LPCITEMIDLIST, LPTSTR);
            HRESULT SHGetSpecialFolderLocation(HWND, int, LPITEMIDLIST*);
            THANDLE CreateThread(POINTER, DWORD, TFNTHREADSTARTROUTINE, POINTER, DWORD, DWORD*);
            BOOL DdeSetQualityOfService(HWND, TSECURITYQUALITYOFSERVICE*, PSECURITYQUALITYOFSERVICE);
            BOOL GetCommMask(THANDLE, DWORD*);
            BOOL GetDiskFreeSpaceExA(LPCSTR, void*, void*, PLARGEINTEGER);
            BOOL GetDiskFreeSpaceExW(LPWSTR, void*, void*, PLARGEINTEGER);
            DWORD GetKerningPairs(HDC, DWORD, void*);
            BOOL GetOverlappedResult(THANDLE, TOVERLAPPED*, DWORD*, BOOL);
            BOOL GetQueuedCompletionStatus(THANDLE, DWORD*, DWORD*, POVERLAPPED*, DWORD);
            BOOL GetSystemPowerStatus(TSYSTEMPOWERSTATUS*);
            BOOL ReadFile(THANDLE, void*, DWORD, DWORD*, POVERLAPPED);
            BOOL SetThreadContext(THANDLE, TCONTEXT*);
            BOOL wglDescribeLayerPlane(HDC, int, int, uint, TLAYERPLANEDESCRIPTOR*);
            int wglGetLayerPaletteEntries(HDC, int, int, int, void*);
            int wglSetLayerPaletteEntries(HDC, int, int, int, void*);
            DWORD WNetGetResourceParentA(PNETRESOURCEA, POINTER, DWORD*);
            BOOL WriteFile(THANDLE, void*, DWORD, DWORD*, POVERLAPPED);

                BOOL CancelWaitableTimer(HANDLE hTimer);
                HANDLE OpenWaitableTimerA(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCSTR lpTimerName);
                HANDLE OpenWaitableTimerW(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCWSTR lpTimerName);
                HANDLE CreateWaitableTimerA(LPSECURITY_ATTRIBUTES lpTimerAttributes, BOOL bManualReset, LPCSTR lpTimerName);
                HANDLE CreateWaitableTimerW(LPSECURITY_ATTRIBUTES lpTimerAttributes, BOOL bManualReset, LPCWSTR lpTimerName);
                BOOL SetWaitableTimer(HANDLE hTimer, LARGE_INTEGER* pDueTime, LONG lPeriod, PTIMERAPCROUTINE pfnCompletionRoutine, LPVOID lpArgToCompletionRoutine, BOOL fResume);
        }

        version(Win32SansUnicode){
            alias SHFileOperationA SHFileOperation;
        }else{
            alias SHFileOperationW SHFileOperation;
        }



    }}
}

////////////////////////////////////////////////////////////////////////////////////////
// org.eclipse.swt
////////////////////////////////////////////////////////////////////////////////////////

alias HANDLE HPAINTBUFFER;

extern (Windows){
HRESULT AssocQueryStringA(ASSOCF flags, int str, LPCSTR pszAssoc, LPCSTR pszExtra, LPSTR pszOut, DWORD *pcchOut);
HRESULT AssocQueryStringW(ASSOCF flags, int str, LPCWSTR pszAssoc, LPCWSTR pszExtra, LPWSTR pszOut, DWORD *pcchOut);
int AddFontResourceExA(LPCSTR lpszFilename, int fl, void* pdv);
int AddFontResourceExW(LPCWSTR lpszFilename, int fl, void* pdv);

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
int IIDFromString (LPCWSTR lpsz, byte* lpiid);
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
void RtlMoveMemory(void* Destination, LPCVOID Source, DWORD Length);
// extends
void RtlMoveMemory(int Destination, LPCVOID Source, DWORD Length);
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
  LPCWSTR pwcChars,
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
  LPCWSTR pwcInChars,
  int cChars,
  DWORD dwFlags,
  WORD* pwOutGlyphs
);
HRESULT ScriptStringAnalyse(
  HDC hdc,
  LPCVOID pString,
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
  LPCWSTR pwcInChars,
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
  LPCWSTR pwcChars,      //
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
