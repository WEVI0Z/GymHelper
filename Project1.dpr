program Project1;

uses
  Vcl.Forms,
  MainMenu in 'MainMenu.pas' {Menu},
  Vcl.Themes,
  Vcl.Styles,
  Authorization in 'Authorization.pas' {Login},
  defaultexercises in 'defaultexercises.pas',
  Exercises in 'Exercises.pas' {Actions},
  ExsEditing in 'ExsEditing.pas' {EditForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Ruby Graphite');
  Application.CreateForm(TMenu, Menu);
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(TActions, Actions);
  Application.CreateForm(TEditForm, EditForm);
  Application.Run;
end.
