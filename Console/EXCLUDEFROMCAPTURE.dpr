program EXCLUDEFROMCAPTURE;

uses
  Vcl.Forms,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

const
  WDA_NONE = $0;
  WDA_MONITOR = $1;
  WDA_EXCLUDEFROMCAPTURE  = $11;

var
  WindowClass: string = 'window';
  InstanceHandle: HINST;

function WndProc(ahWnd: hWnd; aMsg: UINT; awParam: wParam; alParam: lParam): LRESULT; stdcall;
var
  LPAINTSTRUCT: PAINTSTRUCT;
  Lhdc: hdc;
  Lrect: TRect;
  Lbrush: HBRUSH;
  LMsgText: string;
begin
  case aMsg of
    WM_CREATE:
      begin
        OutputDebugString('WM_CREATE');
        Result := 0;
      end;

    WM_PAINT:
      begin
        OutputDebugString('WM_PAINT');
        LMsgText := 'You cannot take screenshots of this!';
        Lhdc := BeginPaint(ahWnd, LPAINTSTRUCT);
        try
          Lbrush := CreateSolidBrush(RGB(240, 240, 0)); // Yellow
          FillRect(Lhdc, LPAINTSTRUCT.rcPaint, Lbrush);
          DeleteObject(Lbrush);

          GetClientRect(ahWnd, Lrect);
          DrawText(Lhdc, PChar(LMsgText), Length(LMsgText), Lrect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
        finally
          EndPaint(ahWnd, LPAINTSTRUCT);
        end;
        Result := 0;
      end;

    WM_DESTROY:
      begin
        OutputDebugString('WM_DESTROY');
        PostQuitMessage(0);
        Result := 0;
      end;

  else
    Result := DefWindowProc(ahWnd, aMsg, awParam, alParam);
  end;
end;

procedure RunApp;
var
  Lwc: WNDCLASS;
  LhWnd: hWnd;
  LMsg: Msg;
begin
  InstanceHandle := GetModuleHandle(nil);

  FillChar(Lwc, SizeOf(Lwc), 0);
  Lwc.style := CS_HREDRAW or CS_VREDRAW;
  Lwc.lpfnWndProc := @WndProc;
  Lwc.hInstance := InstanceHandle;
  Lwc.hCursor := LoadCursor(0, IDC_ARROW);
  Lwc.lpszClassName := PChar(WindowClass);

  if RegisterClass(Lwc) = 0 then
  begin
    raise Exception.Create('Failed to register window class');
  end;

  LhWnd := CreateWindowEx(
    0,
    PChar(WindowClass),
    'My Form',
    WS_OVERLAPPEDWINDOW or WS_VISIBLE,
    CW_USEDEFAULT, CW_USEDEFAULT, 320, 240,
    0, 0, InstanceHandle, nil
  );

  if LhWnd = 0 then
  begin
    raise Exception.Create('Failed to create window');
  end;

  // Prevent screenshots
  SetWindowDisplayAffinity(LhWnd, WDA_EXCLUDEFROMCAPTURE);

  while GetMessage(LMsg, 0, 0, 0) do
  begin
    TranslateMessage(LMsg);
    DispatchMessage(LMsg);
  end;
end;

begin

  RunApp;
//  Readln;
end.
