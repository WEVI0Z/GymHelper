unit TrainingCreation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TCreateTrainingForm = class(TForm)
    NameOfTheTraining: TEdit;
    ExsWrap: TScrollBox;
    AddExs: TButton;
    NameLabel: TLabel;
    CreateTraining: TButton;
    procedure AddExsClick(Sender: TObject);
    procedure CreateTrainingClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreateTrainingForm: TCreateTrainingForm;
  labels: array of TLabel;
  buttons: array of TButton;
  AddedExs: array of TLabel;
  descriptions: array of String;
  checks: array of Boolean;

implementation

uses ExsAdding, Authorization, MainMenu;

{$R *.dfm}

procedure ParseToXML(XMLDoc: TXMLDocument);
var
  i, j, k: Integer;
  currentUser: IXMLNode;
  currentExs: IXMLNode;
  currentTraining: IXMLNode;
  currentStat: IXMLNode;

begin
  XMLDoc.LoadFromFile('users.xml');
  XMLDoc.Active := True;
  XMLDoc.XML.Clear;
  XMLDoc.XML.Add('<main>');
  XMLDoc.XML.Add('</main>');
  XMLDoc.Active := True;

  for i := 0 to length(users) - 1 do
  begin
    XMLDoc.DocumentElement.AddChild('user');
    currentUser := XMLDoc.DocumentElement.ChildNodes.Last;

    currentUser.AddChild('username');
    currentUser.AddChild('password');
    currentUser.AddChild('exercises');
    currentUser.AddChild('trainings');
    currentUser.AddChild('stats');

    currentUser.ChildNodes['username'].Text := users[i].Name;
    currentUser.ChildNodes['password'].Text := users[i].Password;

    for j := 0 to length(users[i].Exercises) - 1 do
    begin
      currentUser.ChildNodes['exercises'].AddChild('exercise');
      currentExs := currentUser.ChildNodes['exercises'].ChildNodes.Last;

      currentExs.AddChild('name');
      currentExs.AddChild('description');
      currentExs.AddChild('isweighted');

      currentExs.ChildNodes['name'].Text := users[i].Exercises[j].Name;
      currentExs.ChildNodes['description'].Text := users[i].Exercises[j].Description;

      if users[i].Exercises[j].IsWeighted = True then
        currentExs.ChildNodes['isweighted'].Text := 'True'
      else
        currentExs.ChildNodes['isweighted'].Text := 'False';
    end;

    for j := 0 to length(users[i].Trainings) - 1 do
    begin
      currentUser.ChildNodes['trainings'].AddChild('training');
      currentTraining := currentUser.ChildNodes['trainings'].ChildNodes.Last;

      currentTraining.AddChild('name');
      currentTraining.ChildNodes['name'].Text := users[i].Trainings[j].Name;

      currentTraining.AddChild('exercises');

      for k := 0 to length(users[i].Trainings[j].Exercises) - 1 do
      begin
        currentUser.ChildNodes['trainings'].ChildNodes.Last.ChildNodes['exercises'].AddChild('exercise');
        currentExs := currentUser.ChildNodes['trainings'].ChildNodes.Last.ChildNodes['exercises'].ChildNodes.Last;

        currentExs.AddChild('name');
        currentExs.AddChild('description');
        currentExs.AddChild('isweighted');

        currentExs.ChildNodes['name'].Text := users[i].Trainings[j].Exercises[k].Name;
        currentExs.ChildNodes['description'].Text := users[i].Trainings[j].Exercises[k].Description;

        if users[i].Trainings[j].Exercises[k].IsWeighted = True then
          currentExs.ChildNodes['isweighted'].Text := 'True'
        else
          currentExs.ChildNodes['isweighted'].Text := 'False';
      end;
    end;

     for j := 0 to length(users[i].Stats) - 1 do
     begin
      currentUser.ChildNodes['stats'].AddChild('completedTraining');
      currentStat := currentUser.ChildNodes['stats'].ChildNodes.Last;

      currentStat.AddChild('name');
      currentStat.AddChild('time');

      currentStat.ChildNodes['name'].Text := users[i].Stats[j].Name;
      currentStat.ChildNodes['date'].Text := users[i].Stats[j].Date;
      currentStat.ChildNodes['time'].Text := intToStr(users[i].Stats[j].Time);

      currentStat.AddChild('completedExercises');

      for k := 0 to length(users[i].Stats[j].Exercises) - 1 do
      begin
        currentUser.ChildNodes['stats'].ChildNodes.Last.ChildNodes['completedExercises'].AddChild('exercise');
        currentExs := currentUser.ChildNodes['stats'].ChildNodes.Last.ChildNodes['completedExercises'].ChildNodes.Last;

        currentExs.AddChild('name');
        currentExs.AddChild('description');
        currentExs.AddChild('isweighted');

        currentExs.ChildNodes['name'].Text := users[i].Stats[j].Exercises[k].Name;
        currentExs.ChildNodes['weight'].Text := intToStr(users[i].Stats[j].Exercises[k].Weight);
        currentExs.ChildNodes['times'].Text := intToStr(users[i].Stats[j].Exercises[k].Times);
      end;
    end;
  end;

  XMLDoc.SaveToFile('users.xml');
end;

procedure TCreateTrainingForm.AddExsClick(Sender: TObject);

var i: integer;

begin
  ExsAdding.AddExsForm.Show;

  setLength(labels, length(users[UserID].Exercises));
  setLength(buttons, length(users[UserID].Exercises));
  ExsAdding.AddExsForm.ExcercisesWrap.DestroyComponents;

  for i := 0 to length(users[UserID].Exercises) - 1 do
  begin
    labels[i] := TLabel.Create(ExsAdding.AddExsForm.ExcercisesWrap);
    labels[i].Parent := ExsAdding.AddExsForm.ExcercisesWrap;
    labels[i].Top := 40 * (i);
    labels[i].Left := 20;
    labels[i].Caption := users[UserID].Exercises[i].Name;
    labels[i].Width := 200;
    labels[i].Height := 30;

    buttons[i] := TButton.Create(ExsAdding.AddExsForm.ExcercisesWrap);
    buttons[i].Parent := ExsAdding.AddExsForm.ExcercisesWrap;
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
    buttons[i].OnClick := ExsAdding.AddExsForm.TempButtonClick;

  ExsAdding.AddExsForm.TempButton.Free;
end;

procedure TCreateTrainingForm.CreateTrainingClick(Sender: TObject);

var index, i : integer;

begin
  index := length(users[UserID].Trainings);

  setLength(users[UserID].Trainings, length(users[UserID].Trainings) + 1);
  setLength(users[UserID].Trainings[index].Exercises, length(AddedExs));

  users[UserID].Trainings[index].Name := NameOfTheTraining.Text;

  for i := 0 to length(AddedExs) - 1 do
  begin
    users[UserID].Trainings[index].Exercises[i].Name := addedExs[i].Caption;
    users[UserID].Trainings[index].Exercises[i].Description := descriptions[i];
    users[UserID].Trainings[index].Exercises[i].IsWeighted := checks[i];
  end;

  ParseToXml(Authorization.Login.UsersXML);

  setLength(addedExs, 0);

  TrainingCreation.CreateTrainingForm.Close;
end;

end.
