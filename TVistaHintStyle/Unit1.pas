// Автор Зорков Игорь - zorkovigor@mail.ru

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ExtCtrls;

type
  THintStyle = (hsXP, hsVista);

type
   TMyHintWindow = class(THintWindow)
   private
    FBitmap: TBitmap;
    FRegion: THandle;
    procedure FreeRegion;
   protected
    procedure CreateParams (var Params: TCreateParams); override;
    procedure Paint; override;
    procedure Erase(var Message: TMessage); message WM_ERASEBKGND;
   public
     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
     procedure ActivateHint(Rect: TRect; const AHint: String); Override;
   end;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  HintStyle: THintStyle;

implementation

{$R *.dfm}

constructor TMyHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBitmap := TBitmap.Create;
  FBitmap.PixelFormat := pf24bit;
end;

destructor TMyHintWindow.Destroy;
begin
  FBitmap.Free;
  FreeRegion;
  inherited;
end;

procedure TMyHintWindow.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $20000;
begin
  inherited;
  Params.Style := Params.Style - WS_BORDER;
  Params.WindowClass.Style := Params.WindowClass.style or CS_DROPSHADOW;
end;

procedure TMyHintWindow.FreeRegion;
begin
  if FRegion <> 0 then
  begin
    SetWindowRgn(Handle, 0, True);
    DeleteObject(FRegion);
    FRegion := 0;
  end;
end;

procedure TMyHintWindow.ActivateHint(Rect: TRect; const AHint: String);
var
  i: Integer;
begin
  Caption := AHint;
  Canvas.Font := Screen.HintFont;
  FBitmap.Canvas.Font := Screen.HintFont;
  DrawText(Canvas.Handle, PChar(Caption), Length(Caption), Rect, DT_CALCRECT  or DT_NOPREFIX);
  case HintStyle of
    hsVista:
      begin
        Width := (Rect.Right - Rect.Left) + 16;
        Height := (Rect.Bottom - Rect.Top) + 10;
      end;
    hsXP:
      begin
        Width := (Rect.Right - Rect.Left) + 10;
        Height := (Rect.Bottom - Rect.Top) + 6;
      end;
  end;
  FBitmap.Width := Width;
  FBitmap.Height := Height;
  Left := Rect.Left;
  Top := Rect.Top;
  FreeRegion;
  if HintStyle = hsVista then
  begin
    with Rect do
      FRegion := CreateRoundRectRgn(1, 1, Width, Height, 3, 3);
    if FRegion <> 0 then
      SetWindowRgn(Handle, FRegion, True);
    AnimateWindowProc(Handle, 300, AW_BLEND);
  end;
  SetWindowPos(Handle, HWND_TOPMOST, Left, Top, 0, 0, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);
end;

procedure DrawGradientVertical(Canvas: TCanvas; Rect: TRect; FromColor, ToColor: TColor);
var
  i, Y: Integer;
  R, G, B: Byte;
begin
   i := 0;
   for Y := Rect.Top to Rect.Bottom - 1 do
   begin
      R := GetRValue(FromColor) + Ceil(((GetRValue(ToColor) - GetRValue(FromColor)) / Rect.Bottom-Rect.Top) * i);
      G := GetGValue(FromColor) + Ceil(((GetGValue(ToColor) - GetGValue(FromColor)) / Rect.Bottom-Rect.Top) * i);
      B := GetBValue(FromColor) + Ceil(((GetBValue(ToColor) - GetBValue(FromColor)) / Rect.Bottom-Rect.Top) * i);
      Canvas.Pen.Color := RGB(R, G, B);
      Canvas.MoveTo(Rect.Left, Y);
      Canvas.LineTo(Rect.Right, Y);
      Inc(i);
   end;
end;

procedure TMyHintWindow.Paint;
var
  CaptionRect: TRect;
begin
  case HintStyle of
    hsVista:
      begin
        DrawGradientVertical(FBitmap.Canvas, GetClientRect, RGB(255, 255, 255),  RGB(229, 229, 240));
        with FBitmap.Canvas do
        begin
          Font.Color := clGray;
          Brush.Style := bsClear;
          Pen.Color := RGB(118, 118, 118);
          RoundRect(1, 1, Width - 1, Height - 1, 6, 6);
          RoundRect(1, 1, Width - 1, Height - 1, 3, 3);
        end;
        CaptionRect := Rect(8, 5, Width, Height);
      end;
    hsXP:
      begin
        with FBitmap.Canvas do
        begin
          Font.Color := clBlack;
          Brush.Style := bsSolid;
          Brush.Color := clInfoBk;
          Pen.Color := RGB(0, 0, 0);
          Rectangle(0, 0, Width, Height);
        end;
        CaptionRect := Rect(5, 3, Width, Height);
      end;
  end;
  DrawText(FBitmap.Canvas.Handle, PChar(Caption), Length(Caption), CaptionRect, DT_WORDBREAK or DT_NOPREFIX);
  BitBlt(Canvas.Handle, 0, 0, Width, Height, FBitmap.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TMyHintWindow.Erase(var Message: TMessage);
begin
  Message.Result := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  HintWindowClass := TMyHintWindow;
  Label1.Hint := 'We have been distributing our software products exclusively through the Internet since 2003' + #13#10 +
    'Our software development kit is currently being used by hundreds of companies';
  Label2.Hint := Label1.Hint;
end;

procedure TForm1.Label1MouseEnter(Sender: TObject);
begin
  HintStyle := hsXP;
end;

procedure TForm1.Label2MouseEnter(Sender: TObject);
begin
  HintStyle := hsVista;
end;

end.
