program Project1;

uses
  Vcl.Forms,
  MainMenu in 'MainMenu.pas' {Menu},
  Vcl.Themes,
  Vcl.Styles,
  Authorization in 'Authorization.pas' {Login},
  defaultexercises in 'defaultexercises.pas',
  Exercises in 'Exercises.pas' {Actions},
  ExsEditing in 'ExsEditing.pas' {EditForm},
  ExsCreating in 'ExsCreating.pas' {CreateForm},
  TrainingCreation in 'TrainingCreation.pas' {CreateTrainingForm},
  ExsAdding in 'ExsAdding.pas' {AddExsForm},
  TrainingChoosing in 'TrainingChoosing.pas' {TrainingChooseForm},
  ExsRealise in 'ExsRealise.pas' {ExsRealiseForm},
  TrainingTime in 'TrainingTime.pas' {TrainingTimeForm},
  TrainingsStats in 'TrainingsStats.pas' {TrainingStatsForm},
  TrainingCompare in 'TrainingCompare.pas' {CompareForm},
  TrainingDetails in 'TrainingDetails.pas' {DetailsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Ruby Graphite');
  Application.CreateForm(TMenu, Menu);
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(TActions, Actions);
  Application.CreateForm(TEditForm, EditForm);
  Application.CreateForm(TCreateForm, CreateForm);
  Application.CreateForm(TCreateTrainingForm, CreateTrainingForm);
  Application.CreateForm(TAddExsForm, AddExsForm);
  Application.CreateForm(TTrainingChooseForm, TrainingChooseForm);
  Application.CreateForm(TExsRealiseForm, ExsRealiseForm);
  Application.CreateForm(TTrainingTimeForm, TrainingTimeForm);
  Application.CreateForm(TTrainingStatsForm, TrainingStatsForm);
  Application.CreateForm(TCompareForm, CompareForm);
  Application.CreateForm(TDetailsForm, DetailsForm);
  Application.Run;
end.
