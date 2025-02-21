unit Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs;

type
  TMainView = class(TForm)

  private
    procedure ApplyDisplayAffinity;
    procedure WMPaint(var aMessage: TWMPaint); message WM_PAINT;
  protected
//    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

const
  WDA_NONE = $0;
  WDA_MONITOR = $1;
  WDA_EXCLUDEFROMCAPTURE = $11;

{ Apply SetWindowDisplayAffinity to block screen capture }
procedure TMainView.ApplyDisplayAffinity;
begin
  if not SetWindowDisplayAffinity(Handle, WDA_EXCLUDEFROMCAPTURE) then
    raise Exception.Create('Failed to set window display affinity');
end;

constructor TMainView.Create(AOwner: TComponent);
begin
  inherited;
  ApplyDisplayAffinity;

end;

//procedure TMainView.CreateParams(var Params: TCreateParams);
//begin
//  inherited CreateParams(Params);
////  Params.Style := WS_OVERLAPPEDWINDOW or WS_VISIBLE;
//   { Apply CS_HREDRAW and CS_VREDRAW for proper repainting }
//  Params.WindowClass.style := CS_HREDRAW or CS_VREDRAW;
//end;

procedure TMainView.WMPaint(var aMessage: TWMPaint);
var
  LPaintStruct: TPaintStruct;
  LRect: TRect;
  LMsgText: string;
begin
  BeginPaint(Handle, LPaintStruct);
  try
    LMsgText := 'You cannot take screenshots of this!';
    LRect := ClientRect;

    Canvas.Brush.Color := clYellow;
    Canvas.FillRect(LRect);

    Canvas.Font.Size := 12;
    Canvas.Font.Color := clBlue;
    DrawText(Canvas.Handle, PChar(LMsgText), Length(LMsgText), LRect,
      DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  finally
    EndPaint(Handle, LPaintStruct);
  end;

//  aMessage.Result := 0;
end;

end.
