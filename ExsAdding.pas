unit ExsAdding;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TAddExsForm = class(TForm)
    ExcercisesWrap: TScrollBox;
    TempButton: TButton;
    procedure TempButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddExsForm: TAddExsForm;

implementation

uses TrainingCreation, Authorization, MainMenu;

{$R *.dfm}

procedure TAddExsForm.TempButtonClick(Sender: TObject);

var i, targetID: integer;

begin
  ExsAdding.AddExsForm.Close;

  setLength(addedExs, length(addedExs) + 1);
  setLength(descriptions, length(addedExs) + 1);
  setLength(checks, length(addedExs) + 1);

  for i := 0 to length(users[UserID].Exercises) - 1 do
    if buttons[i] = Sender then
      targetID := i;

  i := length(addedExs) - 1;

  descriptions[i] := users[UserID].Exercises[targetID].Description;
  checks[i] := users[UserID].Exercises[targetID].IsWeighted;

  addedExs[i] := TLabel.Create(TrainingCreation.CreateTrainingForm.ExsWrap);
  addedExs[i].Parent := TrainingCreation.CreateTrainingForm.ExsWrap;
  addedExs[i].Top := 40 * (i);
  addedExs[i].Left := 5;
  addedExs[i].Caption := users[UserID].Exercises[targetID].Name;
  addedExs[i].Width := 200;
  addedExs[i].Height := 30;

  if i = 0 then
    addedExs[i].Top := 5;
  end;

end.