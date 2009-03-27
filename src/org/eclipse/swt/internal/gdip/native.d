/******************************************************************************

  module:

  Based on D version created by John Chapman for the Juno Project
    see: www.dsource.org/projects/juno

  Changes and Additions for SWT:
    John Reimer <terminal.node@gmail.com>

******************************************************************************/

module org.eclipse.swt.internal.gdip.native;

import org.eclipse.swt.internal.win32.WINTYPES;
import java.lang.all;

extern(Windows):

/******************************************************************************


******************************************************************************/

enum DebugEventLevel {
  Fatal,
  Warning
}

alias void  function(DebugEventLevel level, char* message) DebugEventProc;

alias int   function(out uint token)    NotificationHookProc;
alias void  function(uint token)        NotificationUnhookProc;


/******************************************************************************


******************************************************************************/


struct GdiplusStartupInput {
  uint GdiplusVersion;
  DebugEventProc DebugEventCallback;
  int SuppressBackgroundThread;
  int SuppressExternalCodecs;
}

struct GdiplusStartupOutput {
  NotificationHookProc NotificationHook;
  NotificationUnhookProc NotificationUnhook;
}

struct GpBitmapData {
  int Width;
  int Height;
  int Stride;
  int PixelFormat;
  void* Scan0;
  int Reserved;
}

struct GpColorMatrix {
  float[5][5] m;
}

struct GpPropertyItem {
  int id;
  int length;
  short type;
  void* value;
}

struct GpColorPalette {
  int Flags;
  int Count;
  int[1] Entries;
}

public struct GpRectF {
    public float X;
    public float Y;
    public float Width;
    public float Height;
}

public struct GpRect {
    public int X;
    public int Y;
    public int Width;
    public int Height;
}
public struct GpPoint {
    public int X;
    public int Y;
}
public struct GpPointF {
    public float X;
    public float Y;
}

alias int function(void*) GpDrawImageAbort;
alias GpDrawImageAbort GpGetThumbnailImageAbort;

/******************************************************************************


******************************************************************************/

enum Status {
  OK,
  GenericError,
  InvalidParameter,
  OutOfMemory,
  ObjectBusy,
  InsufficientBuffer,
  NotImplemented,
  Win32Error,
  WrongState,
  Aborted,
  FileNotFound,
  ValueOverflow,
  AccessDenied,
  UnknownImageFormat,
  FontFamilyNotFound,
  FontStyleNotFound,
  NotTrueTypeFont,
  UnsupportedGdiplusVersion,
  GdiplusNotInitialized,
  PropertyNotFound,
  PropertyNotSupported
}

/**************************************************************************

	Opaque types managed by Gdi+

**************************************************************************/
typedef GpImage  GpBitmap;

// alias   uint   ARGB;
typedef Handle GpFontFamily;
typedef Handle GpImage;
typedef Handle GpBrush;
typedef Handle GpFont;
typedef Handle GpFontCollection;
typedef Handle GpGraphics;
typedef Handle GpGraphicsPath;
typedef Handle GpImageAttributes;
typedef Handle GpHatchBrush;
typedef Handle GpLinearGradientBrush;
typedef Handle GpMatrix;
typedef Handle GpPen;
typedef Handle GpRegion;
typedef Handle GpSolidBrush;
typedef Handle GpStringFormat;
typedef Handle GpTextureBrush;
typedef Handle GpPath;

alias void* Handle;

alias int BrushType;
alias int CombineMode;
alias int FlushIntention;
alias int MatrixOrder;
alias int GraphicsUnit;
alias int QualityMode;
alias int SmoothingMode;
alias int InterpolationMode;
alias int CompositingMode;
alias int CompositingQuality;
alias int PixelOffsetMode;
alias int PixelFormat;
alias int RotateFlipType;
alias int CoordinateSpace;
alias int WarpMode;
alias int WrapMode;
alias int FillMode;
alias int LineJoin;
alias int LineCap;
alias int DashCap;
alias int DashStyle;
alias int PenAlignment;
alias int ColorMatrixFlag;
alias int ColorAdjustType;
alias int ColorChannelFlag;
alias int ImageLockMode;
alias int ImageCodecFlags;
alias int EncoderParameterValueType;
alias int GenericFontFamilies;
alias int FontStyle;
alias int HatchStyle;
alias int StringFormatFlags;
alias int StringAlignment;
alias int StringTrimming;
alias int TextRenderingHint;
alias int PenType;
alias int LinearGradientMode;
alias int KnownColor;
alias int Unit;

alias uint GraphicsState;

/******************************************************************************

	Flat GDI+ Exports (C Interface)

******************************************************************************/

extern (Windows):

version( STATIC_GDIPLUS ){
Status GdiplusStartup( uint* token, GdiplusStartupInput* input, GdiplusStartupOutput* output);
void   GdiplusShutdown(uint token);
Status GdipCreateFromHDC(Handle hdc, out Handle graphics);
Status GdipCreateFromHDC2(Handle hdc, Handle hDevice, out Handle graphics);
Status GdipCreateFromHWND(Handle hwnd, out Handle graphics);
Status GdipGetImageGraphicsContext(Handle image, out Handle graphics);
Status GdipDeleteGraphics(Handle graphics);
Status GdipGetDC(Handle graphics, out Handle hdc);
Status GdipReleaseDC(Handle graphics, Handle hdc);
Status GdipSetClipGraphics(Handle graphics, Handle srcgraphics, CombineMode combineMode);
Status GdipSetClipRectI(Handle graphics, int x, int y, int width, int height, CombineMode combineMode);
Status GdipSetClipRect(Handle graphics, float x, float y, float width, float height, CombineMode combineMode);
Status GdipSetClipPath(Handle graphics, Handle path, CombineMode combineMode);
Status GdipSetClipRegion(Handle graphics, Handle region, CombineMode combineMode);
Status GdipSetClipHrgn(Handle graphics, HRGN hRgn, CombineMode combineMode);

Status GdipGetClip(Handle graphics, out Handle region);
Status GdipResetClip(Handle graphics);
Status GdipSaveGraphics(Handle graphics, out uint state);
Status GdipRestoreGraphics(Handle graphics, int state);
Status GdipFlush(Handle graphics, FlushIntention intention);
Status GdipScaleWorldTransform(Handle graphics, float sx, float sy, MatrixOrder order);
Status GdipRotateWorldTransform(Handle graphics, float angle, MatrixOrder order);
Status GdipTranslateWorldTransform(Handle graphics, float dx, float dy, MatrixOrder order);
Status GdipMultiplyWorldTransform(Handle graphics, Handle matrix, MatrixOrder order);
Status GdipResetWorldTransform(Handle graphics);
Status GdipBeginContainer(Handle graphics, ref GpRectF dstrect, ref GpRectF srcrect, GraphicsUnit unit, out int state);
Status GdipBeginContainerI(Handle graphics, ref GpRect dstrect, ref GpRect srcrect, GraphicsUnit unit, out int state);
Status GdipBeginContainer2(Handle graphics, out int state);
Status GdipEndContainer(Handle graphics, int state);
Status GdipGetDpiX(Handle graphics, out float dpi);
Status GdipGetDpiY(Handle graphics, out float dpi);
Status GdipGetPageUnit(Handle graphics, out GraphicsUnit unit);
Status GdipSetPageUnit(Handle graphics, GraphicsUnit unit);
Status GdipGetPageScale(Handle graphics, out float scale);
Status GdipSetPageScale(Handle graphics, float scale);
Status GdipGetWorldTransform(Handle graphics, Handle matrix); // out not necessary?
Status GdipSetWorldTransform(Handle graphics, Handle matrix);
Status GdipGetCompositingMode(Handle graphics, out CompositingMode compositingMode);
Status GdipSetCompositingMode(Handle graphics, CompositingMode compositingMode);
Status GdipGetCompositingQuality(Handle graphics, out CompositingQuality compositingQuality);
Status GdipSetCompositingQuality(Handle graphics, CompositingQuality compositingQuality);
Status GdipGetInterpolationMode(Handle graphics, out InterpolationMode interpolationMode);
Status GdipSetInterpolationMode(Handle graphics, InterpolationMode interpolationMode);
Status GdipGetSmoothingMode(Handle graphics, out SmoothingMode smoothingMode);
Status GdipSetSmoothingMode(Handle graphics, SmoothingMode smoothingMode);
Status GdipGetPixelOffsetMode(Handle graphics, out PixelOffsetMode pixelOffsetMode);
Status GdipSetPixelOffsetMode(Handle graphics, PixelOffsetMode pixelOffsetMode);
Status GdipGetTextContrast(Handle graphics, out uint textContrast);
Status GdipSetTextContrast(Handle graphics, uint textContrast);
Status GdipGraphicsClear(Handle graphics, int color);
Status GdipDrawLine(Handle graphics, Handle pen, float x1, float y1, float x2, float y2);
Status GdipDrawLines(Handle graphics, Handle pen, GpPointF* points, int count);
Status GdipDrawLineI(Handle graphics, Handle pen, int x1, int y1, int x2, int y2);
Status GdipDrawLinesI(Handle graphics, Handle pen, GpPoint* points, int count);
Status GdipDrawArc(Handle graphics, Handle pen, float x, float y, float width, float height, float startAngle, float sweepAngle);
Status GdipDrawArcI(Handle graphics, Handle pen, int x, int y, int width, int height, float startAngle, float sweepAngle);
Status GdipDrawBezier(Handle graphics, Handle pen, float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4);
Status GdipDrawBeziers(Handle graphics, Handle pen, GpPointF* points, int count);
Status GdipDrawBezierI(Handle graphics, Handle pen, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);
Status GdipDrawBeziersI(Handle graphics, Handle pen, GpPoint* points, int count);
Status GdipDrawRectangle(Handle graphics, Handle pen, float x, float y, float width, float height);
Status GdipDrawRectangles(Handle graphics, Handle pen, GpRectF* rects, int count);
Status GdipDrawRectangleI(Handle graphics, Handle pen, int x, int y, int width, int height);
Status GdipDrawRectanglesI(Handle graphics, Handle pen, GpRect* rects, int count);
Status GdipDrawEllipse(Handle graphics, Handle pen, float x, float y, float width, float height);
Status GdipDrawEllipseI(Handle graphics, Handle pen, int x, int y, int width, int height);
Status GdipDrawPie(Handle graphics, Handle pen, float x, float y, float width, float height, float startAngle, float sweepAngle);
Status GdipDrawPieI(Handle graphics, Handle pen, int x, int y, int width, int height, float startAngle, float sweepAngle);
Status GdipDrawPolygon(Handle graphics, Handle pen, GpPointF* points, int count);
Status GdipDrawPolygonI(Handle graphics, Handle pen, GpPoint* points, int count);
Status GdipDrawCurve(Handle graphics, Handle pen, GpPointF* points, int count);
Status GdipDrawCurve2(Handle graphics, Handle pen, GpPointF* points, int count, float tension);
Status GdipDrawCurve3(Handle graphics, Handle pen, GpPointF* points, int count, int offset, int numberOfSegments, float tension);
Status GdipDrawCurveI(Handle graphics, Handle pen, GpPoint* points, int count);
Status GdipDrawCurve2I(Handle graphics, Handle pen, GpPoint* points, int count, float tension);
Status GdipDrawCurve3I(Handle graphics, Handle pen, GpPoint* points, int count, int offset, int numberOfSegments, float tension);
Status GdipDrawClosedCurve(Handle graphics, Handle pen, GpPointF* points, int count);
Status GdipDrawClosedCurve2(Handle graphics, Handle pen, GpPointF* points, int count, float tension);
Status GdipDrawClosedCurveI(Handle graphics, Handle pen, GpPoint* points, int count);
Status GdipDrawClosedCurve2I(Handle graphics, Handle pen, GpPoint* points, int count, float tension);
Status GdipFillRectangleI(Handle graphics, Handle brush, int x, int y, int width, int height);
Status GdipFillRectangle(Handle graphics, Handle brush, float x, float y, float width, float height);
Status GdipFillRectanglesI(Handle graphics, Handle brush, GpRect* rects, int count);
Status GdipFillRectangles(Handle graphics, Handle brush, GpRectF* rects, int count);
Status GdipFillPolygon(Handle graphics, Handle brush, GpPointF* rects, int count, FillMode fillMode);
Status GdipFillPolygonI(Handle graphics, Handle brush, GpPoint* rects, int count, FillMode fillMode);
Status GdipFillEllipse(Handle graphics, Handle brush, float x, float y, float width, float height);
Status GdipFillEllipseI(Handle graphics, Handle brush, int x, int y, int width, int height);
Status GdipFillPie(Handle graphics, Handle brush, float x, float y, float width, float height, float startAngle, float sweepAngle);
Status GdipFillPieI(Handle graphics, Handle brush, int x, int y, int width, int height, float startAngle, float sweepAngle);
Status GdipFillPath(Handle graphics, Handle brush, Handle path);
Status GdipFillClosedCurve(Handle graphics, Handle brush, GpPointF* points, int count);
Status GdipFillClosedCurveI(Handle graphics, Handle brush, GpPoint* points, int count);
Status GdipFillClosedCurve2(Handle graphics, Handle brush, GpPointF* points, int count, FillMode fillMode, float tension);
Status GdipFillClosedCurve2I(Handle graphics, Handle brush, GpPoint* points, int count, FillMode fillMode, float tension);
Status GdipFillRegion(Handle graphics, Handle brush, Handle region);
Status GdipDrawString(Handle graphics, LPCWSTR string, int length, Handle font, ref GpRectF layoutRect, Handle stringFormat, Handle brush);
Status GdipMeasureString(Handle graphics, LPCWSTR string, int length, Handle font, ref GpRectF layoutRect, Handle stringFormat, ref GpRectF boundingBox, int* codepointsFitted, int* linesFitted);
Status GdipGetStringFormatMeasurableCharacterRangeCount(Handle format, out int count);
Status GdipCloneStringFormat(Handle format, out Handle newFormat);

Status GdipMeasureCharacterRanges(Handle graphics, LPCWSTR string, int length, Handle font, ref GpRectF layoutRect, Handle stringFormat, int regionCount, Handle* regions);
Status GdipDrawImage(Handle graphics, Handle image, float x, float y);
Status GdipDrawImageI(Handle graphics, Handle image, int x, int y);
Status GdipDrawImageRect(Handle graphics, Handle image, float x, float y, float width, float height);
Status GdipDrawImageRectI(Handle graphics, Handle image, int x, int y, int width, int height);
Status GdipDrawImagePointRect(Handle graphics, Handle image, float x, float y, float srcx, float srcy, float srcwidth, float srcheight, GraphicsUnit srcUnit);
Status GdipDrawImagePointRectI(Handle graphics, Handle image, int x, int y, int srcx, int srcy, int srcwidth, int srcheight, GraphicsUnit srcUnit);
Status GdipDrawImageRectRect(Handle graphics, Handle image, float dstx, float dsty, float dstwidth, float dstheight, float srcx, float srcy, float srcwidth, float srcheight, GraphicsUnit srcUnit, Handle imageAttributes, GpDrawImageAbort callback, void* callbakcData);
Status GdipDrawImageRectRectI(Handle graphics, Handle image, int dstx, int dsty, int dstwidth, int dstheight, int srcx, int srcy, int srcwidth, int srcheight, GraphicsUnit srcUnit, Handle imageAttributes, GpDrawImageAbort callback, void* callbakcData);
Status GdipDrawImagePoints(Handle graphics, Handle image, GpPointF* dstpoints, int count);
Status GdipDrawImagePointsI(Handle graphics, Handle image, GpPoint* dstpoints, int count);
Status GdipDrawImagePointsRect(Handle graphics, Handle image, GpPointF* dstpoints, int count, float srcx, float srcy, float srcwidth, float srcheight, GraphicsUnit srcUnit, Handle imageAttributes, GpDrawImageAbort callback, void* callbakcData);
Status GdipDrawImagePointsRectI(Handle graphics, Handle image, GpPoint* dstpoints, int count, int srcx, int srcy, int srcwidth, int srcheight, GraphicsUnit srcUnit, Handle imageAttributes, GpDrawImageAbort callback, void* callbakcData);
Status GdipIsVisiblePoint(Handle graphics, float x, float y, out int result);
Status GdipIsVisiblePointI(Handle graphics, int x, int y, out int result);
Status GdipIsVisibleRect(Handle graphics, float x, float y, float width, float height, out int result);
Status GdipIsVisibleRectI(Handle graphics, int x, int y, int width, int height, out int result);
Status GdipGetTextRenderingHint(Handle graphics, out TextRenderingHint mode);
Status GdipSetTextRenderingHint(Handle graphics, TextRenderingHint mode);
Status GdipGetClipBounds(Handle graphics, out GpRectF rect);
Status GdipGetClipBoundsI(Handle graphics, out GpRect rect);
Status GdipGetVisibleClipBounds(Handle graphics, out GpRectF rect);
Status GdipGetVisibleClipBoundsI(Handle graphics, out GpRect rect);
Status GdipIsClipEmpty(Handle graphics, out int result);
Status GdipIsVisibleClipEmpty(Handle graphics, out int result);
Status GdipGetRenderingOrigin(Handle graphics, out int x, out int y);
Status GdipSetRenderingOrigin(Handle graphics, int x, int y);
Status GdipGetNearestColor(Handle graphics, ref int argb);
Status GdipComment(Handle graphics, uint sizeData, ubyte* data);
Status GdipTransformPoints(Handle graphics, CoordinateSpace destSpace, CoordinateSpace srcSpace, GpPointF* points, int count);
Status GdipTransformPointsI(Handle graphics, CoordinateSpace destSpace, CoordinateSpace srcSpace, GpPoint* points, int count);

Status GdipCreateMatrix(out Handle matrix);
Status GdipCreateMatrix2(float m11, float m12, float m21, float m22, float dx, float dy, out Handle matrix);
Status GdipCreateMatrix3(ref GpRectF rect, GpPointF* dstplg, out Handle matrix);
Status GdipCreateMatrix3I(ref GpRect rect, GpPoint* dstplg, out Handle matrix);
Status GdipDeleteMatrix(Handle matrix);
Status GdipCloneMatrix(Handle matrix, out Handle cloneMatrix);
Status GdipGetMatrixElements(Handle matrix, float* matrixOut);
Status GdipSetMatrixElements(Handle matrix, float m11, float m12, float m21, float m22, float xy, float dy);
Status GdipInvertMatrix(Handle matrix);
Status GdipMultiplyMatrix(Handle matrix, Handle matrix2, MatrixOrder order);
Status GdipScaleMatrix(Handle matrix, float scaleX, float scaleY, MatrixOrder order);
Status GdipShearMatrix(Handle matrix, float shearX, float shearY, MatrixOrder order);
Status GdipRotateMatrix(Handle matrix, float angle, MatrixOrder order);
Status GdipTranslateMatrix(Handle matrix, float offsetX, float offsetY, MatrixOrder order);
Status GdipIsMatrixIdentity(Handle matrix, out int result);
Status GdipIsMatrixInvertible(Handle matrix, out int result);
Status GdipTransformMatrixPoints(Handle matrix, GpPointF *pts, int count);

Status GdipGetBrushType(Handle brush, out BrushType type );
Status GdipCloneBrush(Handle brush, out Handle cloneBrush);
Status GdipDeleteBrush(Handle brush);

Status GdipCreateSolidFill(int color, out Handle brush);
Status GdipGetSolidFillColor(Handle brush, out int color);
Status GdipSetSolidFillColor(Handle brush, int color);

Status GdipCreateTexture(Handle image, WrapMode wrapMode, out Handle texture);
Status GdipCreateTexture2(Handle image, WrapMode wrapMode, float x, float y, float width, float height, out Handle texture);
Status GdipCreateTexture2I(Handle image, WrapMode wrapMode, int x, int y, int width, int height, out Handle texture);
Status GdipGetTextureImage(Handle brush, out Handle image);
Status GdipGetTextureTransform(Handle brush, out Handle matrix);
Status GdipSetTextureTransform(Handle brush, Handle matrix);
Status GdipGetTextureWrapMode(Handle brush, out WrapMode wrapmode);
Status GdipSetTextureWrapMode(Handle brush, WrapMode wrapmode);

Status GdipCreateHatchBrush(HatchStyle hatchstyle, int forecol, int backcol, out Handle brush);
Status GdipGetHatchStyle(Handle brush, out HatchStyle hatchstyle);
Status GdipGetHatchForegroundColor(Handle brush, out int forecol);
Status GdipGetHatchBackgroundColor(Handle brush, out int backcol);

Status GdipCreateLineBrushI(ref GpPoint point1, ref GpPoint point2, int color1, int color2, WrapMode wrapMode, out Handle lineGradient);
Status GdipCreateLineBrush(ref GpPointF point1, ref GpPointF point2, int color1, int color2, WrapMode wrapMode, out Handle lineGradient);
Status GdipCreateLineBrushFromRectI(ref GpRect rect, int color1, int color2, LinearGradientMode mode, WrapMode wrapMode, out Handle lineGradient);
Status GdipCreateLineBrushFromRect(ref GpRectF rect, int color1, int color2, LinearGradientMode mode, WrapMode wrapMode, out Handle lineGradient);
Status GdipCreateLineBrushFromRectWithAngleI(ref GpRect rect, int color1, int color2, float angle, int isAngleScalable, WrapMode wrapMode, out Handle lineGradient);
Status GdipCreateLineBrushFromRectWithAngle(ref GpRectF rect, int color1, int color2, float angle, int isAngleScalable, WrapMode wrapMode, out Handle lineGradient);
Status GdipGetLineBlendCount(Handle brush, out int count);
Status GdipGetLineBlend(Handle brush, float* blend, float* positions, int count);
Status GdipSetLineBlend(Handle brush, float* blend, float* positions, int count);
Status GdipGetLinePresetBlendCount(Handle brush, out int count);
Status GdipGetLinePresetBlend(Handle brush, uint* blend, float* positions, int count);
Status GdipSetLinePresetBlend(Handle brush, uint* blend, float* positions, int count);
Status GdipGetLineWrapMode(Handle brush, out WrapMode wrapmode);
Status GdipSetLineWrapMode(Handle brush, WrapMode wrapmode);
Status GdipGetLineRect(Handle brush, out GpRectF rect);
Status GdipGetLineColors(Handle brush, int* colors);
Status GdipSetLineColors(Handle brush, int color1, int color2);
Status GdipGetLineGammaCorrection(Handle brush, out int useGammaCorrection);
Status GdipSetLineGammaCorrection(Handle brush, int useGammaCorrection);
Status GdipSetLineSigmaBlend(Handle brush, float focus, float scale);
Status GdipSetLineLinearBlend(Handle brush, float focus, float scale);
Status GdipGetLineTransform(Handle brush, out Handle matrix);
Status GdipSetLineTransform(Handle brush, Handle matrix);
Status GdipResetLineTransform(Handle brush);
Status GdipMultiplyLineTransform(Handle brush, Handle matrix, MatrixOrder order);
Status GdipTranslateLineTransform(Handle brush, float dx, float dy, MatrixOrder order);
Status GdipScaleLineTransform(Handle brush, float sx, float sy, MatrixOrder order);
Status GdipRotateLineTransform(Handle brush, float angle, MatrixOrder order);

Status GdipCreatePen1(int argb, float width, GraphicsUnit unit, out Handle pen);
Status GdipCreatePen2(Handle brush, float width, GraphicsUnit unit, out Handle pen);
Status GdipDeletePen(Handle pen);
Status GdipClonePen(Handle pen, out Handle clonepen);
Status GdipSetPenLineCap197819(Handle pen, LineCap startCap, LineCap endCap, DashCap dashCap);
Status GdipGetPenStartCap(Handle pen, out LineCap startCap);
Status GdipSetPenStartCap(Handle pen, LineCap startCap);
Status GdipGetPenEndCap(Handle pen, out LineCap endCap);
Status GdipSetPenEndCap(Handle pen, LineCap endCap);
Status GdipGetPenDashCap197819(Handle pen, out DashCap endCap);
Status GdipSetPenDashCap197819(Handle pen, DashCap endCap);
Status GdipGetPenLineJoin(Handle pen, out LineJoin lineJoin);
Status GdipSetPenLineJoin(Handle pen, LineJoin lineJoin);
Status GdipGetPenMiterLimit(Handle pen, out float miterLimit);
Status GdipSetPenMiterLimit(Handle pen, float miterLimit);
Status GdipGetPenMode(Handle pen, out PenAlignment penMode);
Status GdipSetPenMode(Handle pen, PenAlignment penMode);
Status GdipGetPenTransform(Handle pen, out Handle matrix);
Status GdipSetPenTransform(Handle pen, Handle matrix);
Status GdipResetPenTransform(Handle pen);
Status GdipMultiplyPenTransform(Handle pen, Handle matrix, MatrixOrder order);
Status GdipTranslatePenTransform(Handle pen, float dx, float dy, MatrixOrder order);
Status GdipScalePenTransform(Handle pen, float sx, float sy, MatrixOrder order);
Status GdipRotatePenTransform(Handle pen, float angle, MatrixOrder order);
Status GdipGetPenColor(Handle pen, out int argb);
Status GdipSetPenColor(Handle pen, int argb);
Status GdipGetPenWidth(Handle pen, out float width);
Status GdipSetPenWidth(Handle pen, float width);
Status GdipGetPenFillType(Handle pen, out PenType type);
Status GdipGetPenBrushFill(Handle pen, out Handle brush);
Status GdipSetPenBrushFill(Handle pen, Handle brush);
Status GdipGetPenDashStyle(Handle pen, out DashStyle dashstyle);
Status GdipSetPenDashStyle(Handle pen, DashStyle dashstyle);
Status GdipGetPenDashOffset(Handle pen, out float offset);
Status GdipSetPenDashOffset(Handle pen, float offset);
Status GdipGetPenDashCount(Handle pen, out int count);
Status GdipGetPenDashArray(Handle pen, float* dash, int count);
Status GdipSetPenDashArray(Handle pen, float* dash, int count);
Status GdipGetPenCompoundCount(Handle pen, out int count);
Status GdipGetPenCompoundArray(Handle pen, float* dash, int count);
Status GdipSetPenCompoundArray(Handle pen, float* dash, int count);

Status GdipCreateRegion(out Handle region);
Status GdipCreateRegionRect(ref GpRectF rect, out Handle region);
Status GdipCreateRegionRectI(ref GpRect rect, out Handle region);
Status GdipCreateRegionPath(Handle path, out Handle region);
Status GdipCreateRegionHrgn(Handle hRgn, out Handle region);
Status GdipDeleteRegion(Handle region);
Status GdipSetInfinite(Handle region);
Status GdipSetEmpty(Handle region);
Status GdipCombineRegionRect(Handle region, ref GpRectF rect, CombineMode combineMode);
Status GdipCombineRegionRectI(Handle region, ref GpRect rect, CombineMode combineMode);
Status GdipCombineRegionPath(Handle region, Handle path, CombineMode combineMode);
Status GdipCombineRegionRegion(Handle region, Handle region, CombineMode combineMode);
Status GdipTranslateRegion(Handle region, float dx, float dy);
Status GdipTranslateRegionI(Handle region, int dx, int dy);
Status GdipTransformRegion(Handle region, Handle matrix);
Status GdipGetRegionBounds(Handle region, Handle graphics, out GpRectF rect);
Status GdipGetRegionHRgn(Handle region, Handle graphics, out Handle hRgn);
Status GdipIsEmptyRegion(Handle region, Handle graphics, out int result);
Status GdipIsInfiniteRegion(Handle region, Handle graphics, out int result);
Status GdipIsEqualRegion(Handle region1, Handle region2, Handle graphics, out int result);
Status GdipIsVisibleRegionPoint(Handle region, float x, float y, Handle graphics, out int result);
Status GdipIsVisibleRegionRect(Handle region, float x, float y, float width, float height, Handle graphics, out int result);
Status GdipIsVisibleRegionPointI(Handle region, int x, int y, Handle graphics, out int result);
Status GdipIsVisibleRegionRectI(Handle region, int x, int y, int width, int height, Handle graphics, out int result);
Status GdipGetRegionScansCount(Handle region, out int count, Handle matrix);
Status GdipGetRegionScans(Handle region, GpRectF* rects, out int count, Handle matrix);

Status GdipDisposeImage(Handle image);
Status GdipImageForceValidation(Handle image);
Status GdipLoadImageFromFileICM(LPCWSTR filename, out Handle image);
Status GdipLoadImageFromFile(LPCWSTR filename, out Handle image);
// Status GdipLoadImageFromStreamICM(IStream stream, out Handle image);
// Status GdipLoadImageFromStream(IStream stream, out Handle image);
// Status GdipGetImageRawFormat(Handle image, out GUID format);
Status GdipGetImageEncodersSize(out int numEncoders, out int size);
// Status GdipGetImageEncoders(int numEncoders, int size, GpImageCodecInfo* encoders);
// Status GdipSaveImageToFile(Handle image, LPCWSTR filename, ref GUID clsidEncoder, GpEncoderParameters* encoderParams);
// Status GdipSaveImageToStream(Handle image, IStream stream, ref GUID clsidEncoder, GpEncoderParameters* encoderParams);
// Status GdipSaveAdd(Handle image, GpEncoderParameters* encoderParams);
// Status GdipSaveAddImage(Handle image, Handle newImage, GpEncoderParameters* encoderParams);
Status GdipCloneImage(Handle image, out Handle cloneImage);
Status GdipGetImageType(Handle image, out int type);
Status GdipGetImageFlags(Handle image, out uint flags);
Status GdipGetImageWidth(Handle image, out uint width);
Status GdipGetImageHeight(Handle image, out uint height);
Status GdipGetImageHorizontalResolution(Handle image, out float resolution);
Status GdipGetImageVerticalResolution(Handle image, out float resolution);
Status GdipGetPropertyCount(Handle image, out int numOfProperty);
Status GdipGetPropertyIdList(Handle image, int numOfProperty, int* list);
Status GdipGetImagePixelFormat(Handle image, out PixelFormat format);
Status GdipGetImageDimension(Handle image, out float width, out float height);
Status GdipGetImageThumbnail(Handle image, int thumbWidth, int thumbHeight, out Handle thumbImage, GpGetThumbnailImageAbort callback, void* callbackData);
// Status GdipImageGetFrameCount(Handle image, ref GUID dimensionID, out int count);
// Status GdipImageSelectActiveFrame(Handle image, ref GUID dimensionID, int frameCount);
Status GdipImageGetFrameDimensionsCount(Handle image, out int count);
// Status GdipImageGetFrameDimensionsList(Handle image, GUID* dimensionIDs, int count);
Status GdipImageRotateFlip(Handle image, RotateFlipType rotateFlipType);
Status GdipGetPropertyItemSize(Handle image, int propId, out uint propSize);
Status GdipGetPropertyItem(Handle image, int propId, uint propSize, GpPropertyItem* buffer);
Status GdipSetPropertyItem(Handle image, ref GpPropertyItem buffer);
Status GdipRemovePropertyItem(Handle image, int propId);
Status GdipGetPropertySize(Handle image, out uint totalBufferSize, ref int numProperties);
Status GdipGetAllPropertyItems(Handle image, uint totalBufferSize, int numProperties, GpPropertyItem* allItems);
Status GdipGetImageBounds(Handle image, out GpRectF srcRect, out GraphicsUnit srcUnit);
// Status GdipGetEncoderParameterListSize(Handle image, ref GUID clsidEncoder, out uint size);
// Status GdipGetEncoderParameterList(Handle image, ref GUID clsidEncoder, uint size, GpEncoderParameters* buffer);
Status GdipGetImagePaletteSize(Handle image, out int size);
Status GdipGetImagePalette(Handle image, GpColorPalette* palette, int size);
Status GdipSetImagePalette(Handle image, GpColorPalette* palette);

Status GdipCreateBitmapFromScan0(int width, int height, int stride, PixelFormat format, ubyte* scan0, out Handle bitmap);
Status GdipCreateBitmapFromHBITMAP(Handle hbitmap, Handle hpalette, out Handle bitmap);
Status GdipCreateBitmapFromHICON(Handle hicon, out Handle bitmap);
Status GdipCreateBitmapFromFileICM(LPCWSTR fileName, out Handle bitmap);
Status GdipCreateBitmapFromFile(LPCWSTR fileName, out Handle bitmap);
// Status GdipCreateBitmapFromStreamICM(IStream stream, out Handle bitmap);
// Status GdipCreateBitmapFromStream(IStream stream, out Handle bitmap);
Status GdipCreateBitmapFromGraphics(int width, int height, Handle graphics, out Handle bitmap);
Status GdipCloneBitmapArea(float x, float y, float width, float height, PixelFormat format, Handle srcbitmap, out Handle dstbitmap);
Status GdipCloneBitmapAreaI(int x, int y, int width, int height, PixelFormat format, Handle srcbitmap, out Handle dstbitmap);
Status GdipBitmapGetPixel(Handle bitmap, int x, int y, out int color);
Status GdipBitmapSetPixel(Handle bitmap, int x, int y, int color);
Status GdipBitmapLockBits(Handle bitmap, GpRect* rect, ImageLockMode flags, PixelFormat format, GpBitmapData* lockedBitmapData);
Status GdipBitmapUnlockBits(Handle bitmap, GpBitmapData* lockedBitmapData);
Status GdipBitmapSetResolution(Handle bitmap, float xdpi, float ydpi);
Status GdipCreateHICONFromBitmap(Handle bitmap, out Handle hbmReturn);
Status GdipCreateHBITMAPFromBitmap(Handle bitmap, out Handle hbmReturn, int background);

Status GdipCreateImageAttributes(out Handle imageattr);
Status GdipDisposeImageAttributes(Handle imageattr);
Status GdipSetImageAttributesColorMatrix(Handle imageattr, ColorAdjustType type, int enableFlag, GpColorMatrix* colorMatrix, GpColorMatrix* grayMatrix, ColorMatrixFlag flags);
Status GdipSetImageAttributesThreshold(Handle imageattr, ColorAdjustType type, int enableFlag, float threshold);
Status GdipSetImageAttributesGamma(Handle imageattr, ColorAdjustType type, int enableFlag, float gamma);
Status GdipSetImageAttributesNoOp(Handle imageattr, ColorAdjustType type, int enableFlag);
Status GdipSetImageAttributesColorKeys(Handle imageattr, ColorAdjustType type, int enableFlag, int colorLow, int colorHigh);
Status GdipSetImageAttributesOutputChannel(Handle imageattr, ColorAdjustType type, int enableFlag, ColorChannelFlag flags);
Status GdipSetImageAttributesOutputChannelColorProfile(Handle imageattr, ColorAdjustType type, int enableFlag, LPCWSTR colorProfileFilename);
Status GdipSetImageAttributesWrapMode(Handle imageattr, WrapMode wrap, int argb, int clamp);

Status GdipNewInstalledFontCollection(out Handle fontCollection);
Status GdipNewPrivateFontCollection(out Handle fontCollection);
Status GdipDeletePrivateFontCollection(Handle fontCollection);
Status GdipPrivateAddFontFile(Handle fontCollection, LPCWSTR filename);
Status GdipPrivateAddMemoryFont(Handle fontCollection, void* memory, int length);
Status GdipGetFontCollectionFamilyCount(Handle fontCollection, out int numFound);
Status GdipGetFontCollectionFamilyList(Handle fontCollection, int numSought, Handle* gpfamilies, out int numFound);

Status GdipCreateFontFamilyFromName(LPCWSTR name, Handle fontCollection, out Handle FontFamily);
Status GdipDeleteFontFamily(Handle FontFamily);
Status GdipCloneFontFamily(Handle FontFamily, out Handle clonedFontFamily);
Status GdipGetFamilyName(Handle family, LPCWSTR name, int language);
Status GdipGetGenericFontFamilyMonospace(out Handle nativeFamily);
Status GdipGetGenericFontFamilySerif(out Handle nativeFamily);
Status GdipGetGenericFontFamilySansSerif(out Handle nativeFamily);
Status GdipGetEmHeight(Handle family, FontStyle style, out short EmHeight);
Status GdipGetCellAscent(Handle family, FontStyle style, out short CellAscent);
Status GdipGetCellDescent(Handle family, FontStyle style, out short CellDescent);
Status GdipGetLineSpacing(Handle family, FontStyle style, out short LineSpacing);
Status GdipIsStyleAvailable(Handle family, FontStyle style, out int IsStyleAvailable);

Status GdipCreateFont(Handle fontFamily, float emSize, int style, int unit, out Handle font);
Status GdipCreateFontFromDC(Handle hdc, out Handle font);
Status GdipDeleteFont(Handle font);
Status GdipCloneFont(Handle font, out Handle cloneFont);
Status GdipGetFontSize(Handle font, out float size);
Status GdipGetFontHeight(Handle font, Handle graphics, out float height);
Status GdipGetFontHeightGivenDPI(Handle font, float dpi, out float height);
Status GdipGetFontStyle(Handle font, out FontStyle style);
Status GdipGetFontUnit(Handle font, out GraphicsUnit unit);
Status GdipGetFamily(Handle font, out Handle family);
Status GdipCreateFontFromLogfontW( Handle hdc, ref LOGFONTW logfont, out Handle font);
Status GdipCreateFontFromLogfontA( Handle hdc, ref LOGFONTA logfont, out Handle font );

Status GdipGetLogFontW(Handle font, Handle graphics, out LOGFONTW logfontW);
alias GdipGetLogFontW GdipGetLogFont;

Status GdipCreateStringFormat(StringFormatFlags formatAttributes, int language, out Handle format);
Status GdipDeleteStringFormat(Handle format);
Status GdipGetStringFormatFlags(Handle format, out StringFormatFlags flags);
Status GdipSetStringFormatFlags(Handle format, StringFormatFlags flags);
Status GdipGetStringFormatAlign(Handle format, out StringAlignment alignment);
Status GdipSetStringFormatAlign(Handle format, StringAlignment alignment);
Status GdipGetStringFormatLineAlign(Handle format, out StringAlignment alignment);
Status GdipSetStringFormatLineAlign(Handle format, StringAlignment alignment);
Status GdipGetStringFormatTrimming(Handle format, out StringTrimming trimming);
Status GdipSetStringFormatTrimming(Handle format, StringTrimming trimming);

Status GdipCreatePath(FillMode brushMode, out Handle path);
Status GdipCreatePath2(GpPointF*, ubyte*, int, FillMode, out Handle);
Status GdipCreatePath2I(GpPoint*, ubyte*, int, FillMode, out Handle);
Status GdipDeletePath(Handle path);
Status GdipClonePath(Handle path, out Handle clonepath);
Status GdipResetPath(Handle path);
Status GdipGetPathFillMode(Handle path, out FillMode fillmode);
Status GdipSetPathFillMode(Handle path, FillMode fillmode);
Status GdipStartPathFigure(Handle path);
Status GdipClosePathFigure(Handle path);
Status GdipClosePathFigures(Handle path);
Status GdipSetPathMarker(Handle path);
Status GdipClearPathMarkers(Handle path);
Status GdipReversePath(Handle path);
Status GdipGetPathLastPoint(Handle path, out GpPointF lastPoint);
Status GdipAddPathLine(Handle path, float x1, float y1, float x2, float y2);
Status GdipAddPathLineI(Handle path, int x1, int y1, int x2, int y2);
Status GdipAddPathLine2(Handle path, GpPointF* points, int count);
Status GdipAddPathLine2I(Handle path, GpPoint* points, int count);
Status GdipAddPathArc(Handle path, float x, float y, float width, float height, float startAngle, float sweepAngle);
Status GdipAddPathArcI(Handle path, int x, int y, int width, int height, float startAngle, float sweepAngle);
Status GdipAddPathBezier(Handle path, float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4);
Status GdipAddPathBezierI(Handle path, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);
Status GdipAddPathBeziers(Handle path, GpPointF* points, int count);
Status GdipAddPathBeziersI(Handle path, GpPoint* points, int count);
Status GdipAddPathCurve(Handle path, GpPointF* points, int count);
Status GdipAddPathCurveI(Handle path, GpPoint* points, int count);
Status GdipAddPathCurve2(Handle path, GpPointF* points, int count, float tension);
Status GdipAddPathCurve2I(Handle path, GpPoint* points, int count, float tension);
Status GdipAddPathCurve3(Handle path, GpPointF* points, int count, int offset, int numberOfSegments, float tension);
Status GdipAddPathCurve3I(Handle path, GpPoint* points, int count, int offset, int numberOfSegments, float tension);
Status GdipAddPathClosedCurve(Handle path, GpPointF* points, int count);
Status GdipAddPathClosedCurveI(Handle path, GpPoint* points, int count);
Status GdipAddPathClosedCurve2(Handle path, GpPointF* points, int count, float tension);
Status GdipAddPathClosedCurve2I(Handle path, GpPoint* points, int count, float tension);
Status GdipAddPathRectangle(Handle path, float x, float y, float width, float height);
Status GdipAddPathRectangleI(Handle path, int x, int y, int width, int height);
Status GdipAddPathRectangles(Handle path, GpRectF* rects, int count);
Status GdipAddPathRectanglesI(Handle path, GpRect* rects, int count);
Status GdipAddPathEllipse(Handle path, float x, float y, float width, float height);
Status GdipAddPathEllipseI(Handle path, int x, int y, int width, int height);
Status GdipAddPathPie(Handle path, float x, float y, float width, float height, float startAngle, float sweepAngle);
Status GdipAddPathPieI(Handle path, int x, int y, int width, int height, float startAngle, float sweepAngle);
Status GdipAddPathPolygon(Handle path, GpPointF* points, int count);
Status GdipAddPathPolygonI(Handle path, GpPoint* points, int count);
Status GdipAddPathPath(Handle path, Handle addingPath, int connect);
Status GdipAddPathString(Handle path, LPCWSTR string, int length, Handle family, FontStyle style, float emSize, ref GpRectF layoutRect, Handle format);
Status GdipAddPathStringI(Handle path, LPCWSTR string, int length, Handle family, FontStyle style, float emSize, ref GpRect layoutRect, Handle format);
Status GdipTransformPath(Handle path, Handle matrix);
Status GdipGetPathWorldBounds(Handle path, out GpRectF bounds, Handle matrix, Handle pen);
Status GdipFlattenPath(Handle path, Handle matrix, float flatness);
Status GdipWidenPath(Handle path, Handle pen, Handle matrix, float flatness);
Status GdipWindingModeOutline(Handle path, Handle matrix, float flatness);
Status GdipWarpPath(Handle path, Handle matrix, GpPointF* points, int count, float srcx, float srcy, float srcwidth, float srcwidth, WarpMode warpMode, float flatness);
Status GdipGetPointCount(Handle path, out int count);
Status GdipGetPathTypes(Handle path, byte* types, int count);
Status GdipGetPathPoints(Handle path, GpPointF* points, int count);
Status GdipIsVisiblePathPoint(Handle path, float x, float y, Handle graphics, out int result);
Status GdipIsVisiblePathPointI(Handle path, int x, int y, Handle graphics, out int result);
Status GdipIsOutlineVisiblePathPoint(Handle path, float x, float y, Handle pen, Handle graphics, out int result);
Status GdipIsOutlineVisiblePathPointI(Handle path, int x, int y, Handle pen, Handle graphics, out int result);
Status GdipDrawPath(Handle graphics, Handle pen, Handle path);


Status GdipCreatePathIter(out Handle iterator, Handle path);
Status GdipDeletePathIter(Handle iterator);
Status GdipPathIterNextSubpath(Handle iterator, out int resultCount, out int startIndex, out int endIndex, out int isClosed);
Status GdipPathIterNextSubpathPath(Handle iterator, out int resultCount, Handle path, out int isClosed);
Status GdipPathIterNextPathType(Handle iterator, out int resultCount, out ubyte pathType, out int startIndex, out int endIndex);
Status GdipPathIterNextMarker(Handle iterator, out int resultCount, out int startIndex, out int endIndex);
Status GdipPathIterNextMarkerPath(Handle iterator, out int resultCount, Handle path);
Status GdipPathIterGetCount(Handle iterator, out int count);
Status GdipPathIterGetSubpathCount(Handle iterator, out int count);
Status GdipPathIterHasCurve(Handle iterator, out int hasCurve);
Status GdipPathIterRewind(Handle iterator);
Status GdipPathIterEnumerate(Handle iterator, out int resultCount, GpPointF* points, ubyte* types, int count);
Status GdipPathIterCopyData(Handle iterator, out int resultCount, GpPointF* points, ubyte* types, int startIndex, int endIndex);

Status GdipCreatePathGradient(GpPointF* points, int count, WrapMode wrapMode, out Handle polyGradient);
Status GdipCreatePathGradientI(GpPoint* points, int count, WrapMode wrapMode, out Handle polyGradient);
Status GdipCreatePathGradientFromPath(Handle path, out Handle polyGradient);
Status GdipGetPathGradientCenterColor(Handle brush, out int colors);
Status GdipSetPathGradientCenterColor(Handle brush, int colors);
Status GdipGetPathGradientSurroundColorCount(Handle brush, out int count);
Status GdipGetPathGradientSurroundColorsWithCount(Handle brush, int* color, ref int count);
Status GdipSetPathGradientSurroundColorsWithCount(Handle brush, int* color, ref int count);
Status GdipGetPathGradientCenterPoint(Handle brush, ref GpPointF point);
Status GdipSetPathGradientCenterPoint(Handle brush, ref GpPointF point);
Status GdipGetPathGradientRect(Handle brush, ref GpRectF rect);
Status GdipGetPathGradientBlendCount(Handle brush, out int count);
Status GdipGetPathGradientBlend(Handle brush, float* blend, float* positions, int count);
Status GdipSetPathGradientBlend(Handle brush, float* blend, float* positions, int count);
Status GdipGetPathGradientPresetBlendCount(Handle brush, out int count);
Status GdipGetPathGradientPresetBlend(Handle brush, int* blend, float* positions, int count);
Status GdipSetPathGradientPresetBlend(Handle brush, int* blend, float* positions, int count);
Status GdipSetPathGradientSigmaBlend(Handle brush, float focus, float scale);
Status GdipSetPathGradientLinearBlend(Handle brush, float focus, float scale);
Status GdipGetPathGradientTransform(Handle brush, out Handle matrix);
Status GdipSetPathGradientTransform(Handle brush, Handle matrix);
Status GdipResetPathGradientTransform(Handle brush);
Status GdipMultiplyPathGradientTransform(Handle brush, Handle matrix, MatrixOrder order);
Status GdipRotatePathGradientTransform(Handle brush, float angle, MatrixOrder order);
Status GdipTranslatePathGradientTransform(Handle brush, float dx, float dy, MatrixOrder order);
Status GdipScalePathGradientTransform(Handle brush, float sx, float sy, MatrixOrder order);
Status GdipGetPathGradientFocusScales(Handle brush, out float xScale, out float yScale);
Status GdipSetPathGradientFocusScales(Handle brush, float xScale, float yScale);
Status GdipGetPathGradientWrapMode(Handle brush, out WrapMode wrapMode);
Status GdipSetPathGradientWrapMode(Handle brush, WrapMode wrapMode);

//added

Status GdipResetTextureTransform( Handle brush );
Status GdipScaleTextureTransform( Handle brush, float sx, float sy, MatrixOrder order );
Status GdipTranslateTextureTransform( Handle brush, float dx, float dy, MatrixOrder order);
Status GdipStringFormatGetGenericDefault(out Handle format);
Status GdipStringFormatGetGenericTypographic(out Handle format);
Status GdipSetStringFormatHotkeyPrefix(Handle format, int hotkeyPrefix);
Status GdipSetStringFormatTabStops( Handle format, float firstTabOffset, int count, float* tabStops);

void loadLib_Gdip(){
    // do nothing in this version
}

}
else{ // version(!STATIC_GDIPLUS)
import java.nonstandard.SharedLib;
Status function( uint* token, GdiplusStartupInput* input, GdiplusStartupOutput* output) GdiplusStartup;
void   function(uint token) GdiplusShutdown;
Status function(Handle hdc, out Handle graphics) GdipCreateFromHDC;
Status function(Handle hdc, Handle hDevice, out Handle graphics) GdipCreateFromHDC2;
Status function(Handle hwnd, out Handle graphics) GdipCreateFromHWND;
Status function(Handle image, out Handle graphics) GdipGetImageGraphicsContext;
Status function(Handle graphics) GdipDeleteGraphics;
Status function(Handle graphics, out Handle hdc) GdipGetDC;
Status function(Handle graphics, Handle hdc) GdipReleaseDC;
Status function(Handle graphics, Handle srcgraphics, CombineMode combineMode) GdipSetClipGraphics;
Status function(Handle graphics, int x, int y, int width, int height, CombineMode combineMode) GdipSetClipRectI;
Status function(Handle graphics, float x, float y, float width, float height, CombineMode combineMode) GdipSetClipRect;
Status function(Handle graphics, Handle path, CombineMode combineMode) GdipSetClipPath;
Status function(Handle graphics, Handle region, CombineMode combineMode) GdipSetClipRegion;
Status function(Handle graphics, HRGN hRgn, CombineMode combineMode) GdipSetClipHrgn;
Status function(Handle graphics, out Handle region) GdipGetClip;
Status function(Handle graphics) GdipResetClip;
Status function(Handle graphics, out uint state) GdipSaveGraphics;
Status function(Handle graphics, int state) GdipRestoreGraphics;
Status function(Handle graphics, FlushIntention intention) GdipFlush;
Status function(Handle graphics, float sx, float sy, MatrixOrder order) GdipScaleWorldTransform;
Status function(Handle graphics, float angle, MatrixOrder order) GdipRotateWorldTransform;
Status function(Handle graphics, float dx, float dy, MatrixOrder order) GdipTranslateWorldTransform;
Status function(Handle graphics, Handle matrix, MatrixOrder order) GdipMultiplyWorldTransform;
Status function(Handle graphics) GdipResetWorldTransform;
Status function(Handle graphics, ref GpRectF dstrect, ref GpRectF srcrect, GraphicsUnit unit, out int state) GdipBeginContainer;
Status function(Handle graphics, ref GpRect dstrect, ref GpRect srcrect, GraphicsUnit unit, out int state) GdipBeginContainerI;
Status function(Handle graphics, out int state) GdipBeginContainer2;
Status function(Handle graphics, int state) GdipEndContainer;
Status function(Handle graphics, out float dpi) GdipGetDpiX;
Status function(Handle graphics, out float dpi) GdipGetDpiY;
Status function(Handle graphics, out GraphicsUnit unit) GdipGetPageUnit;
Status function(Handle graphics, GraphicsUnit unit) GdipSetPageUnit;
Status function(Handle graphics, out float scale) GdipGetPageScale;
Status function(Handle graphics, float scale) GdipSetPageScale;
Status function(Handle graphics, Handle matrix) GdipGetWorldTransform;
Status function(Handle graphics, Handle matrix) GdipSetWorldTransform;
Status function(Handle graphics, out CompositingMode compositingMode) GdipGetCompositingMode;
Status function(Handle graphics, CompositingMode compositingMode) GdipSetCompositingMode;
Status function(Handle graphics, out CompositingQuality compositingQuality) GdipGetCompositingQuality;
Status function(Handle graphics, CompositingQuality compositingQuality) GdipSetCompositingQuality;
Status function(Handle graphics, out InterpolationMode interpolationMode) GdipGetInterpolationMode;
Status function(Handle graphics, InterpolationMode interpolationMode) GdipSetInterpolationMode;
Status function(Handle graphics, out SmoothingMode smoothingMode) GdipGetSmoothingMode;
Status function(Handle graphics, SmoothingMode smoothingMode) GdipSetSmoothingMode;
Status function(Handle graphics, out PixelOffsetMode pixelOffsetMode) GdipGetPixelOffsetMode;
Status function(Handle graphics, PixelOffsetMode pixelOffsetMode) GdipSetPixelOffsetMode;
Status function(Handle graphics, out uint textContrast) GdipGetTextContrast;
Status function(Handle graphics, uint textContrast) GdipSetTextContrast;
Status function(Handle graphics, int color) GdipGraphicsClear;
Status function(Handle graphics, Handle pen, float x1, float y1, float x2, float y2) GdipDrawLine;
Status function(Handle graphics, Handle pen, GpPointF* points, int count) GdipDrawLines;
Status function(Handle graphics, Handle pen, int x1, int y1, int x2, int y2) GdipDrawLineI;
Status function(Handle graphics, Handle pen, GpPoint* points, int count) GdipDrawLinesI;
Status function(Handle graphics, Handle pen, float x, float y, float width, float height, float startAngle, float sweepAngle) GdipDrawArc;
Status function(Handle graphics, Handle pen, int x, int y, int width, int height, float startAngle, float sweepAngle) GdipDrawArcI;
Status function(Handle graphics, Handle pen, float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) GdipDrawBezier;
Status function(Handle graphics, Handle pen, GpPointF* points, int count) GdipDrawBeziers;
Status function(Handle graphics, Handle pen, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4) GdipDrawBezierI;
Status function(Handle graphics, Handle pen, GpPoint* points, int count) GdipDrawBeziersI;
Status function(Handle graphics, Handle pen, float x, float y, float width, float height) GdipDrawRectangle;
Status function(Handle graphics, Handle pen, GpRectF* rects, int count) GdipDrawRectangles;
Status function(Handle graphics, Handle pen, int x, int y, int width, int height) GdipDrawRectangleI;
Status function(Handle graphics, Handle pen, GpRect* rects, int count) GdipDrawRectanglesI;
Status function(Handle graphics, Handle pen, float x, float y, float width, float height) GdipDrawEllipse;
Status function(Handle graphics, Handle pen, int x, int y, int width, int height) GdipDrawEllipseI;
Status function(Handle graphics, Handle pen, float x, float y, float width, float height, float startAngle, float sweepAngle) GdipDrawPie;
Status function(Handle graphics, Handle pen, int x, int y, int width, int height, float startAngle, float sweepAngle) GdipDrawPieI;
Status function(Handle graphics, Handle pen, GpPointF* points, int count) GdipDrawPolygon;
Status function(Handle graphics, Handle pen, GpPoint* points, int count) GdipDrawPolygonI;
Status function(Handle graphics, Handle pen, GpPointF* points, int count) GdipDrawCurve;
Status function(Handle graphics, Handle pen, GpPointF* points, int count, float tension) GdipDrawCurve2;
Status function(Handle graphics, Handle pen, GpPointF* points, int count, int offset, int numberOfSegments, float tension) GdipDrawCurve3;
Status function(Handle graphics, Handle pen, GpPoint* points, int count) GdipDrawCurveI;
Status function(Handle graphics, Handle pen, GpPoint* points, int count, float tension) GdipDrawCurve2I;
Status function(Handle graphics, Handle pen, GpPoint* points, int count, int offset, int numberOfSegments, float tension) GdipDrawCurve3I;
Status function(Handle graphics, Handle pen, GpPointF* points, int count) GdipDrawClosedCurve;
Status function(Handle graphics, Handle pen, GpPointF* points, int count, float tension) GdipDrawClosedCurve2;
Status function(Handle graphics, Handle pen, GpPoint* points, int count) GdipDrawClosedCurveI;
Status function(Handle graphics, Handle pen, GpPoint* points, int count, float tension) GdipDrawClosedCurve2I;
Status function(Handle graphics, Handle brush, int x, int y, int width, int height) GdipFillRectangleI;
Status function(Handle graphics, Handle brush, float x, float y, float width, float height) GdipFillRectangle;
Status function(Handle graphics, Handle brush, GpRect* rects, int count) GdipFillRectanglesI;
Status function(Handle graphics, Handle brush, GpRectF* rects, int count) GdipFillRectangles;
Status function(Handle graphics, Handle brush, GpPointF* rects, int count, FillMode fillMode) GdipFillPolygon;
Status function(Handle graphics, Handle brush, GpPoint* rects, int count, FillMode fillMode) GdipFillPolygonI;
Status function(Handle graphics, Handle brush, float x, float y, float width, float height) GdipFillEllipse;
Status function(Handle graphics, Handle brush, int x, int y, int width, int height) GdipFillEllipseI;
Status function(Handle graphics, Handle brush, float x, float y, float width, float height, float startAngle, float sweepAngle) GdipFillPie;
Status function(Handle graphics, Handle brush, int x, int y, int width, int height, float startAngle, float sweepAngle) GdipFillPieI;
Status function(Handle graphics, Handle brush, Handle path) GdipFillPath;
Status function(Handle graphics, Handle brush, GpPointF* points, int count) GdipFillClosedCurve;
Status function(Handle graphics, Handle brush, GpPoint* points, int count) GdipFillClosedCurveI;
Status function(Handle graphics, Handle brush, GpPointF* points, int count, FillMode fillMode, float tension) GdipFillClosedCurve2;
Status function(Handle graphics, Handle brush, GpPoint* points, int count, FillMode fillMode, float tension) GdipFillClosedCurve2I;
Status function(Handle graphics, Handle brush, Handle region) GdipFillRegion;
Status function(Handle graphics, LPCWSTR string, int length, Handle font, ref GpRectF layoutRect, Handle stringFormat, Handle brush) GdipDrawString;
Status function(Handle graphics, LPCWSTR string, int length, Handle font, ref GpRectF layoutRect, Handle stringFormat, ref GpRectF boundingBox, int* codepointsFitted, int* linesFitted) GdipMeasureString;
Status function(Handle format, out int count) GdipGetStringFormatMeasurableCharacterRangeCount;
Status function(Handle format, out Handle newFormat) GdipCloneStringFormat;
Status function(Handle graphics, LPCWSTR string, int length, Handle font, ref GpRectF layoutRect, Handle stringFormat, int regionCount, Handle* regions) GdipMeasureCharacterRanges;
Status function(Handle graphics, Handle image, float x, float y) GdipDrawImage;
Status function(Handle graphics, Handle image, int x, int y) GdipDrawImageI;
Status function(Handle graphics, Handle image, float x, float y, float width, float height) GdipDrawImageRect;
Status function(Handle graphics, Handle image, int x, int y, int width, int height) GdipDrawImageRectI;
Status function(Handle graphics, Handle image, float x, float y, float srcx, float srcy, float srcwidth, float srcheight, GraphicsUnit srcUnit) GdipDrawImagePointRect;
Status function(Handle graphics, Handle image, int x, int y, int srcx, int srcy, int srcwidth, int srcheight, GraphicsUnit srcUnit) GdipDrawImagePointRectI;
Status function(Handle graphics, Handle image, float dstx, float dsty, float dstwidth, float dstheight, float srcx, float srcy, float srcwidth, float srcheight, GraphicsUnit srcUnit, Handle imageAttributes, GpDrawImageAbort callback, void* callbakcData) GdipDrawImageRectRect;
Status function(Handle graphics, Handle image, int dstx, int dsty, int dstwidth, int dstheight, int srcx, int srcy, int srcwidth, int srcheight, GraphicsUnit srcUnit, Handle imageAttributes, GpDrawImageAbort callback, void* callbakcData) GdipDrawImageRectRectI;
Status function(Handle graphics, Handle image, GpPointF* dstpoints, int count) GdipDrawImagePoints;
Status function(Handle graphics, Handle image, GpPoint* dstpoints, int count) GdipDrawImagePointsI;
Status function(Handle graphics, Handle image, GpPointF* dstpoints, int count, float srcx, float srcy, float srcwidth, float srcheight, GraphicsUnit srcUnit, Handle imageAttributes, GpDrawImageAbort callback, void* callbakcData) GdipDrawImagePointsRect;
Status function(Handle graphics, Handle image, GpPoint* dstpoints, int count, int srcx, int srcy, int srcwidth, int srcheight, GraphicsUnit srcUnit, Handle imageAttributes, GpDrawImageAbort callback, void* callbakcData) GdipDrawImagePointsRectI;
Status function(Handle graphics, float x, float y, out int result) GdipIsVisiblePoint;
Status function(Handle graphics, int x, int y, out int result) GdipIsVisiblePointI;
Status function(Handle graphics, float x, float y, float width, float height, out int result) GdipIsVisibleRect;
Status function(Handle graphics, int x, int y, int width, int height, out int result) GdipIsVisibleRectI;
Status function(Handle graphics, out TextRenderingHint mode) GdipGetTextRenderingHint;
Status function(Handle graphics, TextRenderingHint mode) GdipSetTextRenderingHint;
Status function(Handle graphics, out GpRectF rect) GdipGetClipBounds;
Status function(Handle graphics, out GpRect rect) GdipGetClipBoundsI;
Status function(Handle graphics, out GpRectF rect) GdipGetVisibleClipBounds;
Status function(Handle graphics, out GpRect rect) GdipGetVisibleClipBoundsI;
Status function(Handle graphics, out int result) GdipIsClipEmpty;
Status function(Handle graphics, out int result) GdipIsVisibleClipEmpty;
Status function(Handle graphics, out int x, out int y) GdipGetRenderingOrigin;
Status function(Handle graphics, int x, int y) GdipSetRenderingOrigin;
Status function(Handle graphics, ref int argb) GdipGetNearestColor;
Status function(Handle graphics, uint sizeData, ubyte* data) GdipComment;
Status function(Handle graphics, CoordinateSpace destSpace, CoordinateSpace srcSpace, GpPointF* points, int count) GdipTransformPoints;
Status function(Handle graphics, CoordinateSpace destSpace, CoordinateSpace srcSpace, GpPoint* points, int count) GdipTransformPointsI;
Status function(out Handle matrix) GdipCreateMatrix;
Status function(float m11, float m12, float m21, float m22, float dx, float dy, out Handle matrix) GdipCreateMatrix2;
Status function(ref GpRectF rect, GpPointF* dstplg, out Handle matrix) GdipCreateMatrix3;
Status function(ref GpRect rect, GpPoint* dstplg, out Handle matrix) GdipCreateMatrix3I;
Status function(Handle matrix) GdipDeleteMatrix;
Status function(Handle matrix, out Handle cloneMatrix) GdipCloneMatrix;
Status function(Handle matrix, float* matrixOut) GdipGetMatrixElements;
Status function(Handle matrix, float m11, float m12, float m21, float m22, float xy, float dy) GdipSetMatrixElements;
Status function(Handle matrix) GdipInvertMatrix;
Status function(Handle matrix, Handle matrix2, MatrixOrder order) GdipMultiplyMatrix;
Status function(Handle matrix, float scaleX, float scaleY, MatrixOrder order) GdipScaleMatrix;
Status function(Handle matrix, float shearX, float shearY, MatrixOrder order) GdipShearMatrix;
Status function(Handle matrix, float angle, MatrixOrder order) GdipRotateMatrix;
Status function(Handle matrix, float offsetX, float offsetY, MatrixOrder order) GdipTranslateMatrix;
Status function(Handle matrix, out int result) GdipIsMatrixIdentity;
Status function(Handle matrix, out int result) GdipIsMatrixInvertible;
Status function(Handle matrix, GpPointF *pts, int count) GdipTransformMatrixPoints;
Status function(Handle brush, out BrushType type ) GdipGetBrushType;
Status function(Handle brush, out Handle cloneBrush) GdipCloneBrush;
Status function(Handle brush) GdipDeleteBrush;
Status function(int color, out Handle brush) GdipCreateSolidFill;
Status function(Handle brush, out int color) GdipGetSolidFillColor;
Status function(Handle brush, int color) GdipSetSolidFillColor;
Status function(Handle image, WrapMode wrapMode, out Handle texture) GdipCreateTexture;
Status function(Handle image, WrapMode wrapMode, float x, float y, float width, float height, out Handle texture) GdipCreateTexture2;
Status function(Handle image, WrapMode wrapMode, int x, int y, int width, int height, out Handle texture) GdipCreateTexture2I;
Status function(Handle brush, out Handle image) GdipGetTextureImage;
Status function(Handle brush, out Handle matrix) GdipGetTextureTransform;
Status function(Handle brush, Handle matrix) GdipSetTextureTransform;
Status function(Handle brush, out WrapMode wrapmode) GdipGetTextureWrapMode;
Status function(Handle brush, WrapMode wrapmode) GdipSetTextureWrapMode;
Status function(HatchStyle hatchstyle, int forecol, int backcol, out Handle brush) GdipCreateHatchBrush;
Status function(Handle brush, out HatchStyle hatchstyle) GdipGetHatchStyle;
Status function(Handle brush, out int forecol) GdipGetHatchForegroundColor;
Status function(Handle brush, out int backcol) GdipGetHatchBackgroundColor;
Status function(ref GpPoint point1, ref GpPoint point2, int color1, int color2, WrapMode wrapMode, out Handle lineGradient) GdipCreateLineBrushI;
Status function(ref GpPointF point1, ref GpPointF point2, int color1, int color2, WrapMode wrapMode, out Handle lineGradient) GdipCreateLineBrush;
Status function(ref GpRect rect, int color1, int color2, LinearGradientMode mode, WrapMode wrapMode, out Handle lineGradient) GdipCreateLineBrushFromRectI;
Status function(ref GpRectF rect, int color1, int color2, LinearGradientMode mode, WrapMode wrapMode, out Handle lineGradient) GdipCreateLineBrushFromRect;
Status function(ref GpRect rect, int color1, int color2, float angle, int isAngleScalable, WrapMode wrapMode, out Handle lineGradient) GdipCreateLineBrushFromRectWithAngleI;
Status function(ref GpRectF rect, int color1, int color2, float angle, int isAngleScalable, WrapMode wrapMode, out Handle lineGradient) GdipCreateLineBrushFromRectWithAngle;
Status function(Handle brush, out int count) GdipGetLineBlendCount;
Status function(Handle brush, float* blend, float* positions, int count) GdipGetLineBlend;
Status function(Handle brush, float* blend, float* positions, int count) GdipSetLineBlend;
Status function(Handle brush, out int count) GdipGetLinePresetBlendCount;
Status function(Handle brush, uint* blend, float* positions, int count) GdipGetLinePresetBlend;
Status function(Handle brush, uint* blend, float* positions, int count) GdipSetLinePresetBlend;
Status function(Handle brush, out WrapMode wrapmode) GdipGetLineWrapMode;
Status function(Handle brush, WrapMode wrapmode) GdipSetLineWrapMode;
Status function(Handle brush, out GpRectF rect) GdipGetLineRect;
Status function(Handle brush, int* colors) GdipGetLineColors;
Status function(Handle brush, int color1, int color2) GdipSetLineColors;
Status function(Handle brush, out int useGammaCorrection) GdipGetLineGammaCorrection;
Status function(Handle brush, int useGammaCorrection) GdipSetLineGammaCorrection;
Status function(Handle brush, float focus, float scale) GdipSetLineSigmaBlend;
Status function(Handle brush, float focus, float scale) GdipSetLineLinearBlend;
Status function(Handle brush, out Handle matrix) GdipGetLineTransform;
Status function(Handle brush, Handle matrix) GdipSetLineTransform;
Status function(Handle brush) GdipResetLineTransform;
Status function(Handle brush, Handle matrix, MatrixOrder order) GdipMultiplyLineTransform;
Status function(Handle brush, float dx, float dy, MatrixOrder order) GdipTranslateLineTransform;
Status function(Handle brush, float sx, float sy, MatrixOrder order) GdipScaleLineTransform;
Status function(Handle brush, float angle, MatrixOrder order) GdipRotateLineTransform;
Status function(int argb, float width, GraphicsUnit unit, out Handle pen) GdipCreatePen1;
Status function(Handle brush, float width, GraphicsUnit unit, out Handle pen) GdipCreatePen2;
Status function(Handle pen) GdipDeletePen;
Status function(Handle pen, out Handle clonepen) GdipClonePen;
Status function(Handle pen, LineCap startCap, LineCap endCap, DashCap dashCap) GdipSetPenLineCap197819;
Status function(Handle pen, out LineCap startCap) GdipGetPenStartCap;
Status function(Handle pen, LineCap startCap) GdipSetPenStartCap;
Status function(Handle pen, out LineCap endCap) GdipGetPenEndCap;
Status function(Handle pen, LineCap endCap) GdipSetPenEndCap;
Status function(Handle pen, out DashCap endCap) GdipGetPenDashCap197819;
Status function(Handle pen, DashCap endCap) GdipSetPenDashCap197819;
Status function(Handle pen, out LineJoin lineJoin) GdipGetPenLineJoin;
Status function(Handle pen, LineJoin lineJoin) GdipSetPenLineJoin;
Status function(Handle pen, out float miterLimit) GdipGetPenMiterLimit;
Status function(Handle pen, float miterLimit) GdipSetPenMiterLimit;
Status function(Handle pen, out PenAlignment penMode) GdipGetPenMode;
Status function(Handle pen, PenAlignment penMode) GdipSetPenMode;
Status function(Handle pen, out Handle matrix) GdipGetPenTransform;
Status function(Handle pen, Handle matrix) GdipSetPenTransform;
Status function(Handle pen) GdipResetPenTransform;
Status function(Handle pen, Handle matrix, MatrixOrder order) GdipMultiplyPenTransform;
Status function(Handle pen, float dx, float dy, MatrixOrder order) GdipTranslatePenTransform;
Status function(Handle pen, float sx, float sy, MatrixOrder order) GdipScalePenTransform;
Status function(Handle pen, float angle, MatrixOrder order) GdipRotatePenTransform;
Status function(Handle pen, out int argb) GdipGetPenColor;
Status function(Handle pen, int argb) GdipSetPenColor;
Status function(Handle pen, out float width) GdipGetPenWidth;
Status function(Handle pen, float width) GdipSetPenWidth;
Status function(Handle pen, out PenType type) GdipGetPenFillType;
Status function(Handle pen, out Handle brush) GdipGetPenBrushFill;
Status function(Handle pen, Handle brush) GdipSetPenBrushFill;
Status function(Handle pen, out DashStyle dashstyle) GdipGetPenDashStyle;
Status function(Handle pen, DashStyle dashstyle) GdipSetPenDashStyle;
Status function(Handle pen, out float offset) GdipGetPenDashOffset;
Status function(Handle pen, float offset) GdipSetPenDashOffset;
Status function(Handle pen, out int count) GdipGetPenDashCount;
Status function(Handle pen, float* dash, int count) GdipGetPenDashArray;
Status function(Handle pen, float* dash, int count) GdipSetPenDashArray;
Status function(Handle pen, out int count) GdipGetPenCompoundCount;
Status function(Handle pen, float* dash, int count) GdipGetPenCompoundArray;
Status function(Handle pen, float* dash, int count) GdipSetPenCompoundArray;
Status function(out Handle region) GdipCreateRegion;
Status function(ref GpRectF rect, out Handle region) GdipCreateRegionRect;
Status function(ref GpRect rect, out Handle region) GdipCreateRegionRectI;
Status function(Handle path, out Handle region) GdipCreateRegionPath;
Status function(Handle hRgn, out Handle region) GdipCreateRegionHrgn;
Status function(Handle region) GdipDeleteRegion;
Status function(Handle region) GdipSetInfinite;
Status function(Handle region) GdipSetEmpty;
Status function(Handle region, ref GpRectF rect, CombineMode combineMode) GdipCombineRegionRect;
Status function(Handle region, ref GpRect rect, CombineMode combineMode) GdipCombineRegionRectI;
Status function(Handle region, Handle path, CombineMode combineMode) GdipCombineRegionPath;
Status function(Handle region, Handle region, CombineMode combineMode) GdipCombineRegionRegion;
Status function(Handle region, float dx, float dy) GdipTranslateRegion;
Status function(Handle region, int dx, int dy) GdipTranslateRegionI;
Status function(Handle region, Handle matrix) GdipTransformRegion;
Status function(Handle region, Handle graphics, out GpRectF rect) GdipGetRegionBounds;
Status function(Handle region, Handle graphics, out Handle hRgn) GdipGetRegionHRgn;
Status function(Handle region, Handle graphics, out int result) GdipIsEmptyRegion;
Status function(Handle region, Handle graphics, out int result) GdipIsInfiniteRegion;
Status function(Handle region1, Handle region2, Handle graphics, out int result) GdipIsEqualRegion;
Status function(Handle region, float x, float y, Handle graphics, out int result) GdipIsVisibleRegionPoint;
Status function(Handle region, float x, float y, float width, float height, Handle graphics, out int result) GdipIsVisibleRegionRect;
Status function(Handle region, int x, int y, Handle graphics, out int result) GdipIsVisibleRegionPointI;
Status function(Handle region, int x, int y, int width, int height, Handle graphics, out int result) GdipIsVisibleRegionRectI;
Status function(Handle region, out int count, Handle matrix) GdipGetRegionScansCount;
Status function(Handle region, GpRectF* rects, out int count, Handle matrix) GdipGetRegionScans;
Status function(Handle image) GdipDisposeImage;
Status function(Handle image) GdipImageForceValidation;
Status function(LPCWSTR filename, out Handle image) GdipLoadImageFromFileICM;
Status function(LPCWSTR filename, out Handle image) GdipLoadImageFromFile;
Status function(out int numEncoders, out int size) GdipGetImageEncodersSize;
Status function(Handle image, out Handle cloneImage) GdipCloneImage;
Status function(Handle image, out int type) GdipGetImageType;
Status function(Handle image, out uint flags) GdipGetImageFlags;
Status function(Handle image, out uint width) GdipGetImageWidth;
Status function(Handle image, out uint height) GdipGetImageHeight;
Status function(Handle image, out float resolution) GdipGetImageHorizontalResolution;
Status function(Handle image, out float resolution) GdipGetImageVerticalResolution;
Status function(Handle image, out int numOfProperty) GdipGetPropertyCount;
Status function(Handle image, int numOfProperty, int* list) GdipGetPropertyIdList;
Status function(Handle image, out PixelFormat format) GdipGetImagePixelFormat;
Status function(Handle image, out float width, out float height) GdipGetImageDimension;
Status function(Handle image, int thumbWidth, int thumbHeight, out Handle thumbImage, GpGetThumbnailImageAbort callback, void* callbackData) GdipGetImageThumbnail;
Status function(Handle image, out int count) GdipImageGetFrameDimensionsCount;
Status function(Handle image, RotateFlipType rotateFlipType) GdipImageRotateFlip;
Status function(Handle image, int propId, out uint propSize) GdipGetPropertyItemSize;
Status function(Handle image, int propId, uint propSize, GpPropertyItem* buffer) GdipGetPropertyItem;
Status function(Handle image, ref GpPropertyItem buffer) GdipSetPropertyItem;
Status function(Handle image, int propId) GdipRemovePropertyItem;
Status function(Handle image, out uint totalBufferSize, ref int numProperties) GdipGetPropertySize;
Status function(Handle image, uint totalBufferSize, int numProperties, GpPropertyItem* allItems) GdipGetAllPropertyItems;
Status function(Handle image, out GpRectF srcRect, out GraphicsUnit srcUnit) GdipGetImageBounds;
Status function(Handle image, out int size) GdipGetImagePaletteSize;
Status function(Handle image, GpColorPalette* palette, int size) GdipGetImagePalette;
Status function(Handle image, GpColorPalette* palette) GdipSetImagePalette;
Status function(int width, int height, int stride, PixelFormat format, ubyte* scan0, out Handle bitmap) GdipCreateBitmapFromScan0;
Status function(Handle hbitmap, Handle hpalette, out Handle bitmap) GdipCreateBitmapFromHBITMAP;
Status function(Handle hicon, out Handle bitmap) GdipCreateBitmapFromHICON;
Status function(LPCWSTR fileName, out Handle bitmap) GdipCreateBitmapFromFileICM;
Status function(LPCWSTR fileName, out Handle bitmap) GdipCreateBitmapFromFile;
Status function(int width, int height, Handle graphics, out Handle bitmap) GdipCreateBitmapFromGraphics;
Status function(float x, float y, float width, float height, PixelFormat format, Handle srcbitmap, out Handle dstbitmap) GdipCloneBitmapArea;
Status function(int x, int y, int width, int height, PixelFormat format, Handle srcbitmap, out Handle dstbitmap) GdipCloneBitmapAreaI;
Status function(Handle bitmap, int x, int y, out int color) GdipBitmapGetPixel;
Status function(Handle bitmap, int x, int y, int color) GdipBitmapSetPixel;
Status function(Handle bitmap, GpRect* rect, ImageLockMode flags, PixelFormat format, GpBitmapData* lockedBitmapData) GdipBitmapLockBits;
Status function(Handle bitmap, GpBitmapData* lockedBitmapData) GdipBitmapUnlockBits;
Status function(Handle bitmap, float xdpi, float ydpi) GdipBitmapSetResolution;
Status function(Handle bitmap, out Handle hbmReturn) GdipCreateHICONFromBitmap;
Status function(Handle bitmap, out Handle hbmReturn, int background) GdipCreateHBITMAPFromBitmap;
Status function(out Handle imageattr) GdipCreateImageAttributes;
Status function(Handle imageattr) GdipDisposeImageAttributes;
Status function(Handle imageattr, ColorAdjustType type, int enableFlag, GpColorMatrix* colorMatrix, GpColorMatrix* grayMatrix, ColorMatrixFlag flags) GdipSetImageAttributesColorMatrix;
Status function(Handle imageattr, ColorAdjustType type, int enableFlag, float threshold) GdipSetImageAttributesThreshold;
Status function(Handle imageattr, ColorAdjustType type, int enableFlag, float gamma) GdipSetImageAttributesGamma;
Status function(Handle imageattr, ColorAdjustType type, int enableFlag) GdipSetImageAttributesNoOp;
Status function(Handle imageattr, ColorAdjustType type, int enableFlag, int colorLow, int colorHigh) GdipSetImageAttributesColorKeys;
Status function(Handle imageattr, ColorAdjustType type, int enableFlag, ColorChannelFlag flags) GdipSetImageAttributesOutputChannel;
Status function(Handle imageattr, ColorAdjustType type, int enableFlag, LPCWSTR colorProfileFilename) GdipSetImageAttributesOutputChannelColorProfile;
Status function(Handle imageattr, WrapMode wrap, int argb, int clamp) GdipSetImageAttributesWrapMode;
Status function(out Handle fontCollection) GdipNewInstalledFontCollection;
Status function(out Handle fontCollection) GdipNewPrivateFontCollection;
Status function(Handle fontCollection) GdipDeletePrivateFontCollection;
Status function(Handle fontCollection, LPCWSTR filename) GdipPrivateAddFontFile;
Status function(Handle fontCollection, void* memory, int length) GdipPrivateAddMemoryFont;
Status function(Handle fontCollection, out int numFound) GdipGetFontCollectionFamilyCount;
Status function(Handle fontCollection, int numSought, Handle* gpfamilies, out int numFound) GdipGetFontCollectionFamilyList;
Status function(LPCWSTR name, Handle fontCollection, out Handle FontFamily) GdipCreateFontFamilyFromName;
Status function(Handle FontFamily) GdipDeleteFontFamily;
Status function(Handle FontFamily, out Handle clonedFontFamily) GdipCloneFontFamily;
Status function(Handle family, LPCWSTR name, int language) GdipGetFamilyName;
Status function(out Handle nativeFamily) GdipGetGenericFontFamilyMonospace;
Status function(out Handle nativeFamily) GdipGetGenericFontFamilySerif;
Status function(out Handle nativeFamily) GdipGetGenericFontFamilySansSerif;
Status function(Handle family, FontStyle style, out short EmHeight) GdipGetEmHeight;
Status function(Handle family, FontStyle style, out short CellAscent) GdipGetCellAscent;
Status function(Handle family, FontStyle style, out short CellDescent) GdipGetCellDescent;
Status function(Handle family, FontStyle style, out short LineSpacing) GdipGetLineSpacing;
Status function(Handle family, FontStyle style, out int IsStyleAvailable) GdipIsStyleAvailable;
Status function(Handle fontFamily, float emSize, int style, int unit, out Handle font) GdipCreateFont;
Status function(Handle hdc, out Handle font) GdipCreateFontFromDC;
Status function(Handle font) GdipDeleteFont;
Status function(Handle font, out Handle cloneFont) GdipCloneFont;
Status function(Handle font, out float size) GdipGetFontSize;
Status function(Handle font, Handle graphics, out float height) GdipGetFontHeight;
Status function(Handle font, float dpi, out float height) GdipGetFontHeightGivenDPI;
Status function(Handle font, out FontStyle style) GdipGetFontStyle;
Status function(Handle font, out GraphicsUnit unit) GdipGetFontUnit;
Status function(Handle font, out Handle family) GdipGetFamily;
Status function( Handle hdc, ref LOGFONTW logfont, out Handle font) GdipCreateFontFromLogfontW;
Status function( Handle hdc, ref LOGFONTA logfont, out Handle font ) GdipCreateFontFromLogfontA;
Status function(Handle font, Handle graphics, out LOGFONTW logfontW) GdipGetLogFontW;
Status function(StringFormatFlags formatAttributes, int language, out Handle format) GdipCreateStringFormat;
Status function(Handle format) GdipDeleteStringFormat;
Status function(Handle format, out StringFormatFlags flags) GdipGetStringFormatFlags;
Status function(Handle format, StringFormatFlags flags) GdipSetStringFormatFlags;
Status function(Handle format, out StringAlignment alignment) GdipGetStringFormatAlign;
Status function(Handle format, StringAlignment alignment) GdipSetStringFormatAlign;
Status function(Handle format, out StringAlignment alignment) GdipGetStringFormatLineAlign;
Status function(Handle format, StringAlignment alignment) GdipSetStringFormatLineAlign;
Status function(Handle format, out StringTrimming trimming) GdipGetStringFormatTrimming;
Status function(Handle format, StringTrimming trimming) GdipSetStringFormatTrimming;
Status function(FillMode brushMode, out Handle path) GdipCreatePath;
Status function(GpPointF*, ubyte*, int, FillMode, out Handle) GdipCreatePath2;
Status function(GpPoint*, ubyte*, int, FillMode, out Handle) GdipCreatePath2I;
Status function(Handle path) GdipDeletePath;
Status function(Handle path, out Handle clonepath) GdipClonePath;
Status function(Handle path) GdipResetPath;
Status function(Handle path, out FillMode fillmode) GdipGetPathFillMode;
Status function(Handle path, FillMode fillmode) GdipSetPathFillMode;
Status function(Handle path) GdipStartPathFigure;
Status function(Handle path) GdipClosePathFigure;
Status function(Handle path) GdipClosePathFigures;
Status function(Handle path) GdipSetPathMarker;
Status function(Handle path) GdipClearPathMarkers;
Status function(Handle path) GdipReversePath;
Status function(Handle path, out GpPointF lastPoint) GdipGetPathLastPoint;
Status function(Handle path, float x1, float y1, float x2, float y2) GdipAddPathLine;
Status function(Handle path, int x1, int y1, int x2, int y2) GdipAddPathLineI;
Status function(Handle path, GpPointF* points, int count) GdipAddPathLine2;
Status function(Handle path, GpPoint* points, int count) GdipAddPathLine2I;
Status function(Handle path, float x, float y, float width, float height, float startAngle, float sweepAngle) GdipAddPathArc;
Status function(Handle path, int x, int y, int width, int height, float startAngle, float sweepAngle) GdipAddPathArcI;
Status function(Handle path, float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) GdipAddPathBezier;
Status function(Handle path, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4) GdipAddPathBezierI;
Status function(Handle path, GpPointF* points, int count) GdipAddPathBeziers;
Status function(Handle path, GpPoint* points, int count) GdipAddPathBeziersI;
Status function(Handle path, GpPointF* points, int count) GdipAddPathCurve;
Status function(Handle path, GpPoint* points, int count) GdipAddPathCurveI;
Status function(Handle path, GpPointF* points, int count, float tension) GdipAddPathCurve2;
Status function(Handle path, GpPoint* points, int count, float tension) GdipAddPathCurve2I;
Status function(Handle path, GpPointF* points, int count, int offset, int numberOfSegments, float tension) GdipAddPathCurve3;
Status function(Handle path, GpPoint* points, int count, int offset, int numberOfSegments, float tension) GdipAddPathCurve3I;
Status function(Handle path, GpPointF* points, int count) GdipAddPathClosedCurve;
Status function(Handle path, GpPoint* points, int count) GdipAddPathClosedCurveI;
Status function(Handle path, GpPointF* points, int count, float tension) GdipAddPathClosedCurve2;
Status function(Handle path, GpPoint* points, int count, float tension) GdipAddPathClosedCurve2I;
Status function(Handle path, float x, float y, float width, float height) GdipAddPathRectangle;
Status function(Handle path, int x, int y, int width, int height) GdipAddPathRectangleI;
Status function(Handle path, GpRectF* rects, int count) GdipAddPathRectangles;
Status function(Handle path, GpRect* rects, int count) GdipAddPathRectanglesI;
Status function(Handle path, float x, float y, float width, float height) GdipAddPathEllipse;
Status function(Handle path, int x, int y, int width, int height) GdipAddPathEllipseI;
Status function(Handle path, float x, float y, float width, float height, float startAngle, float sweepAngle) GdipAddPathPie;
Status function(Handle path, int x, int y, int width, int height, float startAngle, float sweepAngle) GdipAddPathPieI;
Status function(Handle path, GpPointF* points, int count) GdipAddPathPolygon;
Status function(Handle path, GpPoint* points, int count) GdipAddPathPolygonI;
Status function(Handle path, Handle addingPath, int connect) GdipAddPathPath;
Status function(Handle path, LPCWSTR string, int length, Handle family, FontStyle style, float emSize, ref GpRectF layoutRect, Handle format) GdipAddPathString;
Status function(Handle path, LPCWSTR string, int length, Handle family, FontStyle style, float emSize, ref GpRect layoutRect, Handle format) GdipAddPathStringI;
Status function(Handle path, Handle matrix) GdipTransformPath;
Status function(Handle path, out GpRectF bounds, Handle matrix, Handle pen) GdipGetPathWorldBounds;
Status function(Handle path, Handle matrix, float flatness) GdipFlattenPath;
Status function(Handle path, Handle pen, Handle matrix, float flatness) GdipWidenPath;
Status function(Handle path, Handle matrix, float flatness) GdipWindingModeOutline;
Status function(Handle path, Handle matrix, GpPointF* points, int count, float srcx, float srcy, float srcwidth, float srcwidth, WarpMode warpMode, float flatness) GdipWarpPath;
Status function(Handle path, out int count) GdipGetPointCount;
Status function(Handle path, byte* types, int count) GdipGetPathTypes;
Status function(Handle path, GpPointF* points, int count) GdipGetPathPoints;
Status function(Handle path, float x, float y, Handle graphics, out int result) GdipIsVisiblePathPoint;
Status function(Handle path, int x, int y, Handle graphics, out int result) GdipIsVisiblePathPointI;
Status function(Handle path, float x, float y, Handle pen, Handle graphics, out int result) GdipIsOutlineVisiblePathPoint;
Status function(Handle path, int x, int y, Handle pen, Handle graphics, out int result) GdipIsOutlineVisiblePathPointI;
Status function(Handle graphics, Handle pen, Handle path) GdipDrawPath;
Status function(out Handle iterator, Handle path) GdipCreatePathIter;
Status function(Handle iterator) GdipDeletePathIter;
Status function(Handle iterator, out int resultCount, out int startIndex, out int endIndex, out int isClosed) GdipPathIterNextSubpath;
Status function(Handle iterator, out int resultCount, Handle path, out int isClosed) GdipPathIterNextSubpathPath;
Status function(Handle iterator, out int resultCount, out ubyte pathType, out int startIndex, out int endIndex) GdipPathIterNextPathType;
Status function(Handle iterator, out int resultCount, out int startIndex, out int endIndex) GdipPathIterNextMarker;
Status function(Handle iterator, out int resultCount, Handle path) GdipPathIterNextMarkerPath;
Status function(Handle iterator, out int count) GdipPathIterGetCount;
Status function(Handle iterator, out int count) GdipPathIterGetSubpathCount;
Status function(Handle iterator, out int hasCurve) GdipPathIterHasCurve;
Status function(Handle iterator) GdipPathIterRewind;
Status function(Handle iterator, out int resultCount, GpPointF* points, ubyte* types, int count) GdipPathIterEnumerate;
Status function(Handle iterator, out int resultCount, GpPointF* points, ubyte* types, int startIndex, int endIndex) GdipPathIterCopyData;
Status function(GpPointF* points, int count, WrapMode wrapMode, out Handle polyGradient) GdipCreatePathGradient;
Status function(GpPoint* points, int count, WrapMode wrapMode, out Handle polyGradient) GdipCreatePathGradientI;
Status function(Handle path, out Handle polyGradient) GdipCreatePathGradientFromPath;
Status function(Handle brush, out int colors) GdipGetPathGradientCenterColor;
Status function(Handle brush, int colors) GdipSetPathGradientCenterColor;
Status function(Handle brush, out int count) GdipGetPathGradientSurroundColorCount;
Status function(Handle brush, int* color, ref int count) GdipGetPathGradientSurroundColorsWithCount;
Status function(Handle brush, int* color, ref int count) GdipSetPathGradientSurroundColorsWithCount;
Status function(Handle brush, ref GpPointF point) GdipGetPathGradientCenterPoint;
Status function(Handle brush, ref GpPointF point) GdipSetPathGradientCenterPoint;
Status function(Handle brush, ref GpRectF rect) GdipGetPathGradientRect;
Status function(Handle brush, out int count) GdipGetPathGradientBlendCount;
Status function(Handle brush, float* blend, float* positions, int count) GdipGetPathGradientBlend;
Status function(Handle brush, float* blend, float* positions, int count) GdipSetPathGradientBlend;
Status function(Handle brush, out int count) GdipGetPathGradientPresetBlendCount;
Status function(Handle brush, int* blend, float* positions, int count) GdipGetPathGradientPresetBlend;
Status function(Handle brush, int* blend, float* positions, int count) GdipSetPathGradientPresetBlend;
Status function(Handle brush, float focus, float scale) GdipSetPathGradientSigmaBlend;
Status function(Handle brush, float focus, float scale) GdipSetPathGradientLinearBlend;
Status function(Handle brush, out Handle matrix) GdipGetPathGradientTransform;
Status function(Handle brush, Handle matrix) GdipSetPathGradientTransform;
Status function(Handle brush) GdipResetPathGradientTransform;
Status function(Handle brush, Handle matrix, MatrixOrder order) GdipMultiplyPathGradientTransform;
Status function(Handle brush, float angle, MatrixOrder order) GdipRotatePathGradientTransform;
Status function(Handle brush, float dx, float dy, MatrixOrder order) GdipTranslatePathGradientTransform;
Status function(Handle brush, float sx, float sy, MatrixOrder order) GdipScalePathGradientTransform;
Status function(Handle brush, out float xScale, out float yScale) GdipGetPathGradientFocusScales;
Status function(Handle brush, float xScale, float yScale) GdipSetPathGradientFocusScales;
Status function(Handle brush, out WrapMode wrapMode) GdipGetPathGradientWrapMode;
Status function(Handle brush, WrapMode wrapMode) GdipSetPathGradientWrapMode;
Status function( Handle brush ) GdipResetTextureTransform;
Status function( Handle brush, float sx, float sy, MatrixOrder order ) GdipScaleTextureTransform;
Status function( Handle brush, float dx, float dy, MatrixOrder order) GdipTranslateTextureTransform;
Status function(out Handle format) GdipStringFormatGetGenericDefault;
Status function(out Handle format) GdipStringFormatGetGenericTypographic;
Status function(Handle format, int hotkeyPrefix) GdipSetStringFormatHotkeyPrefix;
Status function( Handle format, float firstTabOffset, int count, float* tabStops) GdipSetStringFormatTabStops;

Symbol[] symbols = [
    { "GdiplusStartup", cast(void**)& GdiplusStartup },
    { "GdiplusShutdown", cast(void**)& GdiplusShutdown },
    { "GdipCreateFromHDC", cast(void**)& GdipCreateFromHDC },
    { "GdipCreateFromHDC2", cast(void**)& GdipCreateFromHDC2 },
    { "GdipCreateFromHWND", cast(void**)& GdipCreateFromHWND },
    { "GdipGetImageGraphicsContext", cast(void**)& GdipGetImageGraphicsContext },
    { "GdipDeleteGraphics", cast(void**)& GdipDeleteGraphics },
    { "GdipGetDC", cast(void**)& GdipGetDC },
    { "GdipReleaseDC", cast(void**)& GdipReleaseDC },
    { "GdipSetClipGraphics", cast(void**)& GdipSetClipGraphics },
    { "GdipSetClipRectI", cast(void**)& GdipSetClipRectI },
    { "GdipSetClipRect", cast(void**)& GdipSetClipRect },
    { "GdipSetClipPath", cast(void**)& GdipSetClipPath },
    { "GdipSetClipRegion", cast(void**)& GdipSetClipRegion },
    { "GdipSetClipHrgn", cast(void**)& GdipSetClipHrgn },
    { "GdipGetClip", cast(void**)& GdipGetClip },
    { "GdipResetClip", cast(void**)& GdipResetClip },
    { "GdipSaveGraphics", cast(void**)& GdipSaveGraphics },
    { "GdipRestoreGraphics", cast(void**)& GdipRestoreGraphics },
    { "GdipFlush", cast(void**)& GdipFlush },
    { "GdipScaleWorldTransform", cast(void**)& GdipScaleWorldTransform },
    { "GdipRotateWorldTransform", cast(void**)& GdipRotateWorldTransform },
    { "GdipTranslateWorldTransform", cast(void**)& GdipTranslateWorldTransform },
    { "GdipMultiplyWorldTransform", cast(void**)& GdipMultiplyWorldTransform },
    { "GdipResetWorldTransform", cast(void**)& GdipResetWorldTransform },
    { "GdipBeginContainer", cast(void**)& GdipBeginContainer },
    { "GdipBeginContainerI", cast(void**)& GdipBeginContainerI },
    { "GdipBeginContainer2", cast(void**)& GdipBeginContainer2 },
    { "GdipEndContainer", cast(void**)& GdipEndContainer },
    { "GdipGetDpiX", cast(void**)& GdipGetDpiX },
    { "GdipGetDpiY", cast(void**)& GdipGetDpiY },
    { "GdipGetPageUnit", cast(void**)& GdipGetPageUnit },
    { "GdipSetPageUnit", cast(void**)& GdipSetPageUnit },
    { "GdipGetPageScale", cast(void**)& GdipGetPageScale },
    { "GdipSetPageScale", cast(void**)& GdipSetPageScale },
    { "GdipGetWorldTransform", cast(void**)& GdipGetWorldTransform },
    { "GdipSetWorldTransform", cast(void**)& GdipSetWorldTransform },
    { "GdipGetCompositingMode", cast(void**)& GdipGetCompositingMode },
    { "GdipSetCompositingMode", cast(void**)& GdipSetCompositingMode },
    { "GdipGetCompositingQuality", cast(void**)& GdipGetCompositingQuality },
    { "GdipSetCompositingQuality", cast(void**)& GdipSetCompositingQuality },
    { "GdipGetInterpolationMode", cast(void**)& GdipGetInterpolationMode },
    { "GdipSetInterpolationMode", cast(void**)& GdipSetInterpolationMode },
    { "GdipGetSmoothingMode", cast(void**)& GdipGetSmoothingMode },
    { "GdipSetSmoothingMode", cast(void**)& GdipSetSmoothingMode },
    { "GdipGetPixelOffsetMode", cast(void**)& GdipGetPixelOffsetMode },
    { "GdipSetPixelOffsetMode", cast(void**)& GdipSetPixelOffsetMode },
    { "GdipGetTextContrast", cast(void**)& GdipGetTextContrast },
    { "GdipSetTextContrast", cast(void**)& GdipSetTextContrast },
    { "GdipGraphicsClear", cast(void**)& GdipGraphicsClear },
    { "GdipDrawLine", cast(void**)& GdipDrawLine },
    { "GdipDrawLines", cast(void**)& GdipDrawLines },
    { "GdipDrawLineI", cast(void**)& GdipDrawLineI },
    { "GdipDrawLinesI", cast(void**)& GdipDrawLinesI },
    { "GdipDrawArc", cast(void**)& GdipDrawArc },
    { "GdipDrawArcI", cast(void**)& GdipDrawArcI },
    { "GdipDrawBezier", cast(void**)& GdipDrawBezier },
    { "GdipDrawBeziers", cast(void**)& GdipDrawBeziers },
    { "GdipDrawBezierI", cast(void**)& GdipDrawBezierI },
    { "GdipDrawBeziersI", cast(void**)& GdipDrawBeziersI },
    { "GdipDrawRectangle", cast(void**)& GdipDrawRectangle },
    { "GdipDrawRectangles", cast(void**)& GdipDrawRectangles },
    { "GdipDrawRectangleI", cast(void**)& GdipDrawRectangleI },
    { "GdipDrawRectanglesI", cast(void**)& GdipDrawRectanglesI },
    { "GdipDrawEllipse", cast(void**)& GdipDrawEllipse },
    { "GdipDrawEllipseI", cast(void**)& GdipDrawEllipseI },
    { "GdipDrawPie", cast(void**)& GdipDrawPie },
    { "GdipDrawPieI", cast(void**)& GdipDrawPieI },
    { "GdipDrawPolygon", cast(void**)& GdipDrawPolygon },
    { "GdipDrawPolygonI", cast(void**)& GdipDrawPolygonI },
    { "GdipDrawCurve", cast(void**)& GdipDrawCurve },
    { "GdipDrawCurve2", cast(void**)& GdipDrawCurve2 },
    { "GdipDrawCurve3", cast(void**)& GdipDrawCurve3 },
    { "GdipDrawCurveI", cast(void**)& GdipDrawCurveI },
    { "GdipDrawCurve2I", cast(void**)& GdipDrawCurve2I },
    { "GdipDrawCurve3I", cast(void**)& GdipDrawCurve3I },
    { "GdipDrawClosedCurve", cast(void**)& GdipDrawClosedCurve },
    { "GdipDrawClosedCurve2", cast(void**)& GdipDrawClosedCurve2 },
    { "GdipDrawClosedCurveI", cast(void**)& GdipDrawClosedCurveI },
    { "GdipDrawClosedCurve2I", cast(void**)& GdipDrawClosedCurve2I },
    { "GdipFillRectangleI", cast(void**)& GdipFillRectangleI },
    { "GdipFillRectangle", cast(void**)& GdipFillRectangle },
    { "GdipFillRectanglesI", cast(void**)& GdipFillRectanglesI },
    { "GdipFillRectangles", cast(void**)& GdipFillRectangles },
    { "GdipFillPolygon", cast(void**)& GdipFillPolygon },
    { "GdipFillPolygonI", cast(void**)& GdipFillPolygonI },
    { "GdipFillEllipse", cast(void**)& GdipFillEllipse },
    { "GdipFillEllipseI", cast(void**)& GdipFillEllipseI },
    { "GdipFillPie", cast(void**)& GdipFillPie },
    { "GdipFillPieI", cast(void**)& GdipFillPieI },
    { "GdipFillPath", cast(void**)& GdipFillPath },
    { "GdipFillClosedCurve", cast(void**)& GdipFillClosedCurve },
    { "GdipFillClosedCurveI", cast(void**)& GdipFillClosedCurveI },
    { "GdipFillClosedCurve2", cast(void**)& GdipFillClosedCurve2 },
    { "GdipFillClosedCurve2I", cast(void**)& GdipFillClosedCurve2I },
    { "GdipFillRegion", cast(void**)& GdipFillRegion },
    { "GdipDrawString", cast(void**)& GdipDrawString },
    { "GdipMeasureString", cast(void**)& GdipMeasureString },
    { "GdipGetStringFormatMeasurableCharacterRangeCount", cast(void**)& GdipGetStringFormatMeasurableCharacterRangeCount },
    { "GdipCloneStringFormat", cast(void**)& GdipCloneStringFormat },
    { "GdipMeasureCharacterRanges", cast(void**)& GdipMeasureCharacterRanges },
    { "GdipDrawImage", cast(void**)& GdipDrawImage },
    { "GdipDrawImageI", cast(void**)& GdipDrawImageI },
    { "GdipDrawImageRect", cast(void**)& GdipDrawImageRect },
    { "GdipDrawImageRectI", cast(void**)& GdipDrawImageRectI },
    { "GdipDrawImagePointRect", cast(void**)& GdipDrawImagePointRect },
    { "GdipDrawImagePointRectI", cast(void**)& GdipDrawImagePointRectI },
    { "GdipDrawImageRectRect", cast(void**)& GdipDrawImageRectRect },
    { "GdipDrawImageRectRectI", cast(void**)& GdipDrawImageRectRectI },
    { "GdipDrawImagePoints", cast(void**)& GdipDrawImagePoints },
    { "GdipDrawImagePointsI", cast(void**)& GdipDrawImagePointsI },
    { "GdipDrawImagePointsRect", cast(void**)& GdipDrawImagePointsRect },
    { "GdipDrawImagePointsRectI", cast(void**)& GdipDrawImagePointsRectI },
    { "GdipIsVisiblePoint", cast(void**)& GdipIsVisiblePoint },
    { "GdipIsVisiblePointI", cast(void**)& GdipIsVisiblePointI },
    { "GdipIsVisibleRect", cast(void**)& GdipIsVisibleRect },
    { "GdipIsVisibleRectI", cast(void**)& GdipIsVisibleRectI },
    { "GdipGetTextRenderingHint", cast(void**)& GdipGetTextRenderingHint },
    { "GdipSetTextRenderingHint", cast(void**)& GdipSetTextRenderingHint },
    { "GdipGetClipBounds", cast(void**)& GdipGetClipBounds },
    { "GdipGetClipBoundsI", cast(void**)& GdipGetClipBoundsI },
    { "GdipGetVisibleClipBounds", cast(void**)& GdipGetVisibleClipBounds },
    { "GdipGetVisibleClipBoundsI", cast(void**)& GdipGetVisibleClipBoundsI },
    { "GdipIsClipEmpty", cast(void**)& GdipIsClipEmpty },
    { "GdipIsVisibleClipEmpty", cast(void**)& GdipIsVisibleClipEmpty },
    { "GdipGetRenderingOrigin", cast(void**)& GdipGetRenderingOrigin },
    { "GdipSetRenderingOrigin", cast(void**)& GdipSetRenderingOrigin },
    { "GdipGetNearestColor", cast(void**)& GdipGetNearestColor },
    { "GdipComment", cast(void**)& GdipComment },
    { "GdipTransformPoints", cast(void**)& GdipTransformPoints },
    { "GdipTransformPointsI", cast(void**)& GdipTransformPointsI },
    { "GdipCreateMatrix", cast(void**)& GdipCreateMatrix },
    { "GdipCreateMatrix2", cast(void**)& GdipCreateMatrix2 },
    { "GdipCreateMatrix3", cast(void**)& GdipCreateMatrix3 },
    { "GdipCreateMatrix3I", cast(void**)& GdipCreateMatrix3I },
    { "GdipDeleteMatrix", cast(void**)& GdipDeleteMatrix },
    { "GdipCloneMatrix", cast(void**)& GdipCloneMatrix },
    { "GdipGetMatrixElements", cast(void**)& GdipGetMatrixElements },
    { "GdipSetMatrixElements", cast(void**)& GdipSetMatrixElements },
    { "GdipInvertMatrix", cast(void**)& GdipInvertMatrix },
    { "GdipMultiplyMatrix", cast(void**)& GdipMultiplyMatrix },
    { "GdipScaleMatrix", cast(void**)& GdipScaleMatrix },
    { "GdipShearMatrix", cast(void**)& GdipShearMatrix },
    { "GdipRotateMatrix", cast(void**)& GdipRotateMatrix },
    { "GdipTranslateMatrix", cast(void**)& GdipTranslateMatrix },
    { "GdipIsMatrixIdentity", cast(void**)& GdipIsMatrixIdentity },
    { "GdipIsMatrixInvertible", cast(void**)& GdipIsMatrixInvertible },
    { "GdipTransformMatrixPoints", cast(void**)& GdipTransformMatrixPoints },
    { "GdipGetBrushType", cast(void**)& GdipGetBrushType },
    { "GdipCloneBrush", cast(void**)& GdipCloneBrush },
    { "GdipDeleteBrush", cast(void**)& GdipDeleteBrush },
    { "GdipCreateSolidFill", cast(void**)& GdipCreateSolidFill },
    { "GdipGetSolidFillColor", cast(void**)& GdipGetSolidFillColor },
    { "GdipSetSolidFillColor", cast(void**)& GdipSetSolidFillColor },
    { "GdipCreateTexture", cast(void**)& GdipCreateTexture },
    { "GdipCreateTexture2", cast(void**)& GdipCreateTexture2 },
    { "GdipCreateTexture2I", cast(void**)& GdipCreateTexture2I },
    { "GdipGetTextureImage", cast(void**)& GdipGetTextureImage },
    { "GdipGetTextureTransform", cast(void**)& GdipGetTextureTransform },
    { "GdipSetTextureTransform", cast(void**)& GdipSetTextureTransform },
    { "GdipGetTextureWrapMode", cast(void**)& GdipGetTextureWrapMode },
    { "GdipSetTextureWrapMode", cast(void**)& GdipSetTextureWrapMode },
    { "GdipCreateHatchBrush", cast(void**)& GdipCreateHatchBrush },
    { "GdipGetHatchStyle", cast(void**)& GdipGetHatchStyle },
    { "GdipGetHatchForegroundColor", cast(void**)& GdipGetHatchForegroundColor },
    { "GdipGetHatchBackgroundColor", cast(void**)& GdipGetHatchBackgroundColor },
    { "GdipCreateLineBrushI", cast(void**)& GdipCreateLineBrushI },
    { "GdipCreateLineBrush", cast(void**)& GdipCreateLineBrush },
    { "GdipCreateLineBrushFromRectI", cast(void**)& GdipCreateLineBrushFromRectI },
    { "GdipCreateLineBrushFromRect", cast(void**)& GdipCreateLineBrushFromRect },
    { "GdipCreateLineBrushFromRectWithAngleI", cast(void**)& GdipCreateLineBrushFromRectWithAngleI },
    { "GdipCreateLineBrushFromRectWithAngle", cast(void**)& GdipCreateLineBrushFromRectWithAngle },
    { "GdipGetLineBlendCount", cast(void**)& GdipGetLineBlendCount },
    { "GdipGetLineBlend", cast(void**)& GdipGetLineBlend },
    { "GdipSetLineBlend", cast(void**)& GdipSetLineBlend },
    { "GdipGetLinePresetBlendCount", cast(void**)& GdipGetLinePresetBlendCount },
    { "GdipGetLinePresetBlend", cast(void**)& GdipGetLinePresetBlend },
    { "GdipSetLinePresetBlend", cast(void**)& GdipSetLinePresetBlend },
    { "GdipGetLineWrapMode", cast(void**)& GdipGetLineWrapMode },
    { "GdipSetLineWrapMode", cast(void**)& GdipSetLineWrapMode },
    { "GdipGetLineRect", cast(void**)& GdipGetLineRect },
    { "GdipGetLineColors", cast(void**)& GdipGetLineColors },
    { "GdipSetLineColors", cast(void**)& GdipSetLineColors },
    { "GdipGetLineGammaCorrection", cast(void**)& GdipGetLineGammaCorrection },
    { "GdipSetLineGammaCorrection", cast(void**)& GdipSetLineGammaCorrection },
    { "GdipSetLineSigmaBlend", cast(void**)& GdipSetLineSigmaBlend },
    { "GdipSetLineLinearBlend", cast(void**)& GdipSetLineLinearBlend },
    { "GdipGetLineTransform", cast(void**)& GdipGetLineTransform },
    { "GdipSetLineTransform", cast(void**)& GdipSetLineTransform },
    { "GdipResetLineTransform", cast(void**)& GdipResetLineTransform },
    { "GdipMultiplyLineTransform", cast(void**)& GdipMultiplyLineTransform },
    { "GdipTranslateLineTransform", cast(void**)& GdipTranslateLineTransform },
    { "GdipScaleLineTransform", cast(void**)& GdipScaleLineTransform },
    { "GdipRotateLineTransform", cast(void**)& GdipRotateLineTransform },
    { "GdipCreatePen1", cast(void**)& GdipCreatePen1 },
    { "GdipCreatePen2", cast(void**)& GdipCreatePen2 },
    { "GdipDeletePen", cast(void**)& GdipDeletePen },
    { "GdipClonePen", cast(void**)& GdipClonePen },
    { "GdipSetPenLineCap197819", cast(void**)& GdipSetPenLineCap197819 },
    { "GdipGetPenStartCap", cast(void**)& GdipGetPenStartCap },
    { "GdipSetPenStartCap", cast(void**)& GdipSetPenStartCap },
    { "GdipGetPenEndCap", cast(void**)& GdipGetPenEndCap },
    { "GdipSetPenEndCap", cast(void**)& GdipSetPenEndCap },
    { "GdipGetPenDashCap197819", cast(void**)& GdipGetPenDashCap197819 },
    { "GdipSetPenDashCap197819", cast(void**)& GdipSetPenDashCap197819 },
    { "GdipGetPenLineJoin", cast(void**)& GdipGetPenLineJoin },
    { "GdipSetPenLineJoin", cast(void**)& GdipSetPenLineJoin },
    { "GdipGetPenMiterLimit", cast(void**)& GdipGetPenMiterLimit },
    { "GdipSetPenMiterLimit", cast(void**)& GdipSetPenMiterLimit },
    { "GdipGetPenMode", cast(void**)& GdipGetPenMode },
    { "GdipSetPenMode", cast(void**)& GdipSetPenMode },
    { "GdipGetPenTransform", cast(void**)& GdipGetPenTransform },
    { "GdipSetPenTransform", cast(void**)& GdipSetPenTransform },
    { "GdipResetPenTransform", cast(void**)& GdipResetPenTransform },
    { "GdipMultiplyPenTransform", cast(void**)& GdipMultiplyPenTransform },
    { "GdipTranslatePenTransform", cast(void**)& GdipTranslatePenTransform },
    { "GdipScalePenTransform", cast(void**)& GdipScalePenTransform },
    { "GdipRotatePenTransform", cast(void**)& GdipRotatePenTransform },
    { "GdipGetPenColor", cast(void**)& GdipGetPenColor },
    { "GdipSetPenColor", cast(void**)& GdipSetPenColor },
    { "GdipGetPenWidth", cast(void**)& GdipGetPenWidth },
    { "GdipSetPenWidth", cast(void**)& GdipSetPenWidth },
    { "GdipGetPenFillType", cast(void**)& GdipGetPenFillType },
    { "GdipGetPenBrushFill", cast(void**)& GdipGetPenBrushFill },
    { "GdipSetPenBrushFill", cast(void**)& GdipSetPenBrushFill },
    { "GdipGetPenDashStyle", cast(void**)& GdipGetPenDashStyle },
    { "GdipSetPenDashStyle", cast(void**)& GdipSetPenDashStyle },
    { "GdipGetPenDashOffset", cast(void**)& GdipGetPenDashOffset },
    { "GdipSetPenDashOffset", cast(void**)& GdipSetPenDashOffset },
    { "GdipGetPenDashCount", cast(void**)& GdipGetPenDashCount },
    { "GdipGetPenDashArray", cast(void**)& GdipGetPenDashArray },
    { "GdipSetPenDashArray", cast(void**)& GdipSetPenDashArray },
    { "GdipGetPenCompoundCount", cast(void**)& GdipGetPenCompoundCount },
    { "GdipGetPenCompoundArray", cast(void**)& GdipGetPenCompoundArray },
    { "GdipSetPenCompoundArray", cast(void**)& GdipSetPenCompoundArray },
    { "GdipCreateRegion", cast(void**)& GdipCreateRegion },
    { "GdipCreateRegionRect", cast(void**)& GdipCreateRegionRect },
    { "GdipCreateRegionRectI", cast(void**)& GdipCreateRegionRectI },
    { "GdipCreateRegionPath", cast(void**)& GdipCreateRegionPath },
    { "GdipCreateRegionHrgn", cast(void**)& GdipCreateRegionHrgn },
    { "GdipDeleteRegion", cast(void**)& GdipDeleteRegion },
    { "GdipSetInfinite", cast(void**)& GdipSetInfinite },
    { "GdipSetEmpty", cast(void**)& GdipSetEmpty },
    { "GdipCombineRegionRect", cast(void**)& GdipCombineRegionRect },
    { "GdipCombineRegionRectI", cast(void**)& GdipCombineRegionRectI },
    { "GdipCombineRegionPath", cast(void**)& GdipCombineRegionPath },
    { "GdipCombineRegionRegion", cast(void**)& GdipCombineRegionRegion },
    { "GdipTranslateRegion", cast(void**)& GdipTranslateRegion },
    { "GdipTranslateRegionI", cast(void**)& GdipTranslateRegionI },
    { "GdipTransformRegion", cast(void**)& GdipTransformRegion },
    { "GdipGetRegionBounds", cast(void**)& GdipGetRegionBounds },
    { "GdipGetRegionHRgn", cast(void**)& GdipGetRegionHRgn },
    { "GdipIsEmptyRegion", cast(void**)& GdipIsEmptyRegion },
    { "GdipIsInfiniteRegion", cast(void**)& GdipIsInfiniteRegion },
    { "GdipIsEqualRegion", cast(void**)& GdipIsEqualRegion },
    { "GdipIsVisibleRegionPoint", cast(void**)& GdipIsVisibleRegionPoint },
    { "GdipIsVisibleRegionRect", cast(void**)& GdipIsVisibleRegionRect },
    { "GdipIsVisibleRegionPointI", cast(void**)& GdipIsVisibleRegionPointI },
    { "GdipIsVisibleRegionRectI", cast(void**)& GdipIsVisibleRegionRectI },
    { "GdipGetRegionScansCount", cast(void**)& GdipGetRegionScansCount },
    { "GdipGetRegionScans", cast(void**)& GdipGetRegionScans },
    { "GdipDisposeImage", cast(void**)& GdipDisposeImage },
    { "GdipImageForceValidation", cast(void**)& GdipImageForceValidation },
    { "GdipLoadImageFromFileICM", cast(void**)& GdipLoadImageFromFileICM },
    { "GdipLoadImageFromFile", cast(void**)& GdipLoadImageFromFile },
    { "GdipGetImageEncodersSize", cast(void**)& GdipGetImageEncodersSize },
    { "GdipCloneImage", cast(void**)& GdipCloneImage },
    { "GdipGetImageType", cast(void**)& GdipGetImageType },
    { "GdipGetImageFlags", cast(void**)& GdipGetImageFlags },
    { "GdipGetImageWidth", cast(void**)& GdipGetImageWidth },
    { "GdipGetImageHeight", cast(void**)& GdipGetImageHeight },
    { "GdipGetImageHorizontalResolution", cast(void**)& GdipGetImageHorizontalResolution },
    { "GdipGetImageVerticalResolution", cast(void**)& GdipGetImageVerticalResolution },
    { "GdipGetPropertyCount", cast(void**)& GdipGetPropertyCount },
    { "GdipGetPropertyIdList", cast(void**)& GdipGetPropertyIdList },
    { "GdipGetImagePixelFormat", cast(void**)& GdipGetImagePixelFormat },
    { "GdipGetImageDimension", cast(void**)& GdipGetImageDimension },
    { "GdipGetImageThumbnail", cast(void**)& GdipGetImageThumbnail },
    { "GdipImageGetFrameDimensionsCount", cast(void**)& GdipImageGetFrameDimensionsCount },
    { "GdipImageRotateFlip", cast(void**)& GdipImageRotateFlip },
    { "GdipGetPropertyItemSize", cast(void**)& GdipGetPropertyItemSize },
    { "GdipGetPropertyItem", cast(void**)& GdipGetPropertyItem },
    { "GdipSetPropertyItem", cast(void**)& GdipSetPropertyItem },
    { "GdipRemovePropertyItem", cast(void**)& GdipRemovePropertyItem },
    { "GdipGetPropertySize", cast(void**)& GdipGetPropertySize },
    { "GdipGetAllPropertyItems", cast(void**)& GdipGetAllPropertyItems },
    { "GdipGetImageBounds", cast(void**)& GdipGetImageBounds },
    { "GdipGetImagePaletteSize", cast(void**)& GdipGetImagePaletteSize },
    { "GdipGetImagePalette", cast(void**)& GdipGetImagePalette },
    { "GdipSetImagePalette", cast(void**)& GdipSetImagePalette },
    { "GdipCreateBitmapFromScan0", cast(void**)& GdipCreateBitmapFromScan0 },
    { "GdipCreateBitmapFromHBITMAP", cast(void**)& GdipCreateBitmapFromHBITMAP },
    { "GdipCreateBitmapFromHICON", cast(void**)& GdipCreateBitmapFromHICON },
    { "GdipCreateBitmapFromFileICM", cast(void**)& GdipCreateBitmapFromFileICM },
    { "GdipCreateBitmapFromFile", cast(void**)& GdipCreateBitmapFromFile },
    { "GdipCreateBitmapFromGraphics", cast(void**)& GdipCreateBitmapFromGraphics },
    { "GdipCloneBitmapArea", cast(void**)& GdipCloneBitmapArea },
    { "GdipCloneBitmapAreaI", cast(void**)& GdipCloneBitmapAreaI },
    { "GdipBitmapGetPixel", cast(void**)& GdipBitmapGetPixel },
    { "GdipBitmapSetPixel", cast(void**)& GdipBitmapSetPixel },
    { "GdipBitmapLockBits", cast(void**)& GdipBitmapLockBits },
    { "GdipBitmapUnlockBits", cast(void**)& GdipBitmapUnlockBits },
    { "GdipBitmapSetResolution", cast(void**)& GdipBitmapSetResolution },
    { "GdipCreateHICONFromBitmap", cast(void**)& GdipCreateHICONFromBitmap },
    { "GdipCreateHBITMAPFromBitmap", cast(void**)& GdipCreateHBITMAPFromBitmap },
    { "GdipCreateImageAttributes", cast(void**)& GdipCreateImageAttributes },
    { "GdipDisposeImageAttributes", cast(void**)& GdipDisposeImageAttributes },
    { "GdipSetImageAttributesColorMatrix", cast(void**)& GdipSetImageAttributesColorMatrix },
    { "GdipSetImageAttributesThreshold", cast(void**)& GdipSetImageAttributesThreshold },
    { "GdipSetImageAttributesGamma", cast(void**)& GdipSetImageAttributesGamma },
    { "GdipSetImageAttributesNoOp", cast(void**)& GdipSetImageAttributesNoOp },
    { "GdipSetImageAttributesColorKeys", cast(void**)& GdipSetImageAttributesColorKeys },
    { "GdipSetImageAttributesOutputChannel", cast(void**)& GdipSetImageAttributesOutputChannel },
    { "GdipSetImageAttributesOutputChannelColorProfile", cast(void**)& GdipSetImageAttributesOutputChannelColorProfile },
    { "GdipSetImageAttributesWrapMode", cast(void**)& GdipSetImageAttributesWrapMode },
    { "GdipNewInstalledFontCollection", cast(void**)& GdipNewInstalledFontCollection },
    { "GdipNewPrivateFontCollection", cast(void**)& GdipNewPrivateFontCollection },
    { "GdipDeletePrivateFontCollection", cast(void**)& GdipDeletePrivateFontCollection },
    { "GdipPrivateAddFontFile", cast(void**)& GdipPrivateAddFontFile },
    { "GdipPrivateAddMemoryFont", cast(void**)& GdipPrivateAddMemoryFont },
    { "GdipGetFontCollectionFamilyCount", cast(void**)& GdipGetFontCollectionFamilyCount },
    { "GdipGetFontCollectionFamilyList", cast(void**)& GdipGetFontCollectionFamilyList },
    { "GdipCreateFontFamilyFromName", cast(void**)& GdipCreateFontFamilyFromName },
    { "GdipDeleteFontFamily", cast(void**)& GdipDeleteFontFamily },
    { "GdipCloneFontFamily", cast(void**)& GdipCloneFontFamily },
    { "GdipGetFamilyName", cast(void**)& GdipGetFamilyName },
    { "GdipGetGenericFontFamilyMonospace", cast(void**)& GdipGetGenericFontFamilyMonospace },
    { "GdipGetGenericFontFamilySerif", cast(void**)& GdipGetGenericFontFamilySerif },
    { "GdipGetGenericFontFamilySansSerif", cast(void**)& GdipGetGenericFontFamilySansSerif },
    { "GdipGetEmHeight", cast(void**)& GdipGetEmHeight },
    { "GdipGetCellAscent", cast(void**)& GdipGetCellAscent },
    { "GdipGetCellDescent", cast(void**)& GdipGetCellDescent },
    { "GdipGetLineSpacing", cast(void**)& GdipGetLineSpacing },
    { "GdipIsStyleAvailable", cast(void**)& GdipIsStyleAvailable },
    { "GdipCreateFont", cast(void**)& GdipCreateFont },
    { "GdipCreateFontFromDC", cast(void**)& GdipCreateFontFromDC },
    { "GdipDeleteFont", cast(void**)& GdipDeleteFont },
    { "GdipCloneFont", cast(void**)& GdipCloneFont },
    { "GdipGetFontSize", cast(void**)& GdipGetFontSize },
    { "GdipGetFontHeight", cast(void**)& GdipGetFontHeight },
    { "GdipGetFontHeightGivenDPI", cast(void**)& GdipGetFontHeightGivenDPI },
    { "GdipGetFontStyle", cast(void**)& GdipGetFontStyle },
    { "GdipGetFontUnit", cast(void**)& GdipGetFontUnit },
    { "GdipGetFamily", cast(void**)& GdipGetFamily },
    { "GdipCreateFontFromLogfontW", cast(void**)& GdipCreateFontFromLogfontW },
    { "GdipCreateFontFromLogfontA", cast(void**)& GdipCreateFontFromLogfontA },
    { "GdipGetLogFontW", cast(void**)& GdipGetLogFontW },
    { "GdipCreateStringFormat", cast(void**)& GdipCreateStringFormat },
    { "GdipDeleteStringFormat", cast(void**)& GdipDeleteStringFormat },
    { "GdipGetStringFormatFlags", cast(void**)& GdipGetStringFormatFlags },
    { "GdipSetStringFormatFlags", cast(void**)& GdipSetStringFormatFlags },
    { "GdipGetStringFormatAlign", cast(void**)& GdipGetStringFormatAlign },
    { "GdipSetStringFormatAlign", cast(void**)& GdipSetStringFormatAlign },
    { "GdipGetStringFormatLineAlign", cast(void**)& GdipGetStringFormatLineAlign },
    { "GdipSetStringFormatLineAlign", cast(void**)& GdipSetStringFormatLineAlign },
    { "GdipGetStringFormatTrimming", cast(void**)& GdipGetStringFormatTrimming },
    { "GdipSetStringFormatTrimming", cast(void**)& GdipSetStringFormatTrimming },
    { "GdipCreatePath", cast(void**)& GdipCreatePath },
    { "GdipCreatePath2", cast(void**)& GdipCreatePath2 },
    { "GdipCreatePath2I", cast(void**)& GdipCreatePath2I },
    { "GdipDeletePath", cast(void**)& GdipDeletePath },
    { "GdipClonePath", cast(void**)& GdipClonePath },
    { "GdipResetPath", cast(void**)& GdipResetPath },
    { "GdipGetPathFillMode", cast(void**)& GdipGetPathFillMode },
    { "GdipSetPathFillMode", cast(void**)& GdipSetPathFillMode },
    { "GdipStartPathFigure", cast(void**)& GdipStartPathFigure },
    { "GdipClosePathFigure", cast(void**)& GdipClosePathFigure },
    { "GdipClosePathFigures", cast(void**)& GdipClosePathFigures },
    { "GdipSetPathMarker", cast(void**)& GdipSetPathMarker },
    { "GdipClearPathMarkers", cast(void**)& GdipClearPathMarkers },
    { "GdipReversePath", cast(void**)& GdipReversePath },
    { "GdipGetPathLastPoint", cast(void**)& GdipGetPathLastPoint },
    { "GdipAddPathLine", cast(void**)& GdipAddPathLine },
    { "GdipAddPathLineI", cast(void**)& GdipAddPathLineI },
    { "GdipAddPathLine2", cast(void**)& GdipAddPathLine2 },
    { "GdipAddPathLine2I", cast(void**)& GdipAddPathLine2I },
    { "GdipAddPathArc", cast(void**)& GdipAddPathArc },
    { "GdipAddPathArcI", cast(void**)& GdipAddPathArcI },
    { "GdipAddPathBezier", cast(void**)& GdipAddPathBezier },
    { "GdipAddPathBezierI", cast(void**)& GdipAddPathBezierI },
    { "GdipAddPathBeziers", cast(void**)& GdipAddPathBeziers },
    { "GdipAddPathBeziersI", cast(void**)& GdipAddPathBeziersI },
    { "GdipAddPathCurve", cast(void**)& GdipAddPathCurve },
    { "GdipAddPathCurveI", cast(void**)& GdipAddPathCurveI },
    { "GdipAddPathCurve2", cast(void**)& GdipAddPathCurve2 },
    { "GdipAddPathCurve2I", cast(void**)& GdipAddPathCurve2I },
    { "GdipAddPathCurve3", cast(void**)& GdipAddPathCurve3 },
    { "GdipAddPathCurve3I", cast(void**)& GdipAddPathCurve3I },
    { "GdipAddPathClosedCurve", cast(void**)& GdipAddPathClosedCurve },
    { "GdipAddPathClosedCurveI", cast(void**)& GdipAddPathClosedCurveI },
    { "GdipAddPathClosedCurve2", cast(void**)& GdipAddPathClosedCurve2 },
    { "GdipAddPathClosedCurve2I", cast(void**)& GdipAddPathClosedCurve2I },
    { "GdipAddPathRectangle", cast(void**)& GdipAddPathRectangle },
    { "GdipAddPathRectangleI", cast(void**)& GdipAddPathRectangleI },
    { "GdipAddPathRectangles", cast(void**)& GdipAddPathRectangles },
    { "GdipAddPathRectanglesI", cast(void**)& GdipAddPathRectanglesI },
    { "GdipAddPathEllipse", cast(void**)& GdipAddPathEllipse },
    { "GdipAddPathEllipseI", cast(void**)& GdipAddPathEllipseI },
    { "GdipAddPathPie", cast(void**)& GdipAddPathPie },
    { "GdipAddPathPieI", cast(void**)& GdipAddPathPieI },
    { "GdipAddPathPolygon", cast(void**)& GdipAddPathPolygon },
    { "GdipAddPathPolygonI", cast(void**)& GdipAddPathPolygonI },
    { "GdipAddPathPath", cast(void**)& GdipAddPathPath },
    { "GdipAddPathString", cast(void**)& GdipAddPathString },
    { "GdipAddPathStringI", cast(void**)& GdipAddPathStringI },
    { "GdipTransformPath", cast(void**)& GdipTransformPath },
    { "GdipGetPathWorldBounds", cast(void**)& GdipGetPathWorldBounds },
    { "GdipFlattenPath", cast(void**)& GdipFlattenPath },
    { "GdipWidenPath", cast(void**)& GdipWidenPath },
    { "GdipWindingModeOutline", cast(void**)& GdipWindingModeOutline },
    { "GdipWarpPath", cast(void**)& GdipWarpPath },
    { "GdipGetPointCount", cast(void**)& GdipGetPointCount },
    { "GdipGetPathTypes", cast(void**)& GdipGetPathTypes },
    { "GdipGetPathPoints", cast(void**)& GdipGetPathPoints },
    { "GdipIsVisiblePathPoint", cast(void**)& GdipIsVisiblePathPoint },
    { "GdipIsVisiblePathPointI", cast(void**)& GdipIsVisiblePathPointI },
    { "GdipIsOutlineVisiblePathPoint", cast(void**)& GdipIsOutlineVisiblePathPoint },
    { "GdipIsOutlineVisiblePathPointI", cast(void**)& GdipIsOutlineVisiblePathPointI },
    { "GdipDrawPath", cast(void**)& GdipDrawPath },
    { "GdipCreatePathIter", cast(void**)& GdipCreatePathIter },
    { "GdipDeletePathIter", cast(void**)& GdipDeletePathIter },
    { "GdipPathIterNextSubpath", cast(void**)& GdipPathIterNextSubpath },
    { "GdipPathIterNextSubpathPath", cast(void**)& GdipPathIterNextSubpathPath },
    { "GdipPathIterNextPathType", cast(void**)& GdipPathIterNextPathType },
    { "GdipPathIterNextMarker", cast(void**)& GdipPathIterNextMarker },
    { "GdipPathIterNextMarkerPath", cast(void**)& GdipPathIterNextMarkerPath },
    { "GdipPathIterGetCount", cast(void**)& GdipPathIterGetCount },
    { "GdipPathIterGetSubpathCount", cast(void**)& GdipPathIterGetSubpathCount },
    { "GdipPathIterHasCurve", cast(void**)& GdipPathIterHasCurve },
    { "GdipPathIterRewind", cast(void**)& GdipPathIterRewind },
    { "GdipPathIterEnumerate", cast(void**)& GdipPathIterEnumerate },
    { "GdipPathIterCopyData", cast(void**)& GdipPathIterCopyData },
    { "GdipCreatePathGradient", cast(void**)& GdipCreatePathGradient },
    { "GdipCreatePathGradientI", cast(void**)& GdipCreatePathGradientI },
    { "GdipCreatePathGradientFromPath", cast(void**)& GdipCreatePathGradientFromPath },
    { "GdipGetPathGradientCenterColor", cast(void**)& GdipGetPathGradientCenterColor },
    { "GdipSetPathGradientCenterColor", cast(void**)& GdipSetPathGradientCenterColor },
    { "GdipGetPathGradientSurroundColorCount", cast(void**)& GdipGetPathGradientSurroundColorCount },
    { "GdipGetPathGradientSurroundColorsWithCount", cast(void**)& GdipGetPathGradientSurroundColorsWithCount },
    { "GdipSetPathGradientSurroundColorsWithCount", cast(void**)& GdipSetPathGradientSurroundColorsWithCount },
    { "GdipGetPathGradientCenterPoint", cast(void**)& GdipGetPathGradientCenterPoint },
    { "GdipSetPathGradientCenterPoint", cast(void**)& GdipSetPathGradientCenterPoint },
    { "GdipGetPathGradientRect", cast(void**)& GdipGetPathGradientRect },
    { "GdipGetPathGradientBlendCount", cast(void**)& GdipGetPathGradientBlendCount },
    { "GdipGetPathGradientBlend", cast(void**)& GdipGetPathGradientBlend },
    { "GdipSetPathGradientBlend", cast(void**)& GdipSetPathGradientBlend },
    { "GdipGetPathGradientPresetBlendCount", cast(void**)& GdipGetPathGradientPresetBlendCount },
    { "GdipGetPathGradientPresetBlend", cast(void**)& GdipGetPathGradientPresetBlend },
    { "GdipSetPathGradientPresetBlend", cast(void**)& GdipSetPathGradientPresetBlend },
    { "GdipSetPathGradientSigmaBlend", cast(void**)& GdipSetPathGradientSigmaBlend },
    { "GdipSetPathGradientLinearBlend", cast(void**)& GdipSetPathGradientLinearBlend },
    { "GdipGetPathGradientTransform", cast(void**)& GdipGetPathGradientTransform },
    { "GdipSetPathGradientTransform", cast(void**)& GdipSetPathGradientTransform },
    { "GdipResetPathGradientTransform", cast(void**)& GdipResetPathGradientTransform },
    { "GdipMultiplyPathGradientTransform", cast(void**)& GdipMultiplyPathGradientTransform },
    { "GdipRotatePathGradientTransform", cast(void**)& GdipRotatePathGradientTransform },
    { "GdipTranslatePathGradientTransform", cast(void**)& GdipTranslatePathGradientTransform },
    { "GdipScalePathGradientTransform", cast(void**)& GdipScalePathGradientTransform },
    { "GdipGetPathGradientFocusScales", cast(void**)& GdipGetPathGradientFocusScales },
    { "GdipSetPathGradientFocusScales", cast(void**)& GdipSetPathGradientFocusScales },
    { "GdipGetPathGradientWrapMode", cast(void**)& GdipGetPathGradientWrapMode },
    { "GdipSetPathGradientWrapMode", cast(void**)& GdipSetPathGradientWrapMode },
    { "GdipResetTextureTransform", cast(void**)& GdipResetTextureTransform },
    { "GdipScaleTextureTransform", cast(void**)& GdipScaleTextureTransform },
    { "GdipTranslateTextureTransform", cast(void**)& GdipTranslateTextureTransform },
    { "GdipStringFormatGetGenericDefault", cast(void**)& GdipStringFormatGetGenericDefault },
    { "GdipStringFormatGetGenericTypographic", cast(void**)& GdipStringFormatGetGenericTypographic },
    { "GdipSetStringFormatHotkeyPrefix", cast(void**)& GdipSetStringFormatHotkeyPrefix },
    { "GdipSetStringFormatTabStops", cast(void**)& GdipSetStringFormatTabStops },
];


void loadLib_Gdip(){
    SharedLib.loadLibSymbols( symbols, "gdiplus.dll" );
}

}

/******************************************************************************

******************************************************************************/
/+
private uint initToken;
private bool isShutdown;

public int startup() {
  static GdiplusStartupInput input = { 1, null, 0, 0 };
  static GdiplusStartupOutput output;

  return GdiplusStartup(initToken, input, output);
}

public void shutdown() {
  // GC.collect();
  isShutdown = true;

  GdiplusShutdown(initToken);
}
+/
