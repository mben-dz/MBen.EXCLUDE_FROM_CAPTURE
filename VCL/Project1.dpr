program Project1;

uses
  Vcl.Forms,
  Main.View in 'Main.View.pas' {MainView},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
