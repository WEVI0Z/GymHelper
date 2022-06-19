unit TrainingChoosing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TTrainingChooseForm = class(TForm)
    TrainingsWrap: TScrollBox;
    TempButton: TButton;
    procedure TempButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    labels: array of TLabel;
    buttons: array of TButton;
    targetID: integer;
  end;

var
  TrainingChooseForm: TTrainingChooseForm;

implementation

uses Authorization, MainMenu, ExsRealise;
{$R *.dfm}

procedure TTrainingChooseForm.TempButtonClick(Sender: TObject);

var i: integer;

begin
  for i := 0 to length(users[UserID].Trainings) - 1 do
    if buttons[i] = Sender then
      targetID := i;

  setLength(users[UserID].Stats, length(users[UserID].Stats) + 1);

  ExsRealise.ExsRealiseForm.Show;

  ExsRealise.ExsRealiseForm.Caption := users[UserID].Trainings[TargetID].Name;
  ExsRealise.ExsRealiseForm.NameOfTheExercisesLabel.Caption := users[UserID].Trainings[TargetID].Exercises[0].Name;

  if users[UserID].Trainings[TargetID].Exercises[0].IsWeighted = False then
  begin
    exsRealise.ExsRealiseForm.Weight.Visible := False;
    exsRealise.ExsRealiseForm.WeightLabel.Visible := False;
    exsRealise.ExsRealiseForm.Weight.Text := '0';
    exsRealise.ExsRealiseForm.Height := 120;
  end;

  ExsRealise.ExsRealiseForm.currentID := 0;
  ExsRealise.ExsRealiseForm.currentStat := length(users[UserID].Stats) - 1;
end;

end.