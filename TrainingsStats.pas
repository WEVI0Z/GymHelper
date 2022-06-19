unit TrainingsStats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TTrainingStatsForm = class(TForm)
    StatWrap: TScrollBox;
    TempButton: TButton;
    procedure TempButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    buttons: array of TButton;
    labels: array of TLabel;
  end;

var
  TrainingStatsForm: TTrainingStatsForm;

implementation

uses TrainingCompare, MainMenu, Authorization;

{$R *.dfm}

procedure TTrainingStatsForm.TempButtonClick(Sender: TObject);

var i, j, tempTime, tempWeights, tempTimes, tempMax, maxWeights, maxTimes, currentWeights, currentTimes: integer;

begin
  for i := 0 to length(buttons) - 1 do
    if buttons[i] = Sender then
       trainingCompare.CompareForm.currentID := i;

  trainingsStats.TrainingStatsForm.close;

  tempMax := 0;

  for i := 0 to high(users[UserID].Stats) do
  begin
    tempWeights := 0;
    tempTimes := 0;

    for j := 0 to high(users[UserID].Stats[i].Exercises) do
    begin
      tempWeights := tempWeights + users[UserID].Stats[i].Exercises[j].Weight * users[UserID].Stats[i].Exercises[j].Times;
      tempTimes := tempTimes + users[UserID].Stats[i].Exercises[j].Times;
    end;

    if tempWeights * tempTimes * users[UserID].Stats[i].Time > tempMax then
    begin
      tempMax := tempWeights * tempTimes * users[UserID].Stats[i].Time;
      trainingCompare.CompareForm.maxID := i;
      maxWeights := tempWeights;
      maxTimes := tempTimes;
    end;
  end;

  currentWeights := 0;
  currentTimes := 0;

  for i := 0 to high(users[UserID].Stats[trainingCompare.CompareForm.currentID].Exercises) do
  begin
    currentWeights := CurrentWeights + users[UserID].Stats[trainingCompare.CompareForm.currentID].Exercises[i].Weight * users[UserID].Stats[trainingCompare.CompareForm.currentID].Exercises[i].Times;
    currentTimes := CurrentTimes + users[UserID].Stats[trainingCompare.CompareForm.currentID].Exercises[i].Times
  end;

  trainingCompare.CompareForm.NameOfTheBestTraining.Caption := users[UserID].Stats[trainingCompare.CompareForm.maxID].Name + ' (' + users[UserID].Stats[trainingCompare.CompareForm.maxID].Date + ')';
  trainingCompare.CompareForm.NameOfTheCurrentTraining.Caption := users[UserID].Stats[trainingCompare.CompareForm.currentID].Name + ' (' + users[UserID].Stats[trainingCompare.CompareForm.currentID].Date + ')';

  trainingCompare.CompareForm.BestTime.Caption := intToStr(users[UserID].Stats[trainingCompare.CompareForm.maxID].Time) + ' ��� - ���������� ����� ����������';
  trainingCompare.CompareForm.CurrentTime.Caption := intToStr(users[UserID].Stats[trainingCompare.CompareForm.currentID].Time) + ' ��� - ����� ���������� � ������ ����������';

  trainingCompare.CompareForm.BestTimes.Caption := intToStr(maxTimes) + ' ��� - ������ ���-�� ����������';
  trainingCompare.CompareForm.BestWeight.Caption := intToStr(maxWeights) + ' �� - ������ ����� �������� ���';

  trainingCompare.CompareForm.CurrentTimes.Caption := intToStr(currentTimes) + ' ��� - ���-�� ���������� � ������ ����������';
  trainingCompare.CompareForm.CurrentWeight.Caption := intToStr(currentWeights) + ' �� - ����� �������� ��� � ������ ����������';

  if (MaxTimes = CurrentTimes) and (MaxWeights = CurrentWeights) then
    trainingCompare.CompareForm.Score.Caption := '��� ���� ������ ���������� (������ ����������)'
  else if (MaxTimes * 0.9 < CurrentTimes) or (MaxWeights * 0.9 < CurrentWeights) then
    trainingCompare.CompareForm.Score.Caption := '��� ���������� ������ � ������ ������� (������ ����������)'
  else if (MaxTimes * 0.7 < CurrentTimes) or (MaxWeights * 0.7 < CurrentWeights) then
    trainingCompare.CompareForm.Score.Caption := '�������� �������� ���������� ��� ��� (������ ����������)'
  else if (MaxTimes * 0.5 < CurrentTimes) or (MaxWeights * 0.5 < CurrentWeights) then
    trainingCompare.CompareForm.Score.Caption := '�� ���� ��� �� �������� � ������� (������ ����������)'
  else if (MaxTimes * 0.3 < CurrentTimes) or (MaxWeights * 0.3 < CurrentWeights) then
    trainingCompare.CompareForm.Score.Caption := '����������� ���������� (������ ����������)'
  else if (MaxTimes * 0.1 < CurrentTimes) or (MaxWeights * 0.1 < CurrentWeights) then
    trainingCompare.CompareForm.Score.Caption := '�� ���� ��� ���� ���������� �� ����� ���� �� �������� (������ ����������)'
  else
    trainingCompare.CompareForm.Score.Caption := '��������� ���������� ����������� ������� (������ ����������)';

  trainingCompare.CompareForm.Show;
end;

end.