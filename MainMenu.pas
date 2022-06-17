unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TExercise = record
    Name: String;
    Description: String;
    IsWeighted: String;
  end;
  TMenu = class(TForm)
    Login: TButton;
    LoginCautionMessage: TLabel;
    UserName: TLabel;
    EnterTheTraining: TButton;
    CreateNewTraining: TButton;
    CreateNewExercise: TButton;
    ShowTheStatistics: TButton;
    procedure LoginClick(Sender: TObject);
    procedure CreateNewExerciseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Menu: TMenu;
  defaultExercises: array of TExercise;
  UserID: integer;

implementation

uses
  Authorization, Exercises;

{$R *.dfm}

procedure TMenu.CreateNewExerciseClick(Sender: TObject);
begin
  Exercises.Actions.Show;
end;

procedure TMenu.LoginClick(Sender: TObject);
begin
  Authorization.Login.Show;
  Authorization.Login.LogStatus.Visible := False;
end;
end.
