program Project1;

uses
  Vcl.Forms,
  MainMenu in 'MainMenu.pas' {Menu},
  Vcl.Themes,
  Vcl.Styles,
  Authorization in 'Authorization.pas' {Login},
  defaultexercises in 'defaultexercises.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Ruby Graphite');
  Application.CreateForm(TMenu, Menu);
  Application.CreateForm(TLogin, Login);
  Application.Run;
end.
