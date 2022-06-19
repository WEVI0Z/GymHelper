unit ExsRealise;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TExsRealiseForm = class(TForm)
    NameOfTheExercisesLabel: TLabel;
    Times: TEdit;
    TimesLabel: TLabel;
    Weight: TEdit;
    WeightLabel: TLabel;
    Next: TButton;
    procedure NextClick(Sender: TObject);
  private
    { Private declarations }
  public
    currentID: integer;
    currentStat: integer;
  end;

var
  ExsRealiseForm: TExsRealiseForm;

implementation

uses Authorization, TrainingChoosing, MainMenu, TrainingTime;

{$R *.dfm}

procedure TExsRealiseForm.NextClick(Sender: TObject);
begin
  setLength(users[UserID].Stats[CurrentStat].Exercises, length(users[UserID].Stats[CurrentStat].Exercises) + 1);

  users[UserID].Stats[CurrentStat].Exercises[currentID].Name := NameOfTheExercisesLabel.Caption;
  users[UserID].Stats[CurrentStat].Exercises[currentID].Times := strToInt(Times.Text);
  users[UserID].Stats[CurrentStat].Exercises[currentID].Weight := strToInt(Weight.Text);

  inc(CurrentID);

  if currentID <= length(users[UserID].Trainings[TrainingChoosing.TrainingChooseForm.targetID].Exercises) - 1 then
  begin
    ExsRealise.ExsRealiseForm.NameOfTheExercisesLabel.Caption := users[UserID].Trainings[TrainingChoosing.TrainingChooseForm.targetID].Exercises[CurrentID].Name;

    Times.Text := '';
    Weight.Text := '';

    if users[UserID].Trainings[TrainingChoosing.TrainingChooseForm.targetID].Exercises[CurrentID].IsWeighted = False then
    begin
      Weight.Visible := False;
      Weight.Text := '0';
      ExsRealiseForm.Height := 120;
      WeightLabel.Visible := False;
    end
    else
    begin
      Weight.Visible := True;
      ExsRealiseForm.Height := 160;
      WeightLabel.Visible := True;
    end;
  end
  else
  begin
    ExsRealise.ExsRealiseForm.Close;
    TrainingTime.TrainingTimeForm.Show;
    TrainingTime.TrainingTimeForm.Time.Text := '';
    TrainingTime.TrainingTimeForm.Date.Text := '';
  users[UserID].Stats[ExsRealise.ExsRealiseForm.currentStat].Name := ExsRealise.ExsRealiseForm.Caption;
  end;
end;

end.