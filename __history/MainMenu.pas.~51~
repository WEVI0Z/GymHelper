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
    ID: TLabel;
    procedure LoginClick(Sender: TObject);
    procedure CreateNewExerciseClick(Sender: TObject);
    procedure CreateNewTrainingClick(Sender: TObject);
    procedure EnterTheTrainingClick(Sender: TObject);
    procedure ShowTheStatisticsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Menu: TMenu;
  defaultExercises: array of TExercise;
  userID: integer;

implementation

uses
  Authorization, Exercises, TrainingCreation, TrainingChoosing, TrainingsStats;

{$R *.dfm}

procedure DrawTheList();

var i: Integer;

begin
  setLength(labels, length(users[UserID].Exercises));
  setLength(buttons, length(users[UserID].Exercises));
  Actions.ScrollBox1.DestroyComponents;

  for i := 0 to length(users[UserID].Exercises) - 1 do
  begin
    labels[i] := TLabel.Create(Actions.ScrollBox1);
    labels[i].Parent := Actions.ScrollBox1;
    labels[i].Top := 40 * (i);
    labels[i].Left := 20;
    labels[i].Caption := users[UserID].Exercises[i].Name;
    labels[i].Width := 200;
    labels[i].Height := 30;

    buttons[i] := TButton.Create(Actions.ScrollBox1);
    buttons[i].Parent := Actions.ScrollBox1;
    buttons[i].Top := 40 * (i);
    buttons[i].Left := 230;
    buttons[i].Caption := '>';
    buttons[i].Width := 30;
    buttons[i].Height := 30;

    if i = 0 then
    begin
      labels[i].Top := 5;
      buttons[i].Top := 5;
    end;
  end;
  for i := 0 to length(buttons) - 1 do
  buttons[i].OnClick := Actions.Button1Click;
end;

procedure TMenu.CreateNewExerciseClick(Sender: TObject);
begin
  Exercises.Actions.Show;
  userID := StrToInt(ID.caption);
  drawTheList();
end;

procedure TMenu.CreateNewTrainingClick(Sender: TObject);
begin
  TrainingCreation.CreateTrainingForm.show;
  TrainingCreation.CreateTrainingForm.ExsWrap.DestroyComponents;
  TrainingCreation.CreateTrainingForm.NameOfTheTraining.Text := '';

  UserID := StrToInt(ID.caption);
end;

procedure TMenu.EnterTheTrainingClick(Sender: TObject);

var i: integer;

begin
  UserID := StrToInt(ID.caption);
  TrainingChoosing.TrainingChooseForm.Show;

  setLength(TrainingChoosing.TrainingChooseForm.labels, length(users[UserID].Exercises));
  setLength(TrainingChoosing.TrainingChooseForm.buttons, length(users[UserID].Exercises));
  TrainingChoosing.TrainingChooseForm.TrainingsWrap.DestroyComponents;

  for i := 0 to length(users[UserID].Trainings) - 1 do
  begin
    TrainingChoosing.TrainingChooseForm.labels[i] := TLabel.Create(TrainingChoosing.TrainingChooseForm.TrainingsWrap);
    TrainingChoosing.TrainingChooseForm.labels[i].Parent := TrainingChoosing.TrainingChooseForm.TrainingsWrap;
    TrainingChoosing.TrainingChooseForm.labels[i].Top := 40 * (i);
    TrainingChoosing.TrainingChooseForm.labels[i].Left := 20;
    TrainingChoosing.TrainingChooseForm.labels[i].Caption := users[UserID].Trainings[i].Name;
    TrainingChoosing.TrainingChooseForm.labels[i].Width := 200;
    TrainingChoosing.TrainingChooseForm.labels[i].Height := 30;

    TrainingChoosing.TrainingChooseForm.buttons[i] := TButton.Create(TrainingChoosing.TrainingChooseForm.TrainingsWrap);
    TrainingChoosing.TrainingChooseForm.buttons[i].Parent := TrainingChoosing.TrainingChooseForm.TrainingsWrap;
    TrainingChoosing.TrainingChooseForm.buttons[i].Top := 40 * (i);
    TrainingChoosing.TrainingChooseForm.buttons[i].Left := 230;
    TrainingChoosing.TrainingChooseForm.buttons[i].Caption := '>';
    TrainingChoosing.TrainingChooseForm.buttons[i].Width := 30;
    TrainingChoosing.TrainingChooseForm.buttons[i].Height := 30;
    TrainingChoosing.TrainingChooseForm.buttons[i].OnClick := TrainingChoosing.TrainingChooseForm.TempButtonClick;

    if i = 0 then
    begin
      TrainingChoosing.TrainingChooseForm.labels[i].Top := 5;
      TrainingChoosing.TrainingChooseForm.buttons[i].Top := 5;
    end;
  end;

  TrainingChoosing.TrainingChooseForm.TempButton.Free;
end;

procedure TMenu.LoginClick(Sender: TObject);
begin
  Authorization.Login.Show;
  Authorization.Login.LogStatus.Visible := False;
end;
procedure TMenu.ShowTheStatisticsClick(Sender: TObject);

var i: Integer;

begin
  UserID := StrToInt(ID.caption);
  trainingsStats.TrainingStatsForm.Show;

  setLength(trainingsStats.TrainingStatsForm.labels, length(users[UserID].Stats));
  setLength(trainingsStats.TrainingStatsForm.buttons, length(users[UserID].Stats));
  TrainingsStats.TrainingStatsForm.StatWrap.DestroyComponents;

  for i := 0 to length(users[UserID].Stats) - 1 do
  begin
    trainingsStats.TrainingStatsForm.labels[i] := TLabel.Create(TrainingsStats.TrainingStatsForm.StatWrap);
    trainingsStats.TrainingStatsForm.labels[i].Parent := TrainingsStats.TrainingStatsForm.StatWrap;
    trainingsStats.TrainingStatsForm.labels[i].Top := 40 * (i);
    trainingsStats.TrainingStatsForm.labels[i].Left := 20;
    trainingsStats.TrainingStatsForm.labels[i].Caption := users[UserID].Stats[i].Name + ' (' + users[UserID].Stats[i].Date + ')';
    trainingsStats.TrainingStatsForm.labels[i].Width := 200;
    trainingsStats.TrainingStatsForm.labels[i].Height := 30;

    trainingsStats.TrainingStatsForm.buttons[i] := TButton.Create(TrainingsStats.TrainingStatsForm.StatWrap);
    trainingsStats.TrainingStatsForm.buttons[i].Parent := TrainingsStats.TrainingStatsForm.StatWrap;
    trainingsStats.TrainingStatsForm.buttons[i].Top := 40 * (i);
    trainingsStats.TrainingStatsForm.buttons[i].Left := 230;
    trainingsStats.TrainingStatsForm.buttons[i].Caption := '>';
    trainingsStats.TrainingStatsForm.buttons[i].Width := 30;
    trainingsStats.TrainingStatsForm.buttons[i].Height := 30;
    trainingsStats.TrainingStatsForm.buttons[i].OnClick := trainingsStats.TrainingStatsForm.TempButtonClick;

    if i = 0 then
    begin
      trainingsStats.TrainingStatsForm.labels[i].Top := 5;
      trainingsStats.TrainingStatsForm.buttons[i].Top := 5;
    end;
  end;
  trainingsStats.TrainingStatsForm.TempButton.Free;
end;

end.
