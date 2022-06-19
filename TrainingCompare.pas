unit TrainingCompare;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TCompareForm = class(TForm)
    NameOfTheBestTraining: TLabel;
    NameOfTheCurrentTraining: TLabel;
    BestTime: TLabel;
    CurrentTime: TLabel;
    BestTimes: TLabel;
    CurrentTimes: TLabel;
    BestWeight: TLabel;
    CurrentWeight: TLabel;
    GetMoreInfoButton: TButton;
    ConfirmButton: TButton;
    Score: TLabel;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure GetMoreInfoButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    currentID: integer;
    maxID: integer;
  end;

var
  CompareForm: TCompareForm;

implementation

{$R *.dfm}

uses TrainingsStats, TrainingDetails, MainMenu, Authorization;

procedure TCompareForm.ConfirmButtonClick(Sender: TObject);
begin
  compareForm.Close;
end;

procedure TCompareForm.GetMoreInfoButtonClick(Sender: TObject);

var i: integer;
    names: array of TLabel;
    times: array of TLabel;
    weights: array of TLabel;

begin
  TrainingDetails.DetailsForm.Show;

  setLength(names, length(users[UserID].Stats[CurrentID].Exercises));
  setLength(times, length(users[UserID].Stats[CurrentID].Exercises));
  setLength(weights, length(users[UserID].Stats[CurrentID].Exercises));
  TrainingDetails.DetailsForm.ExsWrap.DestroyComponents;
  TrainingDetails.DetailsForm.Caption := users[UserID].Stats[trainingCompare.CompareForm.currentID].Name + ' (' + users[UserID].Stats[trainingCompare.CompareForm.currentID].Date + ')';

  for i := 0 to length(users[UserID].Stats[CurrentID].Exercises) - 1 do
  begin
    names[i] := TLabel.Create(TrainingDetails.DetailsForm.ExsWrap);
    names[i].Parent := TrainingDetails.DetailsForm.ExsWrap;
    names[i].Top := 40 * (i);
    names[i].Left := 5;
    names[i].Caption := '���������� - ' + users[UserID].Stats[CurrentID].Exercises[i].Name;
    names[i].Width := 200;
    names[i].Height := 30;

    times[i] := TLabel.Create(TrainingDetails.DetailsForm.ExsWrap);
    times[i].Parent := TrainingDetails.DetailsForm.ExsWrap;
    times[i].Top := 40 * (i) + 15;
    times[i].Left := 20;
    times[i].Caption := intToStr(users[UserID].Stats[CurrentID].Exercises[i].Times) + ' ���';
    times[i].Width := 200;
    times[i].Height := 30;

    if users[UserID].Stats[CurrentID].Exercises[i].Weight <> 0 then
    begin
      weights[i] := TLabel.Create(TrainingDetails.DetailsForm.ExsWrap);
      weights[i].Parent := TrainingDetails.DetailsForm.ExsWrap;
      weights[i].Top := 40 * (i) + 15;
      weights[i].Left := 80;
      weights[i].Caption := intToStr(users[UserID].Stats[CurrentID].Exercises[i].Weight) + ' ��';
      weights[i].Width := 200;
      weights[i].Height := 30;

      if i = 0 then
        weights[i].Top := 20;
    end;

    if i = 0 then
    begin
      names[i].Top := 5;
      times[i].Top := 20;
    end;
  end;
end;

end.