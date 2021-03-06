unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMenu = class(TForm)
    Login: TButton;
    LoginCautionMessage: TLabel;
    UserName: TLabel;
    EnterTheTraining: TButton;
    CreateNewTraining: TButton;
    CreateNewExercise: TButton;
    ShowTheStatistics: TButton;
    procedure LoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Menu: TMenu;

implementation

uses
  Authorization;

{$R *.dfm}

procedure TMenu.LoginClick(Sender: TObject);
begin
  Authorization.Login.Show;
  Authorization.Login.LogStatus.Visible := False;
end;

end.
