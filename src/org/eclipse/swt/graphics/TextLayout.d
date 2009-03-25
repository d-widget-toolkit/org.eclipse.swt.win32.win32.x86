/*******************************************************************************
 * Copyright (c) 2000, 2008 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - initial API and implementation
 * Port to the D programming language:
 *     Frank Benoit <benoit@tionex.de>
 *******************************************************************************/
module org.eclipse.swt.graphics.TextLayout;

/++
 + SWT Changes to make the port work.
 + The USER API is utf8, the Windows API is utf16. In addition to the fields 'text' and 'segmentsText' fields are added to help.
 + wtext: same as text but utf16
 + segmentsWText: same as segmentsText but utf16
 + index8to16: translate indexes from segmentsText to segmentsWText
 + index16to8: translate indexes from segmentsWText to segmentsText
 +
 + 'text' is the original user text, 'segmentsText' is the user text stuffed with
 + RTL/LTR markers for each line or in addition for User supplied segments. A segment
 + is a range where Bidi char reordering can happen.
 + The 'runs' are those ranges with an idiviual style.
 +/
import org.eclipse.swt.SWT;
import org.eclipse.swt.SWTException;
import org.eclipse.swt.internal.Compatibility;
import org.eclipse.swt.internal.gdip.Gdip;

import org.eclipse.swt.internal.win32.OS;

import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Device;
import org.eclipse.swt.graphics.Font;
import org.eclipse.swt.graphics.FontMetrics;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.GCData;
import org.eclipse.swt.graphics.GlyphMetrics;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.graphics.Region;
import org.eclipse.swt.graphics.Resource;
import org.eclipse.swt.graphics.TextStyle;

import java.lang.all;


/**
 * <code>TextLayout</code> is a graphic object that represents
 * styled text.
 * <p>
 * Instances of this class provide support for drawing, cursor
 * navigation, hit testing, text wrapping, alignment, tab expansion
 * line breaking, etc.  These are aspects required for rendering internationalized text.
 * </p><p>
 * Application code must explicitly invoke the <code>TextLayout#dispose()</code>
 * method to release the operating system resources managed by each instance
 * when those instances are no longer required.
 * </p>
 *
 * @see <a href="http://www.eclipse.org/swt/snippets/#textlayout">TextLayout, TextStyle snippets</a>
 * @see <a href="http://www.eclipse.org/swt/examples.php">SWT Example: CustomControlExample, StyledText tab</a>
 * @see <a href="http://www.eclipse.org/swt/">Sample code and further information</a>
 * 
 * @since 3.0
 */
public final class TextLayout : Resource {

    alias Resource.init_ init_;

/++
 +  SWT doku
 +  The styles has at minimum 2 member, each with a start. The last element is the end marker.
 +
 +  invariant{
 +      assert( stylesCount >= 2 );
 +      assert( stylesCount <= styles.length );
 +      assert( styles[stylesCount-1] );
 +      assert( styles[stylesCount-1].start is text.length );
 +  }
 +/


    Font font;
    String  text;
    String16 wtext;
    String  segmentsText;
    String16 segmentsWText; // DWT
    int[]   index8to16; // DWT
    int[]   index16to8; // DWT
    int lineSpacing;
    int ascent, descent;
    int alignment;
    int wrapWidth;
    int orientation;
    int indent;
    bool justify;
    int[] tabs;
    int[] segments; // indices in 'text'
    int[] wsegments; // SWT indices in 'wtext'
    StyleItem[] styles;
    int stylesCount;

    StyleItem[] allRuns;
    StyleItem[][] runs;
    int[] lineOffset, lineY, lineWidth;
    void* mLangFontLink2;

    static const dchar LTR_MARK = '\u200E', RTL_MARK = '\u200F';
    static const wchar LTR_MARKw = '\u200E', RTL_MARKw = '\u200F';
    static const String STR_LTR_MARK = "\u200E", STR_RTL_MARK = "\u200F";
    static const wchar[] WSTR_LTR_MARK = "\u200E"w, WSTR_RTL_MARK = "\u200F"w;
    static const int MARK_SIZE = 3;
    static const int WMARK_SIZE = 1;
    static const int SCRIPT_VISATTR_SIZEOF = 2;
    static const int GOFFSET_SIZEOF = 8;
    private static byte[16] CLSID_CMultiLanguage;
    private static byte[16] IID_IMLangFontLink2;
    private static bool static_this_completed = false;
    private static void static_this() {
        // in case of allready initialized, we can check and leave without lock
        if( static_this_completed ){
            return;
        }
        synchronized {
            if( !static_this_completed ){
                OS.IIDFromString("{275c23e2-3747-11d0-9fea-00aa003f8646}\0".toWCharArray().ptr, CLSID_CMultiLanguage.ptr);
                OS.IIDFromString("{DCCFC162-2B38-11d2-B7EC-00C04F8F5D9A}\0".toWCharArray().ptr, IID_IMLangFontLink2.ptr);
                static_this_completed = true;
            }
        }
    }

    /* IME has a copy of these constants */
    static const int UNDERLINE_IME_DOT = 1 << 16;
    static const int UNDERLINE_IME_DASH = 2 << 16;
    static const int UNDERLINE_IME_THICK = 3 << 16;

    class StyleItem {
        TextStyle style;
        // SWT: start, lenght relative to segmentsText
        int start, length;
        bool lineBreak, softBreak, tab;

        /*Script cache and analysis */
        SCRIPT_ANALYSIS analysis;
        SCRIPT_CACHE* psc;

        /*Shape info (malloc when the run is shaped) */
        WORD* glyphs;
        int glyphCount;
        WORD* clusters;
        SCRIPT_VISATTR* visAttrs;

        /*Place info (malloc when the run is placed) */
        int* advances;
        GOFFSET* goffsets;
        int width;
        int ascent;
        int descent;
        int leading;
        int x;
        int underlinePos, underlineThickness;
        int strikeoutPos, strikeoutThickness;

        /* Justify info (malloc during computeRuns) */
        int* justify;

        /* ScriptBreak */
        SCRIPT_LOGATTR* psla;

        HFONT fallbackFont;

    void free() {
        auto hHeap = OS.GetProcessHeap();
        if (psc !is null) {
            OS.ScriptFreeCache (psc);
            OS.HeapFree(hHeap, 0, psc);
            psc = null;
        }
        if (glyphs !is null) {
            OS.HeapFree(hHeap, 0, glyphs);
            glyphs = null;
            glyphCount = 0;
        }
        if (clusters !is null) {
            OS.HeapFree(hHeap, 0, clusters);
            clusters = null;
        }
        if (visAttrs !is null) {
            OS.HeapFree(hHeap, 0, visAttrs);
            visAttrs = null;
        }
        if (advances !is null) {
            OS.HeapFree(hHeap, 0, advances);
            advances = null;
        }
        if (goffsets !is null) {
            OS.HeapFree(hHeap, 0, goffsets);
            goffsets = null;
        }
        if (justify !is null) {
            OS.HeapFree(hHeap, 0, justify);
            justify = null;
        }
        if (psla !is null) {
            OS.HeapFree(hHeap, 0, psla);
            psla = null;
        }
        if (fallbackFont !is null) {
            OS.DeleteObject(fallbackFont);
            fallbackFont = null;
        }
        width = 0;
        ascent = 0;
        descent = 0;
        x = 0;
        lineBreak = softBreak = false;
    }
    override public String toString () {
        return Format( "StyleItem {{{}, {}}", start, style );
    }
    }

/**
 * Constructs a new instance of this class on the given device.
 * <p>
 * You must dispose the text layout when it is no longer required.
 * </p>
 *
 * @param device the device on which to allocate the text layout
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_NULL_ARGUMENT - if device is null and there is no current device</li>
 * </ul>
 *
 * @see #dispose()
 */
public this (Device device) {
    static_this();
    super(device);
    wrapWidth = ascent = descent = -1;
    lineSpacing = 0;
    orientation = SWT.LEFT_TO_RIGHT;
    styles = new StyleItem[2];
    styles[0] = new StyleItem();
    styles[1] = new StyleItem();
    stylesCount = 2;
    text = ""; //$NON-NLS-1$
    wtext = ""w;
    void* ppv;
    OS.OleInitialize(null);
    if (OS.CoCreateInstance(CLSID_CMultiLanguage.ptr, null, OS.CLSCTX_INPROC_SERVER, IID_IMLangFontLink2.ptr, cast(void*)&ppv) is OS.S_OK) {
        mLangFontLink2 = ppv;
    }
    init_();
}

void breakRun(StyleItem run) {
    if (run.psla !is null) return;
    String16 chars = segmentsWText[ index8to16[ run.start ] .. index8to16[ run.start + run.length ] ];
    auto hHeap = OS.GetProcessHeap();
    run.psla = cast(SCRIPT_LOGATTR*)OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, SCRIPT_LOGATTR.sizeof * chars.length);
    if (run.psla is null) SWT.error(SWT.ERROR_NO_HANDLES);
    OS.ScriptBreak(chars.ptr, chars.length, &run.analysis, run.psla);
}

void checkLayout () {
    if (isDisposed()) SWT.error(SWT.ERROR_GRAPHIC_DISPOSED);
}

/*
*  Compute the runs: itemize, shape, place, and reorder the runs.
*   Break paragraphs into lines, wraps the text, and initialize caches.
*/
void computeRuns (GC gc) {
    if (runs !is null) return;
    auto hDC = gc !is null ? gc.handle : device.internal_new_GC(null);
    auto srcHdc = OS.CreateCompatibleDC(hDC);
    allRuns = itemize();
    for (int i=0; i<allRuns.length - 1; i++) {
        StyleItem run = allRuns[i];
        OS.SelectObject(srcHdc, getItemFont(run));
        shape(srcHdc, run);
    }
    SCRIPT_LOGATTR* logAttr;
    SCRIPT_PROPERTIES* properties;
    int lineWidth = indent, lineStart = 0, lineCount = 1;
    for (int i=0; i<allRuns.length - 1; i++) {
        StyleItem run = allRuns[i];
        if (run.length is 1) {
            char ch = segmentsText.charAt(run.start);
            switch (ch) {
                case '\t': {
                    run.tab = true;
                    if (tabs is null) break;
                    int tabsLength = tabs.length, j;
                    for (j = 0; j < tabsLength; j++) {
                        if (tabs[j] > lineWidth) {
                            run.width = tabs[j] - lineWidth;
                            break;
                        }
                    }
                    if (j is tabsLength) {
                        int tabX = tabs[tabsLength-1];
                        int lastTabWidth = tabsLength > 1 ? tabs[tabsLength-1] - tabs[tabsLength-2] : tabs[0];
                        if (lastTabWidth > 0) {
                            while (tabX <= lineWidth) tabX += lastTabWidth;
                            run.width = tabX - lineWidth;
                        }
                    }
                    break;
                }
                case '\n': {
                    run.lineBreak = true;
                    break;
                }
                case '\r': {
                    run.lineBreak = true;
                    StyleItem next = allRuns[i + 1];
                    if (next.length !is 0 && segmentsText.charAt(next.start) is '\n') {
                        run.length += 1;
                        next.free();
                        StyleItem[] newAllRuns = new StyleItem[allRuns.length - 1];
                        System.arraycopy(allRuns, 0, newAllRuns, 0, i + 1);
                        System.arraycopy(allRuns, i + 2, newAllRuns, i + 1, allRuns.length - i - 2);
                        allRuns = newAllRuns;
                    }
                    break;
                }
                default:
            }
        }
        if (wrapWidth !is -1 && lineWidth + run.width > wrapWidth && !run.tab) {
            int start = 0;
            int[] piDx = new int[run.length];
            if (run.style !is null && run.style.metrics !is null) {
                piDx[0] = run.width;
            } else {
                OS.ScriptGetLogicalWidths(&run.analysis, run.length, run.glyphCount, run.advances, run.clusters, run.visAttrs, piDx.ptr);
            }
            int width = 0, maxWidth = wrapWidth - lineWidth;
            while (width + piDx[start] < maxWidth) {
                width += piDx[start++];
            }
            int firstStart = start;
            int firstIndice = i;
            while (i >= lineStart) {
                breakRun(run);
                while (start >= 0) {
                    logAttr = run.psla + start;
                    //OS.MoveMemory(logAttr, run.psla + (start * SCRIPT_LOGATTR.sizeof), SCRIPT_LOGATTR.sizeof);
                    if (logAttr.fSoftBreak || logAttr.fWhiteSpace) break;
                    start--;
                }

                /*
                *  Bug in Windows. For some reason Uniscribe sets the fSoftBreak flag for the first letter
                *  after a letter with an accent. This cause a break line to be set in the middle of a word.
                *  The fix is to detect the case and ignore fSoftBreak forcing the algorithm keep searching.
                */
                if (start is 0 && i !is lineStart && !run.tab) {
                    if (logAttr.fSoftBreak && !logAttr.fWhiteSpace) {
                        properties = device.scripts[run.analysis.eScript];
                        //OS.MoveMemory(properties, device.scripts[run.analysis.eScript], SCRIPT_PROPERTIES.sizeof);
                        int langID = properties.langid;
                        StyleItem pRun = allRuns[i - 1];
                        //OS.MoveMemory(properties, device.scripts[pRun.analysis.eScript], SCRIPT_PROPERTIES.sizeof);
                        if (properties.langid is langID || langID is OS.LANG_NEUTRAL || properties.langid is OS.LANG_NEUTRAL) {
                            breakRun(pRun);
                            logAttr = pRun.psla + (pRun.length - 1);
                            //OS.MoveMemory(logAttr, pRun.psla + ((pRun.length - 1) * SCRIPT_LOGATTR.sizeof), SCRIPT_LOGATTR.sizeof);
                            if (!logAttr.fWhiteSpace) start = -1;
                        }
                    }
                }
                if (start >= 0 || i is lineStart) break;
                run = allRuns[--i];
                start = run.length - 1;
            }
            if (start is 0 && i !is lineStart && !run.tab) {
                run = allRuns[--i];
            } else  if (start <= 0 && i is lineStart) {
                if (lineWidth is wrapWidth && firstIndice > 0) {
                    i = firstIndice - 1;
                    run = allRuns[i];
                    start = run.length;
                } else {
                    i = firstIndice;
                    run = allRuns[i];
                    start = Math.max(1, firstStart);
                }
            }
            breakRun(run);
            while (start < run.length) {
                logAttr = run.psla + start;
                //OS.MoveMemory(logAttr, run.psla + (start * SCRIPT_LOGATTR.sizeof), SCRIPT_LOGATTR.sizeof);
                if (!logAttr.fWhiteSpace) break;
                start++;
            }
            if (0 < start && start < run.length) {
                StyleItem newRun = new StyleItem();
                newRun.start = run.start + start;
                newRun.length = run.length - start;
                newRun.style = run.style;
                newRun.analysis = cloneScriptAnalysis(run.analysis);
                run.free();
                run.length = start;
                OS.SelectObject(srcHdc, getItemFont(run));
                run.analysis.fNoGlyphIndex = false;
                shape (srcHdc, run);
                OS.SelectObject(srcHdc, getItemFont(newRun));
                newRun.analysis.fNoGlyphIndex = false;
                shape (srcHdc, newRun);
                StyleItem[] newAllRuns = new StyleItem[allRuns.length + 1];
                System.arraycopy(allRuns, 0, newAllRuns, 0, i + 1);
                System.arraycopy(allRuns, i + 1, newAllRuns, i + 2, allRuns.length - i - 1);
                allRuns = newAllRuns;
                allRuns[i + 1] = newRun;
            }
            if (i !is allRuns.length - 2) {
                run.softBreak = run.lineBreak = true;
            }
        }
        lineWidth += run.width;
        if (run.lineBreak) {
            lineStart = i + 1;
            lineWidth = run.softBreak ?  0 : indent;
            lineCount++;
        }
    }
    lineWidth = 0;
    runs = new StyleItem[][](lineCount);
    lineOffset = new int[lineCount + 1];
    lineY = new int[lineCount + 1];
    this.lineWidth = new int[lineCount];
    int lineRunCount = 0, line = 0;
    int ascent = Math.max(0, this.ascent);
    int descent = Math.max(0, this.descent);
    StyleItem[] lineRuns = new StyleItem[allRuns.length];
    for (int i=0; i<allRuns.length; i++) {
        StyleItem run = allRuns[i];
        lineRuns[lineRunCount++] = run;
        lineWidth += run.width;
        ascent = Math.max(ascent, run.ascent);
        descent = Math.max(descent, run.descent);
        if (run.lineBreak || i is allRuns.length - 1) {
            /* Update the run metrics if the last run is a hard break. */
            if (lineRunCount is 1 && i is allRuns.length - 1) {
                TEXTMETRIC lptm;
                OS.SelectObject(srcHdc, getItemFont(run));
                OS.GetTextMetrics(srcHdc, &lptm);
                run.ascent = lptm.tmAscent;
                run.descent = lptm.tmDescent;
                ascent = Math.max(ascent, run.ascent);
                descent = Math.max(descent, run.descent);
            }
            runs[line] = new StyleItem[lineRunCount];
            System.arraycopy(lineRuns, 0, runs[line], 0, lineRunCount);

            if (justify && wrapWidth !is -1 && run.softBreak && lineWidth > 0) {
                if (line is 0) {
                    lineWidth += indent;
                } else {
                    StyleItem[] previousLine = runs[line - 1];
                    StyleItem previousRun = previousLine[previousLine.length - 1];
                    if (previousRun.lineBreak && !previousRun.softBreak) {
                        lineWidth += indent;
                    }
                }
                auto hHeap = OS.GetProcessHeap();
                int newLineWidth = 0;
                for (int j = 0; j < runs[line].length; j++) {
                    StyleItem item = runs[line][j];
                    int iDx = item.width * wrapWidth / lineWidth;
                    if (iDx !is item.width) {
                        item.justify = cast(int*)OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, item.glyphCount * 4);
                        if (item.justify is null) SWT.error(SWT.ERROR_NO_HANDLES);
                        OS.ScriptJustify(item.visAttrs, item.advances, item.glyphCount, iDx - item.width, 2, item.justify);
                        item.width = iDx;
                    }
                    newLineWidth += item.width;
                }
                lineWidth = newLineWidth;
            }
            this.lineWidth[line] = lineWidth;

            StyleItem lastRun = runs[line][lineRunCount - 1];
            int lastOffset = lastRun.start + lastRun.length;
            runs[line] = reorder(runs[line], i is allRuns.length - 1);
            lastRun = runs[line][lineRunCount - 1];
            if (run.softBreak && run !is lastRun) {
                run.softBreak = run.lineBreak = false;
                lastRun.softBreak = lastRun.lineBreak = true;
            }

            lineWidth = getLineIndent(line);
            for (int j = 0; j < runs[line].length; j++) {
                runs[line][j].x = lineWidth;
                lineWidth += runs[line][j].width;
            }
            line++;
            lineY[line] = lineY[line - 1] + ascent + descent + lineSpacing;
            lineOffset[line] = lastOffset;
            lineRunCount = lineWidth = 0;
            ascent = Math.max(0, this.ascent);
            descent = Math.max(0, this.descent);
        }
    }
    if (srcHdc !is null) OS.DeleteDC(srcHdc);
    if (gc is null) device.internal_dispose_GC(hDC, null);
}

void destroy () {
    freeRuns();
    font = null;
    text = null;
    wtext = null;
    segmentsText = null;
    segmentsWText = null;
    tabs = null;
    styles = null;
    runs = null;
    lineOffset = null;
    lineY = null;
    lineWidth = null;
    if (mLangFontLink2 !is null) {
        /* Release() */
        OS.VtblCall(2, mLangFontLink2);
        mLangFontLink2 = null;
    }
    OS.OleUninitialize();
}

SCRIPT_ANALYSIS cloneScriptAnalysis ( inout SCRIPT_ANALYSIS src) {
    SCRIPT_ANALYSIS dst;
    dst.eScript = src.eScript;
    dst.fRTL = src.fRTL;
    dst.fLayoutRTL = src.fLayoutRTL;
    dst.fLinkBefore = src.fLinkBefore;
    dst.fLinkAfter = src.fLinkAfter;
    dst.fLogicalOrder = src.fLogicalOrder;
    dst.fNoGlyphIndex = src.fNoGlyphIndex;
    dst.s.uBidiLevel = src.s.uBidiLevel; 
    dst.s.fOverrideDirection = src.s.fOverrideDirection;
    dst.s.fInhibitSymSwap = src.s.fInhibitSymSwap;
    dst.s.fCharShape = src.s.fCharShape;
    dst.s.fDigitSubstitute = src.s.fDigitSubstitute;
    dst.s.fInhibitLigate = src.s.fInhibitLigate;
    dst.s.fDisplayZWG = src.s.fDisplayZWG;
    dst.s.fArabicNumContext = src.s.fArabicNumContext;
    dst.s.fGcpClusters = src.s.fGcpClusters;
    dst.s.fReserved = src.s.fReserved;
    dst.s.fEngineReserved = src.s.fEngineReserved;
    return dst;
}

/**
 * Draws the receiver's text using the specified GC at the specified
 * point.
 *
 * @param gc the GC to draw
 * @param x the x coordinate of the top left corner of the rectangular area where the text is to be drawn
 * @param y the y coordinate of the top left corner of the rectangular area where the text is to be drawn
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_NULL_ARGUMENT - if the gc is null</li>
 * </ul>
 */
public void draw (GC gc, int x, int y) {
    draw(gc, x, y, -1, -1, null, null);
}

/**
 * Draws the receiver's text using the specified GC at the specified
 * point.
 *
 * @param gc the GC to draw
 * @param x the x coordinate of the top left corner of the rectangular area where the text is to be drawn
 * @param y the y coordinate of the top left corner of the rectangular area where the text is to be drawn
 * @param selectionStart the offset where the selections starts, or -1 indicating no selection
 * @param selectionEnd the offset where the selections ends, or -1 indicating no selection
 * @param selectionForeground selection foreground, or NULL to use the system default color
 * @param selectionBackground selection background, or NULL to use the system default color
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_NULL_ARGUMENT - if the gc is null</li>
 * </ul>
 */
public void draw (GC gc, int x, int y, int selectionStart, int selectionEnd, Color selectionForeground, Color selectionBackground) {
    draw(gc, x, y, selectionStart, selectionEnd, selectionForeground, selectionBackground, 0);
}

/**
 * Draws the receiver's text using the specified GC at the specified
 * point.
 * <p>
 * The parameter <code>flags</code> can include one of <code>SWT.DELIMITER_SELECTION</code>
 * or <code>SWT.FULL_SELECTION</code> to specify the selection behavior on all lines except
 * for the last line, and can also include <code>SWT.LAST_LINE_SELECTION</code> to extend
 * the specified selection behavior to the last line.
 * </p>
 * @param gc the GC to draw
 * @param x the x coordinate of the top left corner of the rectangular area where the text is to be drawn
 * @param y the y coordinate of the top left corner of the rectangular area where the text is to be drawn
 * @param selectionStart the offset where the selections starts, or -1 indicating no selection
 * @param selectionEnd the offset where the selections ends, or -1 indicating no selection
 * @param selectionForeground selection foreground, or NULL to use the system default color
 * @param selectionBackground selection background, or NULL to use the system default color
 * @param flags drawing options
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_NULL_ARGUMENT - if the gc is null</li>
 * </ul>
 *
 * @since 3.3
 */
public void draw (GC gc, int x, int y, int selectionStart, int selectionEnd, Color selectionForeground, Color selectionBackground, int flags) {
    checkLayout();
    computeRuns(gc);
    if (gc is null) SWT.error(SWT.ERROR_NULL_ARGUMENT);
    if (gc.isDisposed()) SWT.error(SWT.ERROR_INVALID_ARGUMENT);
    if (selectionForeground !is null && selectionForeground.isDisposed()) SWT.error(SWT.ERROR_INVALID_ARGUMENT);
    if (selectionBackground !is null && selectionBackground.isDisposed()) SWT.error(SWT.ERROR_INVALID_ARGUMENT);
    int length = text.length;
    int wlength = wtext.length;
    if (length is 0 && flags is 0) return;
    auto hdc = gc.handle;
    Rectangle clip = gc.getClipping();
    GCData data = gc.data;
    auto gdipGraphics = data.gdipGraphics;
    auto foreground = data.foreground;
    auto alpha = data.alpha;
    bool gdip = gdipGraphics !is null && (alpha !is 0xFF || data.foregroundPattern !is null);
    HRGN clipRgn;
    float[] lpXform = null;
    Gdip.Rect gdipRect;
    if (gdipGraphics !is null && !gdip) {
        auto matrix = Gdip.Matrix_new(1, 0, 0, 1, 0, 0);
        if (matrix is null) SWT.error(SWT.ERROR_NO_HANDLES);
        Gdip.Graphics_GetTransform(gdipGraphics, matrix);
        auto identity_ = gc.identity();
        Gdip.Matrix_Invert(identity_);
        Gdip.Matrix_Multiply(matrix, identity_, Gdip.MatrixOrderAppend);
        Gdip.Matrix_delete(identity_);
        if (!Gdip.Matrix_IsIdentity(matrix)) {
            lpXform = new float[6];
            Gdip.Matrix_GetElements(matrix, lpXform.ptr);
        }
        Gdip.Matrix_delete(matrix);
        if ((data.style & SWT.MIRRORED) !is 0 && lpXform !is null) {
            gdip = true;
            lpXform = null;
        } else {
            Gdip.Graphics_SetPixelOffsetMode(gdipGraphics, Gdip.PixelOffsetModeNone);
            auto rgn = Gdip.Region_new();
            Gdip.Graphics_GetClip(gdipGraphics, rgn);
            if (!Gdip.Region_IsInfinite(rgn, gdipGraphics)) {
                clipRgn = Gdip.Region_GetHRGN(rgn, gdipGraphics);
            }
            Gdip.Region_delete(rgn);
            Gdip.Graphics_SetPixelOffsetMode(gdipGraphics, Gdip.PixelOffsetModeHalf);
            hdc = Gdip.Graphics_GetHDC(gdipGraphics);
        }
    }
    Gdip.Brush foregroundBrush;
    int state = 0;
    if (gdip) {
        gc.checkGC(GC.FOREGROUND);
        foregroundBrush = gc.getFgBrush();
    } else {
        state = OS.SaveDC(hdc);
        if ((data.style & SWT.MIRRORED) !is 0) {
            OS.SetLayout(hdc, OS.GetLayout(hdc) | OS.LAYOUT_RTL);
        }
        if (lpXform !is null) {
            OS.SetGraphicsMode(hdc, OS.GM_ADVANCED);
            OS.SetWorldTransform(hdc, cast(XFORM*)lpXform.ptr);
        }
        if (clipRgn !is null) {
            OS.SelectClipRgn(hdc, clipRgn);
            OS.DeleteObject(clipRgn);
        }
    }
    bool hasSelection = selectionStart <= selectionEnd && selectionStart !is -1 && selectionEnd !is -1;
    if (hasSelection || (flags & SWT.LAST_LINE_SELECTION) !is 0) {
        selectionStart = Math.min(Math.max(0, selectionStart), length - 1);
        selectionEnd = Math.min(Math.max(0, selectionEnd), length - 1);
        if (selectionForeground is null) selectionForeground = device.getSystemColor(SWT.COLOR_LIST_SELECTION_TEXT);
        if (selectionBackground is null) selectionBackground = device.getSystemColor(SWT.COLOR_LIST_SELECTION);
        selectionStart = translateOffset(selectionStart);
        selectionEnd = translateOffset(selectionEnd);
    }
    RECT rect;
    Gdip.Brush selBrush;
    Gdip.Pen selPen;
    Gdip.Brush selBrushFg;

    if (hasSelection || (flags & SWT.LAST_LINE_SELECTION) !is 0) {
        if (gdip) {
            auto bg = selectionBackground.handle;
            auto argb = ((alpha & 0xFF) << 24) | ((bg >> 16) & 0xFF) | (bg & 0xFF00) | ((bg & 0xFF) << 16);
            auto color = Gdip.Color_new(argb);
            selBrush = cast(Gdip.Brush)Gdip.SolidBrush_new(color);
            Gdip.Color_delete(color);
            auto fg = selectionForeground.handle;
            argb = ((alpha & 0xFF) << 24) | ((fg >> 16) & 0xFF) | (fg & 0xFF00) | ((fg & 0xFF) << 16);
            color = Gdip.Color_new(argb);
            selBrushFg = cast(Gdip.Brush)Gdip.SolidBrush_new(color);
            selPen = cast(Gdip.Pen) Gdip.Pen_new( cast(Gdip.Brush)selBrushFg, 1);
            Gdip.Color_delete(color);
        } else {
            selBrush = cast(Gdip.Brush)OS.CreateSolidBrush(selectionBackground.handle);
            selPen = cast(Gdip.Pen)OS.CreatePen(OS.PS_SOLID, 1, selectionForeground.handle);
        }
    }
    int offset = (orientation & SWT.RIGHT_TO_LEFT) !is 0 ? -1 : 0;
    OS.SetBkMode(hdc, OS.TRANSPARENT);
    for (int line=0; line<runs.length; line++) {
        int drawX = x + getLineIndent(line);
        int drawY = y + lineY[line];
        StyleItem[] lineRuns = runs[line];
        int lineHeight = lineY[line+1] - lineY[line] - lineSpacing;
        if (flags !is 0 && (hasSelection || (flags & SWT.LAST_LINE_SELECTION) !is 0)) {
            bool extents = false;
            if (line is runs.length - 1 && (flags & SWT.LAST_LINE_SELECTION) !is 0) {
                extents = true;
            } else {
                StyleItem run = lineRuns[lineRuns.length - 1];
                if (run.lineBreak && !run.softBreak) {
                    if (selectionStart <= run.start && run.start <= selectionEnd) extents = true;
                } else {
                    int endOffset = segmentsText.getAbsoluteCodePointOffset( run.start + run.length, -1 );
                    if (selectionStart <= endOffset && endOffset < selectionEnd && (flags & SWT.FULL_SELECTION) !is 0) {
                        extents = true;
                    }
                }
            }
            if (extents) {
                int width;
                if ((flags & SWT.FULL_SELECTION) !is 0) {
                    width = OS.IsWin95 ? 0x7FFF : 0x6FFFFFF;
                } else {
                    width = lineHeight / 3;
                }
                if (gdip) {
                    Gdip.Graphics_FillRectangle(gdipGraphics, cast(Gdip.Brush)selBrush, drawX + lineWidth[line], drawY, width, lineHeight);
                } else {
                    OS.SelectObject(hdc, selBrush);
                    OS.PatBlt(hdc, drawX + lineWidth[line], drawY, width, lineHeight, OS.PATCOPY);
                }
            }
        }
        if (drawX > clip.x + clip.width) continue;
        if (drawX + lineWidth[line] < clip.x) continue;
        int baseline = Math.max(0, this.ascent);
        int lineUnderlinePos = 0;
        for (int i = 0; i < lineRuns.length; i++) {
            baseline = Math.max(baseline, lineRuns[i].ascent);
            lineUnderlinePos = Math.min(lineUnderlinePos, lineRuns[i].underlinePos);
        }
        int alignmentX = drawX;
        for (int i = 0; i < lineRuns.length; i++) {
            StyleItem run = lineRuns[i];
            if (run.length is 0) continue;
            if (drawX > clip.x + clip.width) break;
            if (drawX + run.width >= clip.x) {
                if (!run.lineBreak || run.softBreak) {
                    int end = segmentsText.getAbsoluteCodePointOffset( run.start + run.length, -1 );
                    bool fullSelection = hasSelection && selectionStart <= run.start && selectionEnd >= end;
                    if (fullSelection) {
                        if (gdip) {
                            Gdip.Graphics_FillRectangle(gdipGraphics, cast(Gdip.Brush)selBrush, drawX, drawY, run.width, lineHeight);
                        } else {
                            OS.SelectObject(hdc, selBrush);
                            OS.PatBlt(hdc, drawX, drawY, run.width, lineHeight, OS.PATCOPY);
                        }
                    } else {
                        if (run.style !is null && run.style.background !is null) {
                            auto bg = run.style.background.handle;
                            if (gdip) {
                                int argb = ((alpha & 0xFF) << 24) | ((bg >> 16) & 0xFF) | (bg & 0xFF00) | ((bg & 0xFF) << 16);
                                auto color = Gdip.Color_new(argb);
                                auto brush = Gdip.SolidBrush_new(color);
                                Gdip.Graphics_FillRectangle(gdipGraphics, cast(Gdip.Brush)brush, drawX, drawY, run.width, lineHeight);
                                Gdip.Color_delete(color);
                                Gdip.SolidBrush_delete(brush);
                            } else {
                                auto hBrush = OS.CreateSolidBrush (bg);
                                auto oldBrush = OS.SelectObject(hdc, hBrush);
                                OS.PatBlt(hdc, drawX, drawY, run.width, lineHeight, OS.PATCOPY);
                                OS.SelectObject(hdc, oldBrush);
                                OS.DeleteObject(hBrush);
                            }
                        }
                        bool partialSelection = hasSelection && !(selectionStart > end || run.start > selectionEnd);
                        if (partialSelection) {
                            int selStart = index8to16[ Math.max(selectionStart, run.start) ] - index8to16[run.start];
                            int selEnd = index8to16[ Math.min(selectionEnd, end) ] - index8to16[ run.start ];
                            int cChars = index8to16[run.start+run.length] - index8to16[run.start]; // make it wchar
                            int gGlyphs = run.glyphCount;
                            int piX;
                            int* advances = run.justify !is null ? run.justify : run.advances;
                            OS.ScriptCPtoX(selStart, false, cChars, gGlyphs, run.clusters, run.visAttrs, advances, &run.analysis, &piX);
                            int runX = (orientation & SWT.RIGHT_TO_LEFT) !is 0 ? run.width - piX : piX;
                            rect.left = drawX + runX;
                            rect.top = drawY;
                            OS.ScriptCPtoX(selEnd, true, cChars, gGlyphs, run.clusters, run.visAttrs, advances, &run.analysis, &piX);
                            runX = (orientation & SWT.RIGHT_TO_LEFT) !is 0 ? run.width - piX : piX;
                            rect.right = drawX + runX;
                            rect.bottom = drawY + lineHeight;
                            if (gdip) {
                                if (rect.left > rect.right) {
                                    int tmp = rect.left;
                                    rect.left = rect.right;
                                    rect.right = tmp;
                                }
                                Gdip.Graphics_FillRectangle(gdipGraphics, cast(Gdip.Brush)selBrush, rect.left, rect.top, rect.right - rect.left, rect.bottom - rect.top);
                            } else {
                                OS.SelectObject(hdc, selBrush);
                                OS.PatBlt(hdc, rect.left, rect.top, rect.right - rect.left, rect.bottom - rect.top, OS.PATCOPY);
                            }
                        }
                    }
                }
            }
            drawX += run.width;
        }
        RECT* borderClip = null;
        drawX = alignmentX;
        for (int i = 0; i < lineRuns.length; i++) {
            StyleItem run = lineRuns[i];
            if (run.length is 0) continue;
            if (drawX > clip.x + clip.width) break;
            if (drawX + run.width >= clip.x) {
                if (!run.tab && (!run.lineBreak || run.softBreak) && !(run.style !is null && run.style.metrics !is null)) {
                    int end = run.start + run.length - 1;
                    bool fullSelection = hasSelection && selectionStart <= run.start && selectionEnd >= end;
                    bool partialSelection = hasSelection && !fullSelection && !(selectionStart > end || run.start > selectionEnd);
                    OS.SelectObject(hdc, getItemFont(run));
                    int drawRunY = drawY + (baseline - run.ascent);
                    if (partialSelection) {
                        int selStart = Math.max(index8to16[selectionStart], index8to16[run.start]) - index8to16[run.start];
                        int selEnd = Math.min(index8to16[selectionEnd], index8to16[end]) - index8to16[run.start];
                        int cChars = index8to16[run.start+run.length] - index8to16[run.start]; // make it wchar
                        int gGlyphs = run.glyphCount;
                        int piX;
                        int* advances = run.justify !is null ? run.justify : run.advances;
                        OS.ScriptCPtoX(selStart, false, cChars, gGlyphs, run.clusters, run.visAttrs, advances, &run.analysis, &piX);
                        int runX = (orientation & SWT.RIGHT_TO_LEFT) !is 0 ? run.width - piX : piX;
                        rect.left = drawX + runX;
                        rect.top = drawY;
                        OS.ScriptCPtoX(selEnd, true, cChars, gGlyphs, run.clusters, run.visAttrs, advances, &run.analysis, &piX);
                        runX = (orientation & SWT.RIGHT_TO_LEFT) !is 0 ? run.width - piX : piX;
                        rect.right = drawX + runX;
                        rect.bottom = drawY + lineHeight;
                    }
                    if (gdip) {
                        OS.BeginPath(hdc);
                        OS.ScriptTextOut(hdc, run.psc, drawX, drawRunY, 0, null, &run.analysis , null, 0, run.glyphs, run.glyphCount, run.advances, run.justify, run.goffsets);
                        OS.EndPath(hdc);
                        int count = OS.GetPath(hdc, null, null, 0);
                        int[] points = new int[count*2];
                        ubyte[] types = new ubyte[count];
                        OS.GetPath(hdc, cast(POINT*)points.ptr, types.ptr, count);
                        for (int typeIndex = 0; typeIndex < types.length; typeIndex++) {
                            int newType = 0;
                            int type = types[typeIndex] & 0xFF;
                            switch (type & ~OS.PT_CLOSEFIGURE) {
                                case OS.PT_MOVETO: newType = Gdip.PathPointTypeStart; break;
                                case OS.PT_LINETO: newType = Gdip.PathPointTypeLine; break;
                                case OS.PT_BEZIERTO: newType = Gdip.PathPointTypeBezier; break;
                                default:
                            }
                            if ((type & OS.PT_CLOSEFIGURE) !is 0) newType |= Gdip.PathPointTypeCloseSubpath;
                            types[typeIndex] = cast(byte)newType;
                        }
                        auto path = Gdip.GraphicsPath_new(cast(Gdip.Point*)points.ptr, types.ptr, count, Gdip.FillModeAlternate);
                        if (path is null) SWT.error(SWT.ERROR_NO_HANDLES);
                        auto brush = foregroundBrush;
                        if (fullSelection) {
                            brush = cast(Gdip.Brush)selBrushFg;
                        } else {
                            if (run.style !is null && run.style.foreground !is null) {
                                auto fg = run.style.foreground.handle;
                                int argb = ((alpha & 0xFF) << 24) | ((fg >> 16) & 0xFF) | (fg & 0xFF00) | ((fg & 0xFF) << 16);
                                auto color = Gdip.Color_new(argb);
                                brush = cast(Gdip.Brush)Gdip.SolidBrush_new(color);
                                Gdip.Color_delete(color);
                            }
                        }
                        int gstate = 0;
                        if (partialSelection) {
                            gdipRect.X = rect.left;
                            gdipRect.Y = rect.top;
                            gdipRect.Width = rect.right - rect.left;
                            gdipRect.Height = rect.bottom - rect.top;
                            gstate = Gdip.Graphics_Save(gdipGraphics);
                            Gdip.Graphics_SetClip(gdipGraphics, &gdipRect, Gdip.CombineModeExclude);
                        }
                        int antialias = Gdip.Graphics_GetSmoothingMode(gdipGraphics), textAntialias = 0;
                        int mode = Gdip.Graphics_GetTextRenderingHint(data.gdipGraphics);
                        switch (mode) {
                            case Gdip.TextRenderingHintSystemDefault: textAntialias = Gdip.SmoothingModeAntiAlias; break;
                            case Gdip.TextRenderingHintSingleBitPerPixel:
                            case Gdip.TextRenderingHintSingleBitPerPixelGridFit: textAntialias = Gdip.SmoothingModeNone; break;
                            case Gdip.TextRenderingHintAntiAlias:
                            case Gdip.TextRenderingHintAntiAliasGridFit:
                            case Gdip.TextRenderingHintClearTypeGridFit: textAntialias = Gdip.SmoothingModeAntiAlias; break;
                            default:
                        }
                        Gdip.Graphics_SetSmoothingMode(gdipGraphics, textAntialias);
                        int gstate2 = 0;
                        if ((data.style & SWT.MIRRORED) !is 0) {
                            gstate2 = Gdip.Graphics_Save(gdipGraphics);
                            Gdip.Graphics_ScaleTransform(gdipGraphics, -1, 1, Gdip.MatrixOrderPrepend);
                            Gdip.Graphics_TranslateTransform(gdipGraphics, -2 * drawX - run.width, 0, Gdip.MatrixOrderPrepend);
                        }
                        Gdip.Graphics_FillPath(gdipGraphics, brush, path);
                        if ((data.style & SWT.MIRRORED) !is 0) {
                            Gdip.Graphics_Restore(gdipGraphics, gstate2);
                        }
                        Gdip.Graphics_SetSmoothingMode(gdipGraphics, antialias);
                        drawLines(gdip, gdipGraphics, x, drawY + baseline, lineUnderlinePos, drawY + lineHeight, lineRuns, i, brush, null, alpha);
                        if (partialSelection) {
                            Gdip.Graphics_Restore(gdipGraphics, gstate);
                            gstate = Gdip.Graphics_Save(gdipGraphics);
                            Gdip.Graphics_SetClip(gdipGraphics, &gdipRect, Gdip.CombineModeIntersect);
                            Gdip.Graphics_SetSmoothingMode(gdipGraphics, textAntialias);
                            if ((data.style & SWT.MIRRORED) !is 0) {
                                gstate2 = Gdip.Graphics_Save(gdipGraphics);
                                Gdip.Graphics_ScaleTransform(gdipGraphics, -1, 1, Gdip.MatrixOrderPrepend);
                                Gdip.Graphics_TranslateTransform(gdipGraphics, -2 * drawX - run.width, 0, Gdip.MatrixOrderPrepend);
                            }
                            Gdip.Graphics_FillPath(gdipGraphics, selBrushFg, path);
                            if ((data.style & SWT.MIRRORED) !is 0) {
                                Gdip.Graphics_Restore(gdipGraphics, gstate2);
                            }
                            Gdip.Graphics_SetSmoothingMode(gdipGraphics, antialias);
                            drawLines(gdip, gdipGraphics, x, drawY + baseline, lineUnderlinePos, drawY + lineHeight, lineRuns, i, selBrushFg, &rect, alpha);
                            Gdip.Graphics_Restore(gdipGraphics, gstate);
                        }
                        borderClip = drawBorder(gdip, gdipGraphics, x, drawY, lineHeight, foregroundBrush, selBrushFg, fullSelection, borderClip, partialSelection ? &rect : null, alpha, lineRuns, i, selectionStart, selectionEnd);
                        Gdip.GraphicsPath_delete(path);
                        if ( brush !is cast(Gdip.Brush)selBrushFg && brush !is cast(Gdip.Brush)foregroundBrush)
                            Gdip.SolidBrush_delete(cast(Gdip.SolidBrush)brush);
                    }   else {
                            auto fg = foreground;
                            if (fullSelection) {
                                fg = selectionForeground.handle;
                            } else {
                                if (run.style !is null && run.style.foreground !is null) fg = run.style.foreground.handle;
                        }
                        OS.SetTextColor(hdc, fg);
                        OS.ScriptTextOut(hdc, run.psc, drawX + offset, drawRunY, 0, null, &run.analysis , null, 0, run.glyphs, run.glyphCount, run.advances, run.justify, run.goffsets);
                        drawLines(gdip, hdc, x, drawY + baseline, lineUnderlinePos, drawY + lineHeight, lineRuns, i, cast(void*)fg, null, alpha);
                        if (partialSelection && fg !is selectionForeground.handle) {
                            OS.SetTextColor(hdc, selectionForeground.handle);
                            OS.ScriptTextOut(hdc, run.psc, drawX + offset, drawRunY, OS.ETO_CLIPPED, &rect, &run.analysis , null, 0, run.glyphs, run.glyphCount, run.advances, run.justify, run.goffsets);
                            drawLines(gdip, hdc, x, drawY + baseline, lineUnderlinePos, drawY + lineHeight, lineRuns, i, cast(void*)selectionForeground.handle, &rect, alpha);
                        }
                        int selForeground = selectionForeground !is null ? selectionForeground.handle : 0;
                        borderClip = drawBorder(gdip, hdc, x, drawY, lineHeight, cast(void*)foreground, cast(void*)selForeground, fullSelection, borderClip, partialSelection ? &rect : null, alpha, lineRuns, i, selectionStart, selectionEnd);
                    }
                }
            }
            drawX += run.width;
        }
    }
    if (gdip) {
        if (selBrush !is null) Gdip.SolidBrush_delete(cast(Gdip.SolidBrush)selBrush);
        if (selBrushFg !is null) Gdip.SolidBrush_delete(cast(Gdip.SolidBrush)selBrushFg);
        if (selPen !is null) Gdip.Pen_delete(selPen);
    } else {
        OS.RestoreDC(hdc, state);
        if (gdipGraphics !is null) Gdip.Graphics_ReleaseHDC(gdipGraphics, hdc);
        if (selBrush !is null) OS.DeleteObject (selBrush);
        if (selPen !is null) OS.DeleteObject (selPen);
    }
}

void drawLines(bool advance, void* graphics, int x, int lineBaseline, int lineUnderlinePos, int lineBottom, StyleItem[] line, int index, void* color, RECT* clipRect, int alpha) {
    StyleItem run = line[index];
    TextStyle style = run.style;
    if (style is null) return;
    if (!style.underline && !style.strikeout) return;
    int runX = x + run.x;
    int underlineY = lineBaseline - lineUnderlinePos;
    int strikeoutY = lineBaseline - run.strikeoutPos;
    if (advance) {
        Gdip.Graphics_SetPixelOffsetMode(cast(Gdip.Graphics)graphics, Gdip.PixelOffsetModeNone);
        auto brush = color;
        if (style.underline) {
            if (style.underlineColor !is null) {
                int fg = style.underlineColor.handle;
                int argb = ((alpha & 0xFF) << 24) | ((fg >> 16) & 0xFF) | (fg & 0xFF00) | ((fg & 0xFF) << 16);
                auto gdiColor = Gdip.Color_new(argb);
                brush = Gdip.SolidBrush_new(gdiColor);
                Gdip.Color_delete(gdiColor);
            }
            switch (style.underlineStyle) {
                case SWT.UNDERLINE_SQUIGGLE:
                case SWT.UNDERLINE_ERROR: {
                    int squigglyThickness = 1;
                    int squigglyHeight = 2 * squigglyThickness;
                    int squigglyY = Math.min(underlineY - squigglyHeight / 2, lineBottom - squigglyHeight - 1);
                    int squigglyX = runX;
                    for (int i = index; i > 0 && style.isAdherentUnderline(line[i - 1].style); i--) {
                        squigglyX = x + line[i - 1].x;
                    }
                    int gstate = 0;
                    if (clipRect is null) {
                        gstate = Gdip.Graphics_Save(cast(Gdip.Graphics)graphics);
                        Gdip.Rect gdipRect;
                        gdipRect.X = runX;
                        gdipRect.Y = squigglyY;
                        gdipRect.Width = run.width + 1;
                        gdipRect.Height = squigglyY + squigglyHeight + 1;
                        Gdip.Graphics_SetClip(cast(Gdip.Graphics)graphics, &gdipRect, Gdip.CombineModeIntersect);
                    }
                    int[] points = computePolyline(squigglyX, squigglyY, runX + run.width, squigglyY + squigglyHeight);
                    auto pen = Gdip.Pen_new(cast(Gdip.Brush)brush, squigglyThickness);
                    Gdip.Graphics_DrawLines(cast(Gdip.Graphics)graphics, pen, cast(Gdip.Point*)points.ptr, points.length / 2);
                    Gdip.Pen_delete(pen);
                    if (gstate !is 0) Gdip.Graphics_Restore(cast(Gdip.Graphics)graphics, gstate);
                    break;
                }
                case SWT.UNDERLINE_SINGLE:
                    Gdip.Graphics_FillRectangle(cast(Gdip.Graphics)graphics, cast(Gdip.Brush)brush, runX, underlineY, run.width, run.underlineThickness);
                    break;
                case SWT.UNDERLINE_DOUBLE:
                    Gdip.Graphics_FillRectangle(cast(Gdip.Graphics)graphics, cast(Gdip.Brush)brush, runX, underlineY, run.width, run.underlineThickness);
                    Gdip.Graphics_FillRectangle(cast(Gdip.Graphics)graphics, cast(Gdip.Brush)brush, runX, underlineY + run.underlineThickness * 2, run.width, run.underlineThickness);
                    break;
                case UNDERLINE_IME_THICK:
                    Gdip.Graphics_FillRectangle(cast(Gdip.Graphics)graphics, cast(Gdip.Brush)brush, runX - run.underlineThickness, underlineY, run.width, run.underlineThickness * 2);
                    break;
                case UNDERLINE_IME_DOT:
                case UNDERLINE_IME_DASH: {
                    auto pen = Gdip.Pen_new(cast(Gdip.Brush)brush, 1);
                    int dashStyle = style.underlineStyle is UNDERLINE_IME_DOT ? Gdip.DashStyleDot : Gdip.DashStyleDash;
                    Gdip.Pen_SetDashStyle(pen, dashStyle);
                    Gdip.Graphics_DrawLine(cast(Gdip.Graphics)graphics, pen, runX, underlineY, runX + run.width, underlineY);
                    Gdip.Pen_delete(pen);
                    break;
                }
                default:
            }
            if (brush !is color) Gdip.SolidBrush_delete(cast(Gdip.SolidBrush)brush);
        }
        if (style.strikeout) {
            if (style.strikeoutColor !is null) {
                int fg = style.strikeoutColor.handle;
                int argb = ((alpha & 0xFF) << 24) | ((fg >> 16) & 0xFF) | (fg & 0xFF00) | ((fg & 0xFF) << 16);
                auto gdiColor = Gdip.Color_new(argb);
                brush = Gdip.SolidBrush_new(gdiColor);
                Gdip.Color_delete(gdiColor);
            }
            Gdip.Graphics_FillRectangle(cast(Gdip.Graphics)graphics, cast(Gdip.Brush)brush, runX, strikeoutY, run.width, run.strikeoutThickness);
            if (brush !is color) Gdip.SolidBrush_delete(cast(Gdip.SolidBrush)brush);
        }
        Gdip.Graphics_SetPixelOffsetMode(cast(Gdip.Graphics)graphics, Gdip.PixelOffsetModeHalf);
    } else {
        uint colorRefUnderline = cast(uint)color;
        uint colorRefStrikeout = cast(uint)color;
        int /*long*/ brushUnderline = 0;
        int /*long*/ brushStrikeout = 0;
        RECT rect;
        if (style.underline) {
            if (style.underlineColor !is null) {
                colorRefUnderline = style.underlineColor.handle;
            }
            switch (style.underlineStyle) {
                case SWT.UNDERLINE_SQUIGGLE:
                case SWT.UNDERLINE_ERROR: {
                    int squigglyThickness = 1;
                    int squigglyHeight = 2 * squigglyThickness;
                    int squigglyY = Math.min(underlineY - squigglyHeight / 2, lineBottom - squigglyHeight - 1);
                    int squigglyX = runX;
                    for (int i = index; i > 0 && style.isAdherentUnderline(line[i - 1].style); i--) {
                        squigglyX = x + line[i - 1].x;
                    }
                    int state = OS.SaveDC(graphics);
                    if (clipRect !is null) {
                        OS.IntersectClipRect(graphics, clipRect.left, clipRect.top, clipRect.right, clipRect.bottom);
                    } else {
                        OS.IntersectClipRect(graphics, runX, squigglyY, runX + run.width + 1, squigglyY + squigglyHeight + 1);
                    }
                    int[] points = computePolyline(squigglyX, squigglyY, runX + run.width, squigglyY + squigglyHeight);
                    auto pen = OS.CreatePen(OS.PS_SOLID, squigglyThickness, colorRefUnderline);
                    auto oldPen = OS.SelectObject(graphics, pen);
                    OS.Polyline(graphics, cast(POINT*)points.ptr, points.length / 2);
                    int length_ = points.length;
                    if (length_ >= 2 && squigglyThickness <= 1) {
                        OS.SetPixel (graphics, points[length_ - 2], points[length_ - 1], colorRefUnderline);
                    }
                    OS.RestoreDC(graphics, state);
                    OS.SelectObject(graphics, oldPen);
                    OS.DeleteObject(pen);
                    break;
                }
                case SWT.UNDERLINE_SINGLE:
                    brushUnderline = cast(uint) OS.CreateSolidBrush(colorRefUnderline);
                    OS.SetRect(&rect, runX, underlineY, runX + run.width, underlineY + run.underlineThickness);
                    if (clipRect !is null) {
                        rect.left = Math.max(rect.left, clipRect.left);
                        rect.right = Math.min(rect.right, clipRect.right);
                    }
                    OS.FillRect(graphics, &rect, cast(void*)brushUnderline);
                    break;
                case SWT.UNDERLINE_DOUBLE:
                    brushUnderline = cast(uint)OS.CreateSolidBrush(colorRefUnderline);
                    OS.SetRect(&rect, runX, underlineY, runX + run.width, underlineY + run.underlineThickness);
                    if (clipRect !is null) {
                        rect.left = Math.max(rect.left, clipRect.left);
                        rect.right = Math.min(rect.right, clipRect.right);
                    }
                    OS.FillRect(graphics, &rect, cast(void*)brushUnderline);
                    OS.SetRect(&rect, runX, underlineY + run.underlineThickness * 2, runX + run.width, underlineY + run.underlineThickness * 3);
                    if (clipRect !is null) {
                        rect.left = Math.max(rect.left, clipRect.left);
                        rect.right = Math.min(rect.right, clipRect.right);
                    }
                    OS.FillRect(graphics, &rect,  cast(void*)brushUnderline);
                    break;
                case UNDERLINE_IME_THICK:
                    brushUnderline = cast(uint)OS.CreateSolidBrush(colorRefUnderline);
                    OS.SetRect(&rect, runX, underlineY - run.underlineThickness, runX + run.width, underlineY + run.underlineThickness);
                    if (clipRect !is null) {
                        rect.left = Math.max(rect.left, clipRect.left);
                        rect.right = Math.min(rect.right, clipRect.right);
                    }
                    OS.FillRect(graphics, &rect,  cast(void*)brushUnderline);
                    break;
                case UNDERLINE_IME_DASH:
                case UNDERLINE_IME_DOT: {
                    underlineY = lineBaseline + run.descent;
                    int penStyle = style.underlineStyle is UNDERLINE_IME_DASH ? OS.PS_DASH : OS.PS_DOT;
                    auto pen = OS.CreatePen(penStyle, 1, colorRefUnderline);
                    auto oldPen = OS.SelectObject(graphics, pen);
                    OS.SetRect(&rect, runX, underlineY, runX + run.width, underlineY + run.underlineThickness);
                    if (clipRect !is null) {
                        rect.left = Math.max(rect.left, clipRect.left);
                        rect.right = Math.min(rect.right, clipRect.right);
                    }
                    OS.MoveToEx(graphics, rect.left, rect.top, null);
                    OS.LineTo(graphics, rect.right, rect.top);
                    OS.SelectObject(graphics, oldPen);
                    OS.DeleteObject(pen);
                    break;
                }
                default:
            }
        }
        if (style.strikeout) {
            if (style.strikeoutColor !is null) {
                colorRefStrikeout = style.strikeoutColor.handle;
            }
            if (brushUnderline !is 0 && colorRefStrikeout is colorRefUnderline) {
                brushStrikeout = brushUnderline;
            } else {
                brushStrikeout = cast(int) OS.CreateSolidBrush(colorRefStrikeout);
            }
            OS.SetRect(&rect, runX, strikeoutY, runX + run.width, strikeoutY + run.strikeoutThickness);
            if (clipRect !is null) {
                rect.left = Math.max(rect.left, clipRect.left);
                rect.right = Math.min(rect.right, clipRect.right);
            }
            OS.FillRect(graphics, &rect, cast(void*)brushStrikeout);
        }
        if (brushUnderline !is 0) OS.DeleteObject(cast(void*)brushUnderline);
        if (brushStrikeout !is 0 && brushStrikeout !is brushUnderline) OS.DeleteObject(cast(void*)brushStrikeout);
    }
}

RECT* drawBorder(bool advance, void* graphics, int x, int y, int lineHeight, void* color, void* selectionColor, bool fullSelection, RECT* clipRect, RECT* rect, int alpha, StyleItem[] line, int index, int selectionStart, int selectionEnd) {
    StyleItem run = line[index];
    TextStyle style = run.style;
    if (style is null) return null;
    if (style.borderStyle is SWT.NONE) return null;
    if (rect !is null) {
        if (clipRect is null) {
            clipRect = new RECT ();
            OS.SetRect(clipRect, -1, rect.top, -1, rect.bottom);
        }
        bool isRTL = (orientation & SWT.RIGHT_TO_LEFT) !is 0;
        if (run.start <= selectionStart && selectionStart <= run.start + run.length) {
            if (run.analysis.fRTL ^ isRTL) {
                clipRect.right = rect.left;
            } else {
                clipRect.left = rect.left;
            }
        }
        if (run.start <= selectionEnd && selectionEnd <= run.start + run.length) {
            if (run.analysis.fRTL ^ isRTL) {
                clipRect.left = rect.right;
            } else {
                clipRect.right = rect.right;
            }
        }
    }
    if (index + 1 >= line.length || !style.isAdherentBorder(line[index + 1].style)) {
        int left = run.x;
        for (int i = index; i > 0 && style.isAdherentBorder(line[i - 1].style); i--) {
            left = line[i - 1].x;
        }
        if (advance) {
            auto brush = color;
            int customColor = -1;
            if (style.borderColor !is null) {
                customColor = style.borderColor.handle;
            } else {
                if (style.foreground !is null) {
                    customColor = style.foreground.handle;
                }
                if (fullSelection && clipRect is null) {
                    customColor = -1;
                    brush = selectionColor;
                }
            }
            if (customColor !is -1) {
                int argb = ((alpha & 0xFF) << 24) | ((customColor >> 16) & 0xFF) | (customColor & 0xFF00) | ((customColor & 0xFF) << 16);
                auto gdiColor = Gdip.Color_new(argb);
                brush = Gdip.SolidBrush_new(gdiColor);
                Gdip.Color_delete(gdiColor);
            }
            int lineWidth = 1;
            int lineStyle = Gdip.DashStyleSolid;
            switch (style.borderStyle) {
                case SWT.BORDER_SOLID: break;
                case SWT.BORDER_DASH: lineStyle = Gdip.DashStyleDash; break;
                case SWT.BORDER_DOT: lineStyle = Gdip.DashStyleDot; break;
                default:
            }
            auto pen = Gdip.Pen_new(cast(Gdip.Brush)brush, lineWidth);
            Gdip.Pen_SetDashStyle(pen, lineStyle);
            float gdipXOffset = 0.5f, gdipYOffset = 0.5f;
            Gdip.Graphics_TranslateTransform(cast(Gdip.Graphics)graphics, gdipXOffset, gdipYOffset, Gdip.MatrixOrderPrepend);
            if (style.borderColor is null && clipRect !is null) {
                int gstate = Gdip.Graphics_Save(cast(Gdip.Graphics)graphics);
                if (clipRect.left is -1) clipRect.left = 0;
                if (clipRect.right is -1) clipRect.right = 0x7ffff;
                Gdip.Rect gdipRect;
                gdipRect.X = clipRect.left;
                gdipRect.Y = clipRect.top;
                gdipRect.Width = clipRect.right - clipRect.left;
                gdipRect.Height = clipRect.bottom - clipRect.top;
                Gdip.Graphics_SetClip(cast(Gdip.Graphics)graphics, &gdipRect, Gdip.CombineModeExclude);
                Gdip.Graphics_DrawRectangle(cast(Gdip.Graphics)graphics, pen, x + left, y, run.x + run.width - left - 1, lineHeight - 1);
                Gdip.Graphics_Restore(cast(Gdip.Graphics)graphics, gstate);
                gstate = Gdip.Graphics_Save(cast(Gdip.Graphics)graphics);
                Gdip.Graphics_SetClip(cast(Gdip.Graphics)graphics, &gdipRect, Gdip.CombineModeIntersect);
                auto selPen = Gdip.Pen_new(cast(Gdip.Brush)selectionColor, lineWidth);
                Gdip.Pen_SetDashStyle(pen, lineStyle);
                Gdip.Graphics_DrawRectangle(cast(Gdip.Graphics)graphics, selPen, x + left, y, run.x + run.width - left - 1, lineHeight - 1);
                Gdip.Pen_delete(selPen);
                Gdip.Graphics_Restore(cast(Gdip.Graphics)graphics, gstate);
            } else {
                Gdip.Graphics_DrawRectangle(cast(Gdip.Graphics)graphics, pen, x + left, y, run.x + run.width - left - 1, lineHeight - 1);
            }
            Gdip.Graphics_TranslateTransform(cast(Gdip.Graphics)graphics, -gdipXOffset, -gdipYOffset, Gdip.MatrixOrderPrepend);
            Gdip.Pen_delete(pen);
            if (customColor !is -1) Gdip.SolidBrush_delete(cast(Gdip.SolidBrush)brush);
        } else {
            if (style.borderColor !is null) {
                color = cast(void*)style.borderColor.handle;
            } else {
                if (style.foreground !is null) {
                    color = cast(void*)style.foreground.handle;
                }
                if (fullSelection && clipRect is null) {
                    color = selectionColor;
                }
            }
            int lineWidth = 1;
            int lineStyle = OS.PS_SOLID;
            switch (style.borderStyle) {
                case SWT.BORDER_SOLID: break;
                case SWT.BORDER_DASH: lineStyle = OS.PS_DASH; break;
                case SWT.BORDER_DOT: lineStyle = OS.PS_DOT; break;
                default:
            }
            LOGBRUSH logBrush;
            logBrush.lbStyle = OS.BS_SOLID;
            logBrush.lbColor = cast(uint)color;
            auto newPen = OS.ExtCreatePen(lineStyle | OS.PS_GEOMETRIC, Math.max(1, lineWidth), &logBrush, 0, null);
            auto oldPen = OS.SelectObject(graphics, newPen);
            auto oldBrush = OS.SelectObject(graphics, OS.GetStockObject(OS.NULL_BRUSH));
            OS.Rectangle(graphics, x + left, y, x + run.x + run.width, y + lineHeight);
            if (style.borderColor is null && clipRect !is null && color !is selectionColor) {
                int state = OS.SaveDC(graphics);
                if (clipRect.left is -1) clipRect.left = 0;
                if (clipRect.right is -1) clipRect.right = 0x7ffff;
                OS.IntersectClipRect(graphics, clipRect.left, clipRect.top, clipRect.right, clipRect.bottom);
                logBrush.lbColor = cast(uint)selectionColor;
                auto selPen = OS.ExtCreatePen (lineStyle | OS.PS_GEOMETRIC, Math.max(1, lineWidth), &logBrush, 0, null);
                OS.SelectObject(graphics, selPen);
                OS.Rectangle(graphics, x + left, y, x + run.x + run.width, y + lineHeight);
                OS.RestoreDC(graphics, state);
                OS.SelectObject(graphics, newPen);
                OS.DeleteObject(selPen);
            }
            OS.SelectObject(graphics, oldBrush);
            OS.SelectObject(graphics, oldPen);
            OS.DeleteObject(newPen);
        }
        return null;
    }
    return clipRect;
}

int[] computePolyline(int left, int top, int right, int bottom) {
    int height = bottom - top; // can be any number
    int width = 2 * height; // must be even
    int peaks = Compatibility.ceil(right - left, width);
    if (peaks is 0 && right - left > 2) {
        peaks = 1;
    }
    int length_ = ((2 * peaks) + 1) * 2;
    if (length_ < 0) return new int[0];

    int[] coordinates = new int[length_];
    for (int i = 0; i < peaks; i++) {
        int index = 4 * i;
        coordinates[index] = left + (width * i);
        coordinates[index+1] = bottom;
        coordinates[index+2] = coordinates[index] + width / 2;
        coordinates[index+3] = top;
    }
    coordinates[length_-2] = left + (width * peaks);
    coordinates[length_-1] = bottom;
    return coordinates;
}

void freeRuns () {
    if (allRuns is null) return;
    for (int i=0; i<allRuns.length; i++) {
        StyleItem run = allRuns[i];
        run.free();
    }
    allRuns = null;
    runs = null;
    segmentsText = null;
    segmentsWText = null;
}

/**
 * Returns the receiver's horizontal text alignment, which will be one
 * of <code>SWT.LEFT</code>, <code>SWT.CENTER</code> or
 * <code>SWT.RIGHT</code>.
 *
 * @return the alignment used to positioned text horizontally
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public int getAlignment () {
    checkLayout();
    return alignment;
}

/**
 * Returns the ascent of the receiver.
 *
 * @return the ascent
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #getDescent()
 * @see #setDescent(int)
 * @see #setAscent(int)
 * @see #getLineMetrics(int)
 */
public int getAscent () {
    checkLayout();
    return ascent;
}

/**
 * Returns the bounds of the receiver. The width returned is either the
 * width of the longest line or the width set using {@link TextLayout#setWidth(int)}.
 * To obtain the text bounds of a line use {@link TextLayout#getLineBounds(int)}.
 *
 * @return the bounds of the receiver
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #setWidth(int)
 * @see #getLineBounds(int)
 */
public Rectangle getBounds () {
    checkLayout();
    computeRuns(null);
    int width = 0;
    if (wrapWidth !is -1) {
        width = wrapWidth;
    } else {
        for (int line=0; line<runs.length; line++) {
            width = Math.max(width, lineWidth[line] + getLineIndent(line));
        }
    }
    return new Rectangle (0, 0, width, lineY[lineY.length - 1]);
}

/**
 * Returns the bounds for the specified range of characters. The
 * bounds is the smallest rectangle that encompasses all characters
 * in the range. The start and end offsets are inclusive and will be
 * clamped if out of range.
 *
 * @param start the start offset
 * @param end the end offset
 * @return the bounds of the character range
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public Rectangle getBounds (int start, int end) {
    checkLayout();
    computeRuns(null);
    int length = text.length;
    if (length is 0) return new Rectangle(0, 0, 0, 0);
    if (start > end) return new Rectangle(0, 0, 0, 0);
    start = Math.min(Math.max(0, start), length - 1);
    end = Math.min(Math.max(0, end), length - 1);
    start = translateOffset(start);
    end = translateOffset(end);
    int left = 0x7fffffff, right = 0;
    int top = 0x7fffffff, bottom = 0;
    bool isRTL = (orientation & SWT.RIGHT_TO_LEFT) !is 0;
    for (int i = 0; i < allRuns.length - 1; i++) {
        StyleItem run = allRuns[i];
        int runEnd = run.start + run.length;
        if (runEnd <= start) continue;
        if (run.start > end) break;
        int runLead = run.x;
        int runTrail = run.x + run.width;
        if (run.start <= start && start < runEnd) {
            int cx = 0;
            if (run.style !is null && run.style.metrics !is null) {
                GlyphMetrics metrics = run.style.metrics;
                cx = metrics.width * (index8to16[start] - index8to16[run.start]);
            } else if (!run.tab) {
                int piX;
                int* advances = run.justify !is null ? run.justify : run.advances;
                int wlength = index8to16[ run.start+run.length] - index8to16[run.start];
                OS.ScriptCPtoX(index8to16[start] - index8to16[run.start], false, wlength, run.glyphCount, run.clusters, run.visAttrs, advances, &run.analysis, &piX);
                cx = isRTL ? run.width - piX : piX;
            }
            if (run.analysis.fRTL ^ isRTL) {
                runTrail = run.x + cx;
            } else {
                runLead = run.x + cx;
            }
        }
        if (run.start <= end && end < runEnd) {
            int cx = run.width;
            if (run.style !is null && run.style.metrics !is null) {
                GlyphMetrics metrics = run.style.metrics;
                cx = metrics.width * (index8to16[end] - index8to16[run.start] + 1);
            } else if (!run.tab) {
                int piX;
                int* advances = run.justify !is null ? run.justify : run.advances;
                int wlength = index8to16[ run.start+run.length] - index8to16[run.start];
                OS.ScriptCPtoX(index8to16[end] - index8to16[run.start], true, wlength, run.glyphCount, run.clusters, run.visAttrs, advances, &run.analysis, &piX);
                cx = isRTL ? run.width - piX : piX;
            }
            if (run.analysis.fRTL ^ isRTL) {
                runLead = run.x + cx;
            } else {
                runTrail = run.x + cx;
            }
        }
        int lineIndex = 0;
        while (lineIndex < runs.length && lineOffset[lineIndex + 1] <= run.start) {
            lineIndex++;
        }
        left = Math.min(left, runLead);
        right = Math.max(right, runTrail);
        top = Math.min(top, lineY[lineIndex]);
        bottom = Math.max(bottom, lineY[lineIndex + 1] - lineSpacing);
    }
    return new Rectangle(left, top, right - left, bottom - top);
}

/**
 * Returns the descent of the receiver.
 *
 * @return the descent
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #getAscent()
 * @see #setAscent(int)
 * @see #setDescent(int)
 * @see #getLineMetrics(int)
 */
public int getDescent () {
    checkLayout();
    return descent;
}

/**
 * Returns the default font currently being used by the receiver
 * to draw and measure text.
 *
 * @return the receiver's font
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public Font getFont () {
    checkLayout();
    return font;
}

/**
* Returns the receiver's indent.
*
* @return the receiver's indent
*
* @exception SWTException <ul>
*    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
* </ul>
*
* @since 3.2
*/
public int getIndent () {
    checkLayout();
    return indent;
}

/**
* Returns the receiver's justification.
*
* @return the receiver's justification
*
* @exception SWTException <ul>
*    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
* </ul>
*
* @since 3.2
*/
public bool getJustify () {
    checkLayout();
    return justify;
}

HFONT getItemFont (StyleItem item) {
    if (item.fallbackFont !is null) return cast(HFONT) item.fallbackFont;
    if (item.style !is null && item.style.font !is null) {
        return item.style.font.handle;
    }
    if (this.font !is null) {
        return this.font.handle;
    }
    return device.systemFont.handle;
}

/**
 * Returns the embedding level for the specified character offset. The
 * embedding level is usually used to determine the directionality of a
 * character in bidirectional text.
 *
 * @param offset the character offset
 * @return the embedding level
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the character offset is out of range</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 */
public int getLevel (int offset) {
    checkLayout();
    computeRuns(null);
    int length = text.length;
    if (!(0 <= offset && offset <= length)) SWT.error(SWT.ERROR_INVALID_RANGE);
    offset = translateOffset(offset);
    for (int i=1; i<allRuns.length; i++) {
        if (allRuns[i].start > offset) {
            return allRuns[i - 1].analysis.s.uBidiLevel;
        }
    }
    return (orientation & SWT.RIGHT_TO_LEFT) !is 0 ? 1 : 0;
}

/**
 * Returns the bounds of the line for the specified line index.
 *
 * @param lineIndex the line index
 * @return the line bounds
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the line index is out of range</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public Rectangle getLineBounds(int lineIndex) {
    checkLayout();
    computeRuns(null);
    if (!(0 <= lineIndex && lineIndex < runs.length)) SWT.error(SWT.ERROR_INVALID_RANGE);
    int x = getLineIndent(lineIndex);
    int y = lineY[lineIndex];
    int width = lineWidth[lineIndex];
    int height = lineY[lineIndex + 1] - y - lineSpacing;
    return new Rectangle (x, y, width, height);
}

/**
 * Returns the receiver's line count. This includes lines caused
 * by wrapping.
 *
 * @return the line count
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public int getLineCount () {
    checkLayout();
    computeRuns(null);
    return runs.length;
}

int getLineIndent (int lineIndex) {
    int lineIndent = 0;
    if (lineIndex is 0) {
        lineIndent = indent;
    } else {
        StyleItem[] previousLine = runs[lineIndex - 1];
        StyleItem previousRun = previousLine[previousLine.length - 1];
        if (previousRun.lineBreak && !previousRun.softBreak) {
            lineIndent = indent;
        }
    }
    if (wrapWidth !is -1) {
        bool partialLine = true;
        if (justify) {
            StyleItem[] lineRun = runs[lineIndex];
            if (lineRun[lineRun.length - 1].softBreak) {
                partialLine = false;
            }
        }
        if (partialLine) {
            int lineWidth = this.lineWidth[lineIndex] + lineIndent;
            switch (alignment) {
                case SWT.CENTER: lineIndent += (wrapWidth - lineWidth) / 2; break;
                case SWT.RIGHT: lineIndent += wrapWidth - lineWidth; break;
                default:
            }
        }
    }
    return lineIndent;
}

/**
 * Returns the index of the line that contains the specified
 * character offset.
 *
 * @param offset the character offset
 * @return the line index
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the character offset is out of range</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public int getLineIndex (int offset) {
    checkLayout();
    computeRuns(null);
    int length = text.length;
    if (!(0 <= offset && offset <= length)) SWT.error(SWT.ERROR_INVALID_RANGE);
    offset = translateOffset(offset);
    for (int line=0; line<runs.length; line++) {
        if (lineOffset[line + 1] > offset) {
            return line;
        }
    }
    return runs.length - 1;
}

/**
 * Returns the font metrics for the specified line index.
 *
 * @param lineIndex the line index
 * @return the font metrics
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the line index is out of range</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public FontMetrics getLineMetrics (int lineIndex) {
    checkLayout();
    computeRuns(null);
    if (!(0 <= lineIndex && lineIndex < runs.length)) SWT.error(SWT.ERROR_INVALID_RANGE);
    auto hDC = device.internal_new_GC(null);
    auto srcHdc = OS.CreateCompatibleDC(hDC);
    TEXTMETRIC lptm;
    OS.SelectObject(srcHdc, font !is null ? font.handle : device.systemFont.handle);
    OS.GetTextMetrics(srcHdc, &lptm);
    OS.DeleteDC(srcHdc);
    device.internal_dispose_GC(hDC, null);

    int ascent = Math.max(lptm.tmAscent, this.ascent);
    int descent = Math.max(lptm.tmDescent, this.descent);
    int leading = lptm.tmInternalLeading;
    if (text.length !is 0) {
        StyleItem[] lineRuns = runs[lineIndex];
        for (int i = 0; i<lineRuns.length; i++) {
            StyleItem run = lineRuns[i];
            if (run.ascent > ascent) {
                ascent = run.ascent;
                leading = run.leading;
            }
            descent = Math.max(descent, run.descent);
        }
    }
    lptm.tmAscent = ascent;
    lptm.tmDescent = descent;
    lptm.tmHeight = ascent + descent;
    lptm.tmInternalLeading = leading;
    lptm.tmAveCharWidth = 0;
    return FontMetrics.win32_new(&lptm);
}

/**
 * Returns the line offsets.  Each value in the array is the
 * offset for the first character in a line except for the last
 * value, which contains the length of the text.
 *
 * @return the line offsets
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public int[] getLineOffsets () {
    checkLayout();
    computeRuns(null);
    int[] offsets = new int[lineOffset.length];
    for (int i = 0; i < offsets.length; i++) {
        offsets[i] = untranslateOffset(lineOffset[i]);
    }
    return offsets;
}

/**
 * Returns the location for the specified character offset. The
 * <code>trailing</code> argument indicates whether the offset
 * corresponds to the leading or trailing edge of the cluster.
 *
 * @param offset the character offset
 * @param trailing the trailing flag
 * @return the location of the character offset
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #getOffset(Point, int[])
 * @see #getOffset(int, int, int[])
 */
public Point getLocation (int offset, bool trailing) {
    checkLayout();
    computeRuns(null);
    int length = text.length;
    if (!(0 <= offset && offset <= length)) SWT.error(SWT.ERROR_INVALID_RANGE);
    length = segmentsText.length;
    offset = translateOffset(offset);
    int line;
    for (line=0; line<runs.length; line++) {
        if (lineOffset[line + 1] > offset) break;
    }
    line = Math.min(line, runs.length - 1);
    if (offset is length) {
        return new Point(getLineIndent(line) + lineWidth[line], lineY[line]);
    }
    int low = -1;
    int high = allRuns.length;
    while (high - low > 1) {
        int index = ((high + low) / 2);
        StyleItem run = allRuns[index];
        if (run.start > offset) {
            high = index;
        } else if (run.start + run.length <= offset) {
            low = index;
        } else {
            int width;
            if (run.style !is null && run.style.metrics !is null) {
                GlyphMetrics metrics = run.style.metrics;
                width = metrics.width * (offset - run.start + (trailing ? 1 : 0));
            } else if (run.tab) {
                width = (trailing || (offset is length)) ? run.width : 0;
            } else {
                int runOffset = index8to16[offset] - index8to16[run.start];
                int cChars = index8to16[run.start+run.length] - index8to16[run.start]; // make it wchar
                int gGlyphs = run.glyphCount;
                int piX;
                int* advances = run.justify !is null ? run.justify : run.advances;
                OS.ScriptCPtoX(runOffset, trailing, cChars, gGlyphs, run.clusters, run.visAttrs, advances, &run.analysis, &piX);
                width = (orientation & SWT.RIGHT_TO_LEFT) !is 0 ? run.width - piX : piX;
            }
            return new Point(run.x + width, lineY[line]);
        }
    }
    return new Point(0, 0);
}

/**
 * Returns the next offset for the specified offset and movement
 * type.  The movement is one of <code>SWT.MOVEMENT_CHAR</code>,
 * <code>SWT.MOVEMENT_CLUSTER</code>, <code>SWT.MOVEMENT_WORD</code>,
 * <code>SWT.MOVEMENT_WORD_END</code> or <code>SWT.MOVEMENT_WORD_START</code>.
 *
 * @param offset the start offset
 * @param movement the movement type
 * @return the next offset
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the offset is out of range</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #getPreviousOffset(int, int)
 */
public int getNextOffset (int offset, int movement) {
    checkLayout();
    return _getOffset (offset, movement, true);
}

int _getOffset(int offset, int movement, bool forward) {
    computeRuns(null);
    int length = text.length;
    if (!(0 <= offset && offset <= length)) SWT.error(SWT.ERROR_INVALID_RANGE);
    if (forward && offset is length) return length;
    if (!forward && offset is 0) return 0;
    int step = forward ? 1 : -1;
    if ((movement & SWT.MOVEMENT_CHAR) !is 0) return offset + step;
    length = segmentsText.length;
    offset = translateOffset(offset);
    SCRIPT_LOGATTR* logAttr;
    SCRIPT_PROPERTIES* properties;
    int i = forward ? 0 : allRuns.length - 1;
    offset = validadeOffset(offset, step);
    do {
        StyleItem run = allRuns[i];
        if (run.start <= offset && offset < run.start + run.length) {
            if (run.lineBreak && !run.softBreak) return untranslateOffset(run.start);
            if (run.tab) return untranslateOffset(run.start);
            properties = device.scripts[run.analysis.eScript];
            bool isComplex = properties.fNeedsCaretInfo || properties.fNeedsWordBreaking;
            if (isComplex) breakRun(run);
            while (run.start <= offset && offset < run.start + run.length) {
                if (isComplex) {
                    logAttr = run.psla + (index8to16[offset] - index8to16[run.start]);
                }
                switch (movement) {
                    case SWT.MOVEMENT_CLUSTER: {
                        if (properties.fNeedsCaretInfo) {
                            if (!logAttr.fInvalid && logAttr.fCharStop) return untranslateOffset(offset);
                        } else {
                            return untranslateOffset(offset);
                        }
                        break;
                    }
                    case SWT.MOVEMENT_WORD_START:
                    case SWT.MOVEMENT_WORD: {
                        if (properties.fNeedsWordBreaking) {
                            if (!logAttr.fInvalid && logAttr.fWordStop) return untranslateOffset(offset);
                        } else {
                            if (offset > 0) {
                                bool letterOrDigit = Compatibility.isLetterOrDigit(segmentsText.charAt(offset));
                                bool previousLetterOrDigit = Compatibility.isLetterOrDigit(segmentsText.charAt(offset - 1));
                                if (letterOrDigit !is previousLetterOrDigit || !letterOrDigit) {
                                    if (!Compatibility.isWhitespace(segmentsText[offset..$].firstCodePoint())) {
                                        return untranslateOffset(offset);
                                    }
                                }
                            }
                        }
                        break;
                    }
                    case SWT.MOVEMENT_WORD_END: {
                        if (offset > 0) {
                            bool isLetterOrDigit = Compatibility.isLetterOrDigit(segmentsText.charAt(offset));
                            bool previousLetterOrDigit = Compatibility.isLetterOrDigit(segmentsText[offset - 1.. $].firstCodePoint());
                            if (!isLetterOrDigit && previousLetterOrDigit) {
                                return untranslateOffset(offset);
                            }
                        }
                        break;
                    }
                    default:
                }
                offset = validadeOffset(offset, step);
            }
        }
        i += step;
    } while (0 <= i && i < allRuns.length - 1 && 0 <= offset && offset < length);
    return forward ? text.length : 0;
}

/**
 * Returns the character offset for the specified point.
 * For a typical character, the trailing argument will be filled in to
 * indicate whether the point is closer to the leading edge (0) or
 * the trailing edge (1).  When the point is over a cluster composed
 * of multiple characters, the trailing argument will be filled with the
 * position of the character in the cluster that is closest to
 * the point.
 *
 * @param point the point
 * @param trailing the trailing buffer
 * @return the character offset
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the trailing length is less than <code>1</code></li>
 *    <li>ERROR_NULL_ARGUMENT - if the point is null</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #getLocation(int, bool)
 */
public int getOffset (Point point, int[] trailing) {
    checkLayout();
    if (point is null) SWT.error (SWT.ERROR_NULL_ARGUMENT);
    return getOffset (point.x, point.y, trailing) ;
}

/**
 * Returns the character offset for the specified point.
 * For a typical character, the trailing argument will be filled in to
 * indicate whether the point is closer to the leading edge (0) or
 * the trailing edge (1).  When the point is over a cluster composed
 * of multiple characters, the trailing argument will be filled with the
 * position of the character in the cluster that is closest to
 * the point.
 *
 * @param x the x coordinate of the point
 * @param y the y coordinate of the point
 * @param trailing the trailing buffer
 * @return the character offset
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the trailing length is less than <code>1</code></li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #getLocation(int, bool)
 */
public int getOffset (int x, int y, int[] trailing) {
    checkLayout();
    computeRuns(null);
    if (trailing !is null && trailing.length < 1) SWT.error(SWT.ERROR_INVALID_ARGUMENT);

    int line;
    int lineCount = runs.length;
    for (line=0; line<lineCount; line++) {
        if (lineY[line + 1] > y) break;
    }
    line = Math.min(line, runs.length - 1);
    StyleItem[] lineRuns = runs[line];
    int lineIndent = getLineIndent(line);
    if (x >= lineIndent + lineWidth[line]) x = lineIndent + lineWidth[line] - 1;
    if (x < lineIndent) x = lineIndent;
    int low = -1;
    int high = lineRuns.length;
    while (high - low > 1) {
        int index = ((high + low) / 2);
        StyleItem run = lineRuns[index];
        if (run.x > x) {
            high = index;
        } else if (run.x + run.width <= x) {
            low = index;
        } else {
            if (run.lineBreak && !run.softBreak) return untranslateOffset(run.start);
            int xRun = x - run.x;
            if (run.style !is null && run.style.metrics !is null) {
                GlyphMetrics metrics = run.style.metrics;
                if (metrics.width > 0) {
                    if (trailing !is null) {
                        trailing[0] = (xRun % metrics.width < metrics.width / 2) ? 0 : 1;
                    }
                    return untranslateOffset(run.start + xRun / metrics.width);
                }
            }
            if (run.tab) {
                if (trailing !is null) trailing[0] = x < (run.x + run.width / 2) ? 0 : 1;
                return untranslateOffset(run.start);
            }
            int cChars = index8to16[run.start+run.length] - index8to16[run.start]; // make it wchar
            int cGlyphs = run.glyphCount;
            int piCP;
            int piTrailing;
            if ((orientation & SWT.RIGHT_TO_LEFT) !is 0) {
                xRun = run.width - xRun;
            }
            int* advances = run.justify !is null ? run.justify : run.advances;
            OS.ScriptXtoCP(xRun, cChars, cGlyphs, run.clusters, run.visAttrs, advances, &run.analysis, &piCP, &piTrailing);
            if (trailing !is null) trailing[0] = piTrailing;

            // SWT: back from codepoints to utf8 index
            int offsetIndex = segmentsText[ run.start .. $ ].codepointIndexToIndex( piCP );
            return untranslateOffset(run.start + offsetIndex);
        }
    }
    if (trailing !is null) trailing[0] = 0;
    return untranslateOffset(lineOffset[line + 1]);
}

/**
 * Returns the orientation of the receiver.
 *
 * @return the orientation style
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public int getOrientation () {
    checkLayout();
    return orientation;
}

/**
 * Returns the previous offset for the specified offset and movement
 * type.  The movement is one of <code>SWT.MOVEMENT_CHAR</code>,
 * <code>SWT.MOVEMENT_CLUSTER</code> or <code>SWT.MOVEMENT_WORD</code>,
 * <code>SWT.MOVEMENT_WORD_END</code> or <code>SWT.MOVEMENT_WORD_START</code>.
 *
 * @param offset the start offset
 * @param movement the movement type
 * @return the previous offset
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the offset is out of range</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #getNextOffset(int, int)
 */
public int getPreviousOffset (int offset, int movement) {
    checkLayout();
    return _getOffset (offset, movement, false);
}

/**
 * Gets the ranges of text that are associated with a <code>TextStyle</code>.
 *
 * @return the ranges, an array of offsets representing the start and end of each
 * text style.
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #getStyles()
 *
 * @since 3.2
 */
public int[] getRanges () {
    checkLayout();
    int[] result = new int[stylesCount * 2];
    int count = 0;
    for (int i=0; i<stylesCount - 1; i++) {
        if (styles[i].style !is null) {
            result[count++] = styles[i].start;
            result[count++] = styles[i + 1].start - 1;
        }
    }
    if (count !is result.length) {
        int[] newResult = new int[count];
        System.arraycopy(result, 0, newResult, 0, count);
        result = newResult;
    }
    return result;
}

/**
 * Returns the text segments offsets of the receiver.
 *
 * @return the text segments offsets
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public int[] getSegments () {
    checkLayout();
    return segments;
}

void getSegmentsText( out String resUtf8, out String16 resUtf16 ) {

    void buildIndexTables() { // build the index translation tables.
        index8to16.length = resUtf8.length + 1;
        index16to8.length = resUtf16.length + 1;

        int idx8, idx16;
        while( idx8 < resUtf8.length ){
            int ate8, ate16;
            dchar d8 = resUtf8[ idx8 .. $ ].firstCodePoint( ate8 );
            dchar d16 = resUtf16[ idx16 .. $ ].firstCodePoint( ate16 );
            assert( d8 is d16 );
            index16to8[ idx16 .. idx16 +ate16 ] = idx8;
            index8to16[ idx8  .. idx8  +ate8  ] = idx16;
            idx8  += ate8;
            idx16 += ate16;
        }
        index16to8[ resUtf16.length ] = resUtf8.length;
        index8to16[ resUtf8.length  ] = resUtf16.length;
    }

    if (segments is null) {
        resUtf8 = text;
        resUtf16 = wtext;
        buildIndexTables();
        return;
    }
    int nSegments = segments.length;
    if (nSegments <= 1) {
        resUtf8 = text;
        resUtf16 = wtext;
        buildIndexTables();
        return;
    }
    int length_ = text.length;
    int wlength_ = wtext.length;
    if (length_ is 0) {
        resUtf8 = text;
        resUtf16 = wtext;
        buildIndexTables();
        return;
    }
    if (nSegments is 2) {
        if (segments[0] is 0 && segments[1] is length_) {
            resUtf8 = text;
            resUtf16 = wtext;
            buildIndexTables();
            return;
        }
    }
    {
        auto oldChars = text;
        // SWT: MARK is now 3 chars long
        String separator = orientation is SWT.RIGHT_TO_LEFT ? STR_RTL_MARK : STR_LTR_MARK;
        assert( separator.length is MARK_SIZE );
        char[] newChars = new char[length_ + nSegments*MARK_SIZE];

        int charCount = 0, segmentCount = 0;
        while (charCount < length_) {
            if (segmentCount < nSegments && charCount is segments[segmentCount]) {
                int start = charCount + (segmentCount*MARK_SIZE);
                newChars[ start .. start + MARK_SIZE ] = separator;
                segmentCount++;
            } else {
                newChars[charCount + (segmentCount*MARK_SIZE)] = oldChars[charCount];
                charCount++;
            }
        }
        if (segmentCount < nSegments) {
            segments[segmentCount] = charCount;
            int start = charCount + (segmentCount*MARK_SIZE);
            newChars[ start .. start + MARK_SIZE ] = separator;
            segmentCount++;
        }
        resUtf8 = cast(String)newChars[ 0 .. Math.min(charCount + (segmentCount*MARK_SIZE), newChars.length)];
    }
    // now for the wide chars
    {
        String16 oldWChars = wtext;
        auto wseparator = orientation is SWT.RIGHT_TO_LEFT ? WSTR_RTL_MARK : WSTR_LTR_MARK;
        assert( wseparator.length is 1 );
        wchar[] newWChars = new wchar[wlength_ + nSegments];

        int charCount = 0, segmentCount = 0;
        while (charCount < wlength_) {
            if (segmentCount < nSegments && charCount is wsegments[segmentCount]) {
                int start = charCount + (segmentCount*WMARK_SIZE);
                newWChars[ start .. start + WMARK_SIZE ] = wseparator;
                segmentCount++;
            } else {
                newWChars[charCount + (segmentCount*WMARK_SIZE)] = oldWChars[charCount];
                charCount++;
            }
        }
        if (segmentCount < nSegments) {
            wsegments[segmentCount] = charCount;
            int start = charCount + (segmentCount*WMARK_SIZE);
            newWChars[ start .. start + WMARK_SIZE ] = wseparator;
            segmentCount++;
        }
        resUtf16 = cast(String16)newWChars[ 0 .. Math.min(charCount + (segmentCount*WMARK_SIZE), newWChars.length)];
    }
    buildIndexTables();
}

/**
 * Returns the line spacing of the receiver.
 *
 * @return the line spacing
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public int getSpacing () {
    checkLayout();
    return lineSpacing;
}

/**
 * Gets the style of the receiver at the specified character offset.
 *
 * @param offset the text offset
 * @return the style or <code>null</code> if not set
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the character offset is out of range</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public TextStyle getStyle (int offset) {
    checkLayout();
    int length = text.length;
    if (!(0 <= offset && offset < length)) SWT.error(SWT.ERROR_INVALID_RANGE);
    for (int i=1; i<stylesCount; i++) {
        if (styles[i].start > offset) {
            return styles[i - 1].style;
        }
    }
    return null;
}

/**
 * Gets all styles of the receiver.
 *
 * @return the styles
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #getRanges()
 *
 * @since 3.2
 */
public TextStyle[] getStyles () {
    checkLayout();
    TextStyle[] result = new TextStyle[stylesCount];
    int count = 0;
    for (int i=0; i<stylesCount; i++) {
        if (styles[i].style !is null) {
            result[count++] = styles[i].style;
        }
    }
    if (count !is result.length) {
        TextStyle[] newResult = new TextStyle[count];
        System.arraycopy(result, 0, newResult, 0, count);
        result = newResult;
    }
    return result;
}

/**
 * Returns the tab list of the receiver.
 *
 * @return the tab list
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public int[] getTabs () {
    checkLayout();
    return tabs;
}

/**
 * Gets the receiver's text, which will be an empty
 * string if it has never been set.
 *
 * @return the receiver's text
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public String getText () {
    checkLayout();
    return text;
}

/**
 * Returns the width of the receiver.
 *
 * @return the width
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public int getWidth () {
    checkLayout();
    return wrapWidth;
}

/**
 * Returns <code>true</code> if the text layout has been disposed,
 * and <code>false</code> otherwise.
 * <p>
 * This method gets the dispose state for the text layout.
 * When a text layout has been disposed, it is an error to
 * invoke any other method using the text layout.
 * </p>
 *
 * @return <code>true</code> when the text layout is disposed and <code>false</code> otherwise
 */
override public bool isDisposed () {
    return device is null;
}

/*
 *  Itemize the receiver text
 */
StyleItem[] itemize () {
    // SWT: itemize is the process of finding changes in direction
    getSegmentsText(segmentsText, segmentsWText );
    int length = segmentsText.length;
    SCRIPT_CONTROL scriptControl;
    SCRIPT_STATE scriptState;
    int MAX_ITEM = length + 1;

    if ((orientation & SWT.RIGHT_TO_LEFT) !is 0) {
        scriptState.uBidiLevel = 1;
        scriptState.fArabicNumContext = true;
        SCRIPT_DIGITSUBSTITUTE psds;
        OS.ScriptRecordDigitSubstitution(OS.LOCALE_USER_DEFAULT, &psds);
        OS.ScriptApplyDigitSubstitution(&psds, &scriptControl, &scriptState);
    }

    auto hHeap = OS.GetProcessHeap();
    auto pItems = cast(SCRIPT_ITEM*)OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, MAX_ITEM * SCRIPT_ITEM.sizeof);
    if (pItems is null) SWT.error(SWT.ERROR_NO_HANDLES);
    int pcItems;
    String16 chars = segmentsWText;
    OS.ScriptItemize(chars.ptr, chars.length, MAX_ITEM, &scriptControl, &scriptState, pItems, &pcItems);
//  if (hr is E_OUTOFMEMORY) //TODO handle it
    // SWT pcItems is not inclusive the trailing item

    StyleItem[] runs = merge(pItems, pcItems);
    OS.HeapFree(hHeap, 0, pItems);
    return runs;
}

/*
 *  Merge styles ranges and script items
 */
StyleItem[] merge (SCRIPT_ITEM* items, int itemCount) {
    if (styles.length > stylesCount) {
        StyleItem[] newStyles = new StyleItem[stylesCount];
        System.arraycopy(styles, 0, newStyles, 0, stylesCount);
        styles = newStyles;
    }
    int count = 0, start = 0, end = segmentsText.length, itemIndex = 0, styleIndex = 0;
    StyleItem[] runs = new StyleItem[itemCount + stylesCount];
    SCRIPT_ITEM* scriptItem;
    bool linkBefore = false;
    while (start < end) {
        StyleItem item = new StyleItem();
        item.start = start;
        item.style = styles[styleIndex].style;
        runs[count++] = item;
        scriptItem = items + itemIndex;
        item.analysis = scriptItem.a;
        if (linkBefore) {
            item.analysis.fLinkBefore = true;
            linkBefore = false;
        }
        //scriptItem.a = new SCRIPT_ANALYSIS();
        scriptItem = items + (itemIndex + 1);
        int itemLimit = index16to8[scriptItem.iCharPos];
        int styleLimit = translateOffset(styles[styleIndex + 1].start);
        if (styleLimit <= itemLimit) {
            styleIndex++;
            start = styleLimit;
            if (start < itemLimit && 0 < start && start < end) {
                dchar pChar = segmentsText[ segmentsText.getAbsoluteCodePointOffset(start, -1) ..$].firstCodePoint();
                dchar tChar = segmentsText[start     ..$].firstCodePoint();
                if (Compatibility.isLetter(pChar) && Compatibility.isLetter(tChar)) {
                    item.analysis.fLinkAfter = true;
                    linkBefore = true;
                }
            }
        }
        if (itemLimit <= styleLimit) {
            itemIndex++;
            start = itemLimit;
        }
        item.length = start - item.start;
    }
    StyleItem item = new StyleItem();
    item.start = end;
    scriptItem = items + itemCount;
    item.analysis = scriptItem.a;
    runs[count++] = item;
    if (runs.length !is count) {
        StyleItem[] result = new StyleItem[count];
        System.arraycopy(runs, 0, result, 0, count);
        return result;
    }
    return runs;
}

/*
 *  Reorder the run
 */
StyleItem[] reorder (StyleItem[] runs, bool terminate) {
    int length_ = runs.length;
    if (length_ <= 1) return runs;
    ubyte[] bidiLevels = new ubyte[length_];
    for (int i=0; i<length_; i++) {
        bidiLevels[i] = cast(byte)(runs[i].analysis.s.uBidiLevel & 0x1F);
    }
    /*
    * Feature in Windows.  If the orientation is RTL Uniscribe will
    * resolve the level of line breaks to 1, this can cause the line
    * break to be reorder to the middle of the line. The fix is to set
    * the level to zero to prevent it to be reordered.
    */
    StyleItem lastRun = runs[length_ - 1];
    if (lastRun.lineBreak && !lastRun.softBreak) {
        bidiLevels[length_ - 1] = 0;
    }
    int[] log2vis = new int[length_];
    OS.ScriptLayout(length_, bidiLevels.ptr, null, log2vis.ptr);
    StyleItem[] result = new StyleItem[length_];
    for (int i=0; i<length_; i++) {
        result[log2vis[i]] = runs[i];
    }
    if ((orientation & SWT.RIGHT_TO_LEFT) !is 0) {
        if (terminate) length_--;
        for (int i = 0; i < length_ / 2 ; i++) {
            StyleItem tmp = result[i];
            result[i] = result[length_ - i - 1];
            result[length_ - i - 1] = tmp;
        }
    }
    return result;
}

/**
 * Sets the text alignment for the receiver. The alignment controls
 * how a line of text is positioned horizontally. The argument should
 * be one of <code>SWT.LEFT</code>, <code>SWT.RIGHT</code> or <code>SWT.CENTER</code>.
 * <p>
 * The default alignment is <code>SWT.LEFT</code>.  Note that the receiver's
 * width must be set in order to use <code>SWT.RIGHT</code> or <code>SWT.CENTER</code>
 * alignment.
 * </p>
 *
 * @param alignment the new alignment
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #setWidth(int)
 */
public void setAlignment (int alignment) {
    checkLayout();
    int mask = SWT.LEFT | SWT.CENTER | SWT.RIGHT;
    alignment &= mask;
    if (alignment is 0) return;
    if ((alignment & SWT.LEFT) !is 0) alignment = SWT.LEFT;
    if ((alignment & SWT.RIGHT) !is 0) alignment = SWT.RIGHT;
    if (this.alignment is alignment) return;
    freeRuns();
    this.alignment = alignment;
}

/**
 * Sets the ascent of the receiver. The ascent is distance in pixels
 * from the baseline to the top of the line and it is applied to all
 * lines. The default value is <code>-1</code> which means that the
 * ascent is calculated from the line fonts.
 *
 * @param ascent the new ascent
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the ascent is less than <code>-1</code></li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #setDescent(int)
 * @see #getLineMetrics(int)
 */
public void setAscent(int ascent) {
    checkLayout();
    if (ascent < -1) SWT.error(SWT.ERROR_INVALID_ARGUMENT);
    if (this.ascent is ascent) return;
    freeRuns();
    this.ascent = ascent;
}

/**
 * Sets the descent of the receiver. The descent is distance in pixels
 * from the baseline to the bottom of the line and it is applied to all
 * lines. The default value is <code>-1</code> which means that the
 * descent is calculated from the line fonts.
 *
 * @param descent the new descent
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the descent is less than <code>-1</code></li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #setAscent(int)
 * @see #getLineMetrics(int)
 */
public void setDescent(int descent) {
    checkLayout();
    if (descent < -1) SWT.error(SWT.ERROR_INVALID_ARGUMENT);
    if (this.descent is descent) return;
    freeRuns();
    this.descent = descent;
}

/**
 * Sets the default font which will be used by the receiver
 * to draw and measure text. If the
 * argument is null, then a default font appropriate
 * for the platform will be used instead. Note that a text
 * style can override the default font.
 *
 * @param font the new font for the receiver, or null to indicate a default font
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the font has been disposed</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public void setFont (Font font) {
    checkLayout();
    if (font !is null && font.isDisposed()) SWT.error(SWT.ERROR_INVALID_ARGUMENT);
    Font oldFont = this.font;
    if (oldFont is font) return;
    this.font = font;
    if (oldFont !is null && oldFont.opEquals(font)) return;
    freeRuns();
}

/**
 * Sets the indent of the receiver. This indent it applied of the first line of
 * each paragraph.
 *
 * @param indent new indent
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @since 3.2
 */
public void setIndent (int indent) {
    checkLayout();
    if (indent < 0) return;
    if (this.indent is indent) return;
    freeRuns();
    this.indent = indent;
}

/**
 * Sets the justification of the receiver. Note that the receiver's
 * width must be set in order to use justification.
 *
 * @param justify new justify
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @since 3.2
 */
public void setJustify (bool justify) {
    checkLayout();
    if (this.justify is justify) return;
    freeRuns();
    this.justify = justify;
}

/**
 * Sets the orientation of the receiver, which must be one
 * of <code>SWT.LEFT_TO_RIGHT</code> or <code>SWT.RIGHT_TO_LEFT</code>.
 *
 * @param orientation new orientation style
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public void setOrientation (int orientation) {
    checkLayout();
    int mask = SWT.LEFT_TO_RIGHT | SWT.RIGHT_TO_LEFT;
    orientation &= mask;
    if (orientation is 0) return;
    if ((orientation & SWT.LEFT_TO_RIGHT) !is 0) orientation = SWT.LEFT_TO_RIGHT;
    if (this.orientation is orientation) return;
    this.orientation = orientation;
    freeRuns();
}

/**
 * Sets the offsets of the receiver's text segments. Text segments are used to
 * override the default behaviour of the bidirectional algorithm.
 * Bidirectional reordering can happen within a text segment but not
 * between two adjacent segments.
 * <p>
 * Each text segment is determined by two consecutive offsets in the
 * <code>segments</code> arrays. The first element of the array should
 * always be zero and the last one should always be equals to length of
 * the text.
 * </p>
 *
 * @param segments the text segments offset
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public void setSegments(int[] segments) {
    checkLayout();
    if (this.segments is null && segments is null) return;
    if (this.segments !is null && segments !is null) {
        if (this.segments.length is segments.length) {
            int i;
            for (i = 0; i <segments.length; i++) {
                if (this.segments[i] !is segments[i]) break;
            }
            if (i is segments.length) return;
        }
    }
    freeRuns();
    this.segments  = segments.dup;

    // SWT: create the wsegments ...
    this.wsegments.length = segments.length;
    uint index8, index16;
    uint segIndex = 1;
    while(index8 < text.length ){
        int ate8;
        int ate16;
        dchar d8 = text[ index8 .. $ ].firstCodePoint( ate8 );
        dchar d16 = wtext[ index16 .. $ ].firstCodePoint( ate16 );
        assert( d8 is d16 );
        assert( ate8 > 0 );
        assert( ate16 > 0 );
        index8 += ate8;
        index16 += ate16;
        if( segments[segIndex] is index8 ){
            wsegments[segIndex] = index16;
        }
    }
    assert( index16 is wtext.length );
    assert( segIndex is segments.length );
}

/**
 * Sets the line spacing of the receiver.  The line spacing
 * is the space left between lines.
 *
 * @param spacing the new line spacing
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the spacing is negative</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public void setSpacing (int spacing) {
    checkLayout();
    if (spacing < 0) SWT.error(SWT.ERROR_INVALID_ARGUMENT);
    if (this.lineSpacing is spacing) return;
    freeRuns();
    this.lineSpacing = spacing;
}

/**
 * Sets the style of the receiver for the specified range.  Styles previously
 * set for that range will be overwritten.  The start and end offsets are
 * inclusive and will be clamped if out of range.
 *
 * @param style the style
 * @param start the start offset
 * @param end the end offset
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public void setStyle (TextStyle style, int start, int end) {
    checkLayout();
    int length = text.length;
    if (length is 0) return;
    if (start > end) return;
    start = Math.min(Math.max(0, start), length - 1);
    end = Math.min(Math.max(0, end), length - 1);
    int low = -1;
    int high = stylesCount;
    while (high - low > 1) {
        int index = (high + low) / 2;
        if (styles[index + 1].start > start) {
            high = index;
        } else {
            low = index;
        }
    }
    if (0 <= high && high < stylesCount) {
        StyleItem item = styles[high];
        if (item.start is start && styles[high + 1].start - 1 is end) {
            if (style is null) {
                if (item.style is null) return;
            } else {
                if (style.opEquals(item.style)) return;
            }
        }
    }
    freeRuns();
    int modifyStart = high;
    int modifyEnd = modifyStart;
    while (modifyEnd < stylesCount) {
        if (styles[modifyEnd + 1].start > end) break;
        modifyEnd++;
    }
    if (modifyStart is modifyEnd) {
        int styleStart = styles[modifyStart].start;
        int styleEnd = styles[modifyEnd + 1].start - 1;
        if (styleStart is start && styleEnd is end) {
            styles[modifyStart].style = style;
            return;
        }
        if (styleStart !is start && styleEnd !is end) {
            int newLength = stylesCount + 2;
            if (newLength > styles.length) {
                int newSize = Math.min(newLength + 1024, Math.max(64, newLength * 2));
                StyleItem[] newStyles = new StyleItem[newSize];
                System.arraycopy(styles, 0, newStyles, 0, stylesCount);
                styles = newStyles;
            }
            System.arraycopy(styles, modifyEnd + 1, styles, modifyEnd + 3, stylesCount - modifyEnd - 1);
            StyleItem item = new StyleItem();
            item.start = start;
            item.style = style;
            styles[modifyStart + 1] = item;
            item = new StyleItem();
            item.start = end + 1;
            item.style = styles[modifyStart].style;
            styles[modifyStart + 2] = item;
            stylesCount = newLength;
            return;
        }
    }
    if (start is styles[modifyStart].start) modifyStart--;
    if (end is styles[modifyEnd + 1].start - 1) modifyEnd++;
    int newLength = stylesCount + 1 - (modifyEnd - modifyStart - 1);
    if (newLength > styles.length) {
        int newSize = Math.min(newLength + 1024, Math.max(64, newLength * 2));
        StyleItem[] newStyles = new StyleItem[newSize];
        System.arraycopy(styles, 0, newStyles, 0, stylesCount);
        styles = newStyles;
    }
    System.arraycopy(styles, modifyEnd, styles, modifyStart + 2, stylesCount - modifyEnd);
    StyleItem item = new StyleItem();
    item.start = start;
    item.style = style;
    styles[modifyStart + 1] = item;
    styles[modifyStart + 2].start = end + 1;
    stylesCount = newLength;
}

/**
 * Sets the receiver's tab list. Each value in the tab list specifies
 * the space in pixels from the origin of the text layout to the respective
 * tab stop.  The last tab stop width is repeated continuously.
 *
 * @param tabs the new tab list
 *
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public void setTabs (int[] tabs) {
    checkLayout();
    if (this.tabs is null && tabs is null) return;
    if (this.tabs !is null && tabs !is null) {
        if (this.tabs.length is tabs.length) {
            int i;
            for (i = 0; i <tabs.length; i++) {
                if (this.tabs[i] !is tabs[i]) break;
            }
            if (i is tabs.length) return;
        }
    }
    freeRuns();
    this.tabs = tabs;
}

/**
 * Sets the receiver's text.
 *
 * @param text the new text
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_NULL_ARGUMENT - if the text is null</li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 */
public void setText (String text) {
    checkLayout();

    //PORTING_CHANGE: allow null argument
    //if (text is null) SWT.error(SWT.ERROR_NULL_ARGUMENT);
    if (text.equals(this.text)) return;
    freeRuns();
    this.text  = text._idup();
    this.wtext = StrToWCHARs(text);
    styles = new StyleItem[2];
    styles[0] = new StyleItem();
    styles[1] = new StyleItem();
    styles[1].start = text.length;
    stylesCount = 2;
}

/**
 * Sets the line width of the receiver, which determines how
 * text should be wrapped and aligned. The default value is
 * <code>-1</code> which means wrapping is disabled.
 *
 * @param width the new width
 *
 * @exception IllegalArgumentException <ul>
 *    <li>ERROR_INVALID_ARGUMENT - if the width is <code>0</code> or less than <code>-1</code></li>
 * </ul>
 * @exception SWTException <ul>
 *    <li>ERROR_GRAPHIC_DISPOSED - if the receiver has been disposed</li>
 * </ul>
 *
 * @see #setAlignment(int)
 */
public void setWidth (int width) {
    checkLayout();
    if (width < -1 || width is 0) SWT.error(SWT.ERROR_INVALID_ARGUMENT);
    if (this.wrapWidth is width) return;
    freeRuns();
    this.wrapWidth = width;
}

bool shape (HDC hdc, StyleItem run, String16 wchars, int[] glyphCount, int maxGlyphs, SCRIPT_PROPERTIES* sp) {
    bool useCMAPcheck = !sp.fComplex && !run.analysis.fNoGlyphIndex;
    if (useCMAPcheck) {
        scope ushort[] glyphs = new ushort[wchars.length];
        if (OS.ScriptGetCMap(hdc, run.psc, wchars.ptr, wchars.length, 0, glyphs.ptr) !is OS.S_OK) {
            if (run.psc !is null) {
                OS.ScriptFreeCache(run.psc);
                glyphCount[0] = 0;
                int[1] one = 1;
                *cast(int*)run.psc = 0;
            }
            return false;
        }
    }
    auto hr = OS.ScriptShape(hdc, run.psc, wchars.ptr, wchars.length, maxGlyphs, &run.analysis, run.glyphs, run.clusters, run.visAttrs, glyphCount.ptr);
    run.glyphCount = glyphCount[0];
    if (useCMAPcheck) return true;
    
    if (hr !is OS.USP_E_SCRIPT_NOT_IN_FONT) {
        if (run.analysis.fNoGlyphIndex) return true;
        SCRIPT_FONTPROPERTIES fp;
        fp.cBytes = SCRIPT_FONTPROPERTIES.sizeof;
        OS.ScriptGetFontProperties(hdc, run.psc, &fp);
        ushort[] glyphs = run.glyphs[ 0 .. glyphCount[0] ];
        int i;
        for (i = 0; i < glyphs.length; i++) {
            if (glyphs[i] is fp.wgDefault) break;
        }
        if (i is glyphs.length) return true;
    }
    if (run.psc !is null) {
        OS.ScriptFreeCache(run.psc);
        glyphCount[0] = 0;
        *cast(int*)run.psc = 0;
    }
    run.glyphCount = 0;
    return false;
}


/*
 * Generate glyphs for one Run.
 */
void shape (HDC hdc, StyleItem run) {
    int[1] buffer;
    auto wchars = segmentsWText[ index8to16[ run.start ] .. index8to16[ run.start + run.length ] ];
    int maxGlyphs = (wchars.length * 3 / 2) + 16;
    auto hHeap = OS.GetProcessHeap();
    run.glyphs = cast(ushort*)OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, maxGlyphs * 2);
    if (run.glyphs is null) SWT.error(SWT.ERROR_NO_HANDLES);
    run.clusters = cast(WORD*)OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, maxGlyphs * 2);
    if (run.clusters is null) SWT.error(SWT.ERROR_NO_HANDLES);
    run.visAttrs = cast(SCRIPT_VISATTR*)OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, maxGlyphs * SCRIPT_VISATTR_SIZEOF);
    if (run.visAttrs is null) SWT.error(SWT.ERROR_NO_HANDLES);
    run.psc = cast(SCRIPT_CACHE*)OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, (void*).sizeof);
    if (run.psc is null) SWT.error(SWT.ERROR_NO_HANDLES);
    short script = run.analysis.eScript;
    SCRIPT_PROPERTIES sp = *device.scripts[script];
    bool shapeSucceed = shape(hdc, run, wchars, buffer,  maxGlyphs, &sp);
int res;
    if (!shapeSucceed) {
        auto hFont = OS.GetCurrentObject(hdc, OS.OBJ_FONT);
        auto ssa = cast(SCRIPT_STRING_ANALYSIS*) OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, SCRIPT_STRING_ANALYSIS.sizeof);
        auto metaFileDc = OS.CreateEnhMetaFile(hdc, null, null, null);
        auto oldMetaFont = OS.SelectObject(metaFileDc, hFont);
        int flags = OS.SSA_METAFILE | OS.SSA_FALLBACK | OS.SSA_GLYPHS | OS.SSA_LINK;
        if (OS.ScriptStringAnalyse(metaFileDc, wchars.ptr, wchars.length, 0, -1, flags, 0, null, null, null, null, null, ssa) is OS.S_OK) {
            OS.ScriptStringOut(*ssa, 0, 0, 0, null, 0, 0, false);
            OS.ScriptStringFree(ssa);
        }
        OS.HeapFree(hHeap, 0, ssa);
        OS.SelectObject(metaFileDc, oldMetaFont);
        auto metaFile = OS.CloseEnhMetaFile(metaFileDc);
        static extern(Windows) int metaFileEnumProc (HDC hDC, HANDLETABLE* table, ENHMETARECORD* record, int nObj, LPARAM lpData) {
            EMREXTCREATEFONTINDIRECTW* emr_ = cast(EMREXTCREATEFONTINDIRECTW*)lpData;
            OS.MoveMemory(&emr_.emr, record, EMR.sizeof);
            switch (emr_.emr.iType) {
                case OS.EMR_EXTCREATEFONTINDIRECTW:
                    OS.MoveMemory(emr_, record, EMREXTCREATEFONTINDIRECTW.sizeof);
                    break;
                case OS.EMR_EXTTEXTOUTW:
                    return 0;
                default:
            }
            return 1;
        }

        EMREXTCREATEFONTINDIRECTW emr;
        OS.EnumEnhMetaFile(null, metaFile, &metaFileEnumProc, &emr, null);
        res = OS.DeleteEnhMetaFile(metaFile);
        assert( res !is 0 );

        auto newFont = OS.CreateFontIndirectW(&emr.elfw.elfLogFont);
        assert( newFont !is null );

        OS.SelectObject(hdc, newFont);
        if ((shapeSucceed = shape(hdc, run, wchars, buffer,  maxGlyphs, &sp)) is true ) {
            run.fallbackFont = newFont;
        }
        if (!shapeSucceed) {
            if (!sp.fComplex) {
                run.analysis.fNoGlyphIndex = true;
                if ((shapeSucceed = shape(hdc, run, wchars, buffer,  maxGlyphs, &sp)) is true ) {
                    run.fallbackFont = newFont;
                } else {
                    run.analysis.fNoGlyphIndex = false;
                }
            }
        }
        if (!shapeSucceed) {
            if (mLangFontLink2 !is null) {
                HANDLE hNewFont;
                int dwCodePages, cchCodePages;
                /* GetStrCodePages() */
                OS.VtblCall(4, mLangFontLink2, cast(int)wchars.ptr, wchars.length, 0, cast(int)&dwCodePages, cast(int)&cchCodePages);
                /* MapFont() */
                if (OS.VtblCall(10, mLangFontLink2, cast(int)hdc, dwCodePages, cast(int)wchars[0], cast(int)&hNewFont) is OS.S_OK) {
                    LOGFONT logFont;
                    OS.GetObject( hNewFont, LOGFONT.sizeof, &logFont );
                    /* ReleaseFont() */
                    OS.VtblCall(8, mLangFontLink2, cast(int)hNewFont);
                    auto mLangFont = OS.CreateFontIndirect(&logFont);
                    auto oldFont = OS.SelectObject(hdc, mLangFont);
                    if ((shapeSucceed = shape(hdc, run, wchars, buffer,  maxGlyphs, &sp)) is true ) {
                        run.fallbackFont = mLangFont;
                    } else {
                        OS.SelectObject(hdc, oldFont);
                        OS.DeleteObject(mLangFont);
                    }
                }
            }
        }
        if (!shapeSucceed) OS.SelectObject(hdc, hFont);
        if (newFont !is run.fallbackFont) OS.DeleteObject(newFont);
    }

    if (!shapeSucceed) {
        /*
        * Shape Failed.
        * Give up and shape the run with the default font.
        * Missing glyphs typically will be represent as black boxes in the text.
        */
        OS.ScriptShape(hdc, run.psc, wchars.ptr, wchars.length, maxGlyphs, &run.analysis, run.glyphs, run.clusters, run.visAttrs, buffer.ptr);
        run.glyphCount = buffer[0];
    }
    int[3] abc;
    run.advances = cast(int*)OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, run.glyphCount * 4);
    if (run.advances is null) SWT.error(SWT.ERROR_NO_HANDLES);
    run.goffsets = cast(GOFFSET*)OS.HeapAlloc(hHeap, OS.HEAP_ZERO_MEMORY, run.glyphCount * GOFFSET_SIZEOF);
    if (run.goffsets is null) SWT.error(SWT.ERROR_NO_HANDLES);
    OS.ScriptPlace(hdc, run.psc, run.glyphs, run.glyphCount, run.visAttrs, &run.analysis, run.advances, run.goffsets, cast(ABC*)abc.ptr);
    run.width = abc[0] + abc[1] + abc[2];
    TextStyle style = run.style;
    if (style !is null) {
        OUTLINETEXTMETRIC* lotm = null;
        if (style.underline || style.strikeout) {
            lotm = new OUTLINETEXTMETRIC();
            if (OS.GetOutlineTextMetrics(hdc, OUTLINETEXTMETRIC.sizeof, lotm) is 0) {
                lotm = null;
            }
        }
        if (style.metrics !is null) {
            GlyphMetrics metrics = style.metrics;
            /*
             *  Bug in Windows, on a Japanese machine, Uniscribe returns glyphcount
             *  equals zero for FFFC (possibly other unicode code points), the fix
             *  is to make sure the glyph is at least one pixel wide.
             */
            run.width = metrics.width * Math.max (1, run.glyphCount);
            run.ascent = metrics.ascent;
            run.descent = metrics.descent;
            run.leading = 0;
        } else {
            TEXTMETRIC lptm;
            if (lotm !is null) {
                lptm = lotm.otmTextMetrics;
            } else {
                lptm = TEXTMETRIC.init;
                OS.GetTextMetrics(hdc, &lptm);
            }
            run.ascent = lptm.tmAscent;
            run.descent = lptm.tmDescent;
            run.leading = lptm.tmInternalLeading;
        }
        if (lotm !is null) {
            run.underlinePos = lotm.otmsUnderscorePosition;
            run.underlineThickness = Math.max(1, lotm.otmsUnderscoreSize);
            run.strikeoutPos = lotm.otmsStrikeoutPosition;
            run.strikeoutThickness = Math.max(1, lotm.otmsStrikeoutSize);
        } else {
            run.underlinePos = 1;
            run.underlineThickness = 1;
            run.strikeoutPos = run.ascent / 2;
            run.strikeoutThickness = 1;
        }
        run.ascent += style.rise;
        run.descent -= style.rise;
    } else {
        TEXTMETRIC lptm;
        OS.GetTextMetrics(hdc, &lptm);
        run.ascent = lptm.tmAscent;
        run.descent = lptm.tmDescent;
        run.leading = lptm.tmInternalLeading;
    }
}

int validadeOffset(int offset, int step) {
    offset = segmentsText.toAbsoluteCodePointStartOffset( offset );
    offset += segmentsText.getRelativeCodePointOffset( offset, step );
    if (segments !is null && segments.length > 2) {
        for (int i = 0; i < segments.length; i++) {
            if (translateOffset(segments[i]) - 1 is offset) {
                offset += step;
                break;
            }
        }
    }
    return offset;
}

/**
 * Returns a string containing a concise, human-readable
 * description of the receiver.
 *
 * @return a string representation of the receiver
 */
override public String toString () {
    if (isDisposed()) return "TextLayout {*DISPOSED*}";
    return "TextLayout {}";
}

int translateOffset(int offset) {
    if (segments is null) return offset;
    int nSegments = segments.length;
    if (nSegments <= 1) return offset;
    int length = text.length;
    if (length is 0) return offset;
    if (nSegments is 2) {
        if (segments[0] is 0 && segments[1] is length) return offset;
    }
    for (int i = 0; i < nSegments && offset - i >= segments[i]; i++) {
        offset+=MARK_SIZE;
    }
    return offset;
}

int untranslateOffset(int offset) {
    if (segments is null) return offset;
    int nSegments = segments.length;
    if (nSegments <= 1) return offset;
    int length = text.length;
    if (length is 0) return offset;
    if (nSegments is 2) {
        if (segments[0] is 0 && segments[1] is length) return offset;
    }
    for (int i = 0; i < nSegments && offset > segments[i]; i++) {
        offset-=MARK_SIZE;
    }
    return offset;
}
}
